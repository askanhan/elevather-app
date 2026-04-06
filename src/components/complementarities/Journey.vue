<!-- src/views/JourneyHome.vue -->
<template>
    <div class="journey">
        <header class="top">
            <div>
                <h1 class="title">Journey</h1>
                <p class="subtitle">
                    Pick a track, open it, and choose a module. Progress is visible at a glance.
                </p>
            </div>

            <div class="actions">
                <input v-model="query" class="search" type="search" placeholder="Search tracks, modules, outcomes…"
                    aria-label="Search" />

                <select v-model="statusFilter" class="select" aria-label="Status filter">
                    <option value="all">All statuses</option>
                    <option value="done">Done</option>
                    <option value="in_progress">In progress</option>
                    <option value="not_started">Not started</option>
                </select>
            </div>
        </header>

        <!-- Loading state -->
        <div v-if="loading" class="loading-message">
            Loading journey...
        </div>

        <!-- Error state -->
        <div v-if="error" class="error-message">
            ⚠️ {{ error }}
        </div>

        <!-- Content -->
        <section v-if="!loading" class="list">
            <article v-for="track in filteredTracks" :key="track.id" class="trackCard">
                <button class="trackHeader" @click="toggle(track.id)">
                    <div class="left">
                        <div class="badge" :style="{ background: track.color }">{{ track.short }}</div>
                        <div class="headText">
                            <h2 class="trackTitle">{{ track.title }} Track</h2>
                            <p class="trackDesc">{{ track.description }}</p>
                            <div class="trackMeta">
                                <span class="metaChip">Suggested pace: {{ track.pace }}</span>
                                <span class="metaChip">Focus: {{ track.focus }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="right">
                        <div class="progress">
                            <div class="progressTop">
                                <span class="progressLabel">Completed</span>
                                <span class="progressValue">{{ completedCount(track) }}/{{ track.modules.length
                                }}</span>
                            </div>
                            <div class="bar">
                                <div class="barFill"
                                    :style="{ width: completionPercent(track) + '%', background: track.color }"></div>
                            </div>
                        </div>

                        <div class="chev" :class="{ open: isOpen(track.id) }">⌄</div>
                    </div>
                </button>

                <div v-show="isOpen(track.id)" class="trackBody">
                    <h3 class="sectionTitle">Modules</h3>

                    <button v-for="m in filteredModules(track)" :key="m.id" class="module" @click="goToCourse(m)">
                        <div class="moduleTop">
                            <div class="moduleTitleRow">
                                <div class="moduleTitleWrap">
                                    <span class="moduleTitle">{{ m.title }}</span>
                                    <span class="pill" :class="pillClass(m.level)">{{ levelLabel(m.level) }}</span>
                                </div>

                                <span class="status" :class="statusClass(m.status)">
                                    <span class="dot"></span>
                                    {{ statusLabel(m.status) }}
                                </span>
                            </div>

                            <p class="moduleDesc">{{ m.summary }}</p>
                        </div>

                        <div class="moduleBottom">
                            <div class="outcomes">
                                <span class="outcomesLabel">Outcomes:</span>
                                <span class="outcomesText">{{ m.outcomes.join(" • ") }}</span>
                            </div>

                            <div class="cta">
                                <span>Open course</span>
                                <span class="arrow">→</span>
                            </div>
                        </div>
                    </button>

                    <p class="note">
                        All categories and modules loaded from the database.
                    </p>
                </div>
            </article>
        </section>
    </div>
</template>

<script>
import { api } from '@/store/actions.js'

const colors = ['#2D6CDF', '#1F9D63', '#8B5CF6', '#F59E0B', '#EF4444', '#06B6D4']

export default {
    name: 'JourneyHome',

    data() {
        return {
            query: '',
            statusFilter: 'all',

            // collapsed by default
            openIds: new Set(),

            // API data
            loading: true,
            error: null,
            categories: [],
            modules: [],
            tracks: []
        }
    },

    mounted() {
        this.fetchData()
    },

    computed: {
        normalizedQuery() {
            return (this.query || '').trim().toLowerCase()
        },

        filteredTracks() {
            const q = this.normalizedQuery
            const s = this.statusFilter

            return this.tracks
                .map(t => {
                    const modules = (t.modules || []).filter(m => {
                        const hay = (
                            (t.title || '') + ' ' +
                            (t.description || '') + ' ' +
                            (m.title || '') + ' ' +
                            (m.summary || '') + ' ' +
                            ((m.outcomes || []).join(' '))
                        ).toLowerCase()

                        const matchesQuery = q ? hay.includes(q) : true
                        const matchesStatus = s === 'all' ? true : (m.status === s)
                        return matchesQuery && matchesStatus
                    })

                    return { ...t, modules }
                })
                .filter(t => (t.modules || []).length > 0)
        }
    },

    methods: {
        // Fetch categories and modules from API
        fetchData() {
            this.loading = true
            this.error = null

            Promise.all([
                api.get('/categories/'),
                api.get('/all-modules/')
            ])
                .then(([categoriesRes, modulesRes]) => {
                    this.categories = categoriesRes.data || []
                    this.modules = modulesRes.data || []

                    // Transform categories and modules into tracks
                    this.tracks = this.transformToTracks(this.categories, this.modules)
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching data:', err)
                    this.error = 'Failed to load categories and modules.'
                    this.loading = false
                })
        },

        // Transform API data into tracks structure
        transformToTracks(categories, modules) {
            if (!categories || categories.length === 0) return []

            // Map modules by category ID
            const modulesByCategory = {}
            modules.forEach(mod => {
                const catId = mod.module_category_id
                if (!modulesByCategory[catId]) {
                    modulesByCategory[catId] = []
                }
                modulesByCategory[catId].push(mod)
            })

            // Create tracks from categories
            return categories.map((cat, idx) => {
                const catModules = modulesByCategory[cat.id] || []

                // Generate short name from title (first 2 words)
                const titleWords = cat.title.split(' ')
                const short = titleWords.slice(0, 2).join(' ')

                return {
                    id: `category_${cat.id}`,
                    short: short,
                    title: cat.title,
                    description: cat.description || 'Learning modules for this category',
                    pace: '10–15 minutes/day',
                    focus: 'Core learning',
                    color: colors[idx % colors.length],
                    modules: catModules.map(mod => ({
                        id: mod.id,
                        title: mod.title,
                        level: this.determineLevelFromDay(mod.day_number),
                        status: 'not_started',
                        summary: mod.description || 'Module content',
                        outcomes: mod.target_audience ? [mod.target_audience] : ['Learn and practice']
                    }))
                }
            })
        },

        // Determine level based on day number
        determineLevelFromDay(dayNum) {
            if (dayNum <= 3) return 'intro'
            if (dayNum <= 7) return 'core'
            return 'advanced'
        },

        toggle(id) {
            const s = new Set(this.openIds)
            if (s.has(id)) s.delete(id)
            else s.add(id)
            this.openIds = s
        },

        filteredModules(track) {
            return (track && track.modules) ? track.modules : []
        },

        isOpen(id) {
            return this.openIds && this.openIds.has(id)
        },

        goToCourse(module) {
            this.$router.push({ path: '/course', query: { id: module.id } })
        },

        completedCount(track) {
            const mods = (track && track.modules) ? track.modules : []
            return mods.filter(m => m.status === 'done').length
        },

        completionPercent(track) {
            const mods = (track && track.modules) ? track.modules : []
            const total = mods.length || 1
            return Math.round((this.completedCount(track) / total) * 100)
        },

        levelLabel(level) {
            if (level === 'intro') return 'Intro'
            if (level === 'core') return 'Core'
            return 'Advanced'
        },

        pillClass(level) {
            return {
                intro: level === 'intro',
                core: level === 'core',
                advanced: level === 'advanced'
            }
        },

        statusLabel(status) {
            if (status === 'done') return 'Done'
            if (status === 'in_progress') return 'In progress'
            return 'Not started'
        },

        statusClass(status) {
            return {
                done: status === 'done',
                in_progress: status === 'in_progress',
                not_started: status === 'not_started'
            }
        }
    }
}
</script>

<style scoped>
.journey {
    max-width: 1100px;
    margin: 0 auto;
    padding: 28px 18px 44px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji",
        "Segoe UI Emoji";
}

.top {
    display: flex;
    gap: 14px;
    align-items: flex-start;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-bottom: 16px;
}

.title {
    font-size: 28px;
    font-weight: 900;
    margin: 0 0 6px 0;
}

.subtitle {
    margin: 0;
    color: #475569;
    max-width: 640px;
    line-height: 1.35;
}

.actions {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap;
}

.search {
    min-width: 280px;
    width: 340px;
    max-width: 100%;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 10px 12px;
    outline: none;
    background: #fff;
}

.search:focus {
    border-color: #94a3b8;
}

.select {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 10px 12px;
    background: #fff;
    color: #0f172a;
}

.loading-message,
.error-message {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 200px;
    font-size: 16px;
    font-weight: 900;
    color: #475569;
    text-align: center;
    padding: 20px;
}

.error-message {
    color: #dc2626;
    background: #fee2e2;
    border: 1px solid #fecaca;
    border-radius: 12px;
    margin: 12px 0;
}

.list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.trackCard {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    overflow: hidden;
}

.trackHeader {
    width: 100%;
    text-align: left;
    border: 0;
    background: #fff;
    cursor: pointer;
    padding: 14px;
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 12px;
}

.left {
    display: flex;
    gap: 12px;
    align-items: flex-start;
    min-width: 0;
    flex: 1;
}

.badge {
    color: #fff;
    font-weight: 900;
    border-radius: 12px;
    padding: 8px 10px;
    min-width: 74px;
    text-align: center;
    flex: 0 0 auto;
}

.headText {
    min-width: 0;
    flex: 1;
}

.trackTitle {
    margin: 0 0 6px 0;
    font-size: 18px;
    font-weight: 900;
    color: #0f172a;
}

.trackDesc {
    margin: 0;
    color: #475569;
    line-height: 1.35;
}

.trackMeta {
    margin-top: 8px;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.metaChip {
    font-size: 12px;
    color: #0f172a;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 6px 10px;
    border-radius: 999px;
    font-weight: 800;
}

.right {
    display: flex;
    gap: 10px;
    align-items: center;
    flex: 0 0 auto;
}

.progress {
    width: 150px;
    max-width: 38vw;
    height: 2rem;
}

.progressTop {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 6px;
}

.progressLabel {
    font-size: 12px;
    color: #64748b;
    font-weight: 800;
}

.progressValue {
    font-size: 12px;
    color: #0f172a;
    font-weight: 900;
}

.bar {
    height: 10px;
    border-radius: 999px;
    background: #f1f5f9;
    overflow: hidden;
    border: 1px solid #e2e8f0;
}

.barFill {
    height: 100%;
    width: 0%;
}

.chev {
    font-size: 22px;
    color: #0f172a;
    transform: rotate(0deg);
    transition: transform 0.12s ease;
    margin-top: 2px;
}

.chev.open {
    transform: rotate(180deg);
}

.trackBody {
    border-top: 1px solid #e2e8f0;
    padding: 14px;
    background: #fbfdff;
}

.sectionTitle {
    margin: 0 0 10px;
    font-size: 14px;
    font-weight: 900;
    color: #0f172a;
}

.module {
    width: 100%;
    text-align: left;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 12px;
    background: #fff;
    cursor: pointer;
    margin-bottom: 10px;
    transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.module:hover {
    transform: translateY(-1px);
    box-shadow: 0 8px 18px rgba(15, 23, 42, 0.06);
    border-color: #cbd5e1;
}

.moduleTop {
    margin-bottom: 10px;
}

.moduleTitleRow {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.moduleTitleWrap {
    display: inline-flex;
    gap: 8px;
    align-items: center;
    flex-wrap: wrap;
}

.moduleTitle {
    font-weight: 900;
    color: #0f172a;
}

.pill {
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
    color: #0f172a;
}

.pill.intro {
    background: #eff6ff;
}

.pill.core {
    background: #ecfeff;
}

.pill.advanced {
    background: #fefce8;
}

.status {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 12px;
    font-weight: 900;
    border: 1px solid #e2e8f0;
    background: #fff;
    padding: 6px 10px;
    border-radius: 999px;
    color: #0f172a;
}

.status .dot {
    width: 9px;
    height: 9px;
    border-radius: 999px;
    background: #94a3b8;
}

.status.done {
    background: #f0fdf4;
    border-color: #bbf7d0;
}

.status.done .dot {
    background: #22c55e;
}

.status.in_progress {
    background: #eff6ff;
    border-color: #bfdbfe;
}

.status.in_progress .dot {
    background: #3b82f6;
}

.status.not_started {
    background: #f8fafc;
    border-color: #e2e8f0;
}

.moduleDesc {
    margin: 8px 0 0;
    color: #475569;
    line-height: 1.35;
}

.moduleBottom {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.outcomes {
    max-width: 620px;
}

.outcomesLabel {
    font-size: 12px;
    color: #64748b;
    font-weight: 800;
    margin-right: 6px;
}

.outcomesText {
    color: #334155;
    font-size: 13px;
}

.cta {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-weight: 900;
    color: #0f172a;
}

.arrow {
    font-size: 16px;
}

.note {
    margin: 6px 0 0;
    color: #64748b;
    font-size: 12px;
}
</style>
