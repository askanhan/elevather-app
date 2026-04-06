<template>
    <div class="simHome">
        <header class="head">
            <div>
                <h1 class="h1">Power Simulator</h1>
                <p class="sub">
                    Practice leadership decisions without real-world risk. Choose a scenario and test your approach.
                </p>
            </div>

            <div class="tools">
                <input v-model="query" class="search" type="search" placeholder="Search scenarios…" />
                <select v-model="level" class="select">
                    <option value="all">All levels</option>
                    <option value="intro">Intro</option>
                    <option value="core">Core</option>
                    <option value="advanced">Advanced</option>
                </select>
            </div>
        </header>

        
        <div v-if="error" class="error-message">
            ⚠️ {{ error }}
        </div>

        
        <div v-if="loading" class="loading">
            Loading simulators...
        </div>

        
        <section v-if="!loading" class="grid">
            <article v-for="s in filtered" :key="s.id" class="card" @click="goPlay(s)">
                <div class="top">
                    <div class="icon">{{ s.icon }}</div>
                    <div class="meta">
                        <div class="title">{{ s.title }}</div>
                        <div class="desc">{{ s.description }}</div>

                        <div class="chips">
                            <span class="chip">{{ labelLevel(s.level) }}</span>
                            <span class="chip">{{ s.duration }}</span>
                            <span class="chip">{{ s.domain }}</span>
                        </div>

                        <div class="tags">
                            <span v-for="t in s.tags" :key="t" class="tag">{{ t }}</span>
                        </div>
                    </div>
                </div>

                <div class="bottom">
                    <button class="btn">Start simulation →</button>
                </div>
            </article>
        </section>

        <!-- if no results -->
        <p v-if="!loading && filtered.length === 0" class="note">
            Simulators not found. Try adjusting your search or filters.
        </p>

        <p v-if="!loading && filtered.length > 0" class="note">
            Data loaded from the database.
        </p>
    </div>
</template>

<script>
import { api } from '@/store/actions.js'

export default {
    name: 'SimulatorHome',

    data() {
        return {
            query: '',
            level: 'all',
            scenarios: [],
            loading: true,
            error: null
        }
    },

    mounted() {
        this.fetchSimulators()
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filtered() {
            const q = this.q
            const lvl = this.level

            return this.scenarios.filter(s => {
                const hay = (s.title + ' ' + s.description + ' ' + s.domain + ' ' + s.tags.join(' ')).toLowerCase()
                const matchQ = q ? hay.includes(q) : true
                const matchL = (lvl === 'all') ? true : (s.level === lvl)
                return matchQ && matchL
            })
        }
    },

    methods: {
        fetchSimulators() {
            this.loading = true
            this.error = null
            api.get('/all-simulators/')
                .then(response => {
                    const data = response.data

                    this.scenarios = data.map(sim => {
                        const tagNames = (sim.tags || []).map(tag => 
                            typeof tag === 'object' ? tag.name : tag
                        )

                        return {
                            id: sim.id,
                            icon: '🎯', 
                            title: sim.title,
                            description: sim.description || '',
                            level: sim.level || 'intro',
                            duration: sim.estimated_duration ? `${sim.estimated_duration} min` : 'N/A',
                            domain: sim.localisation || 'General',
                            tags: tagNames
                        }
                    })

                    this.loading = false
                })
                .catch(err => {
                    console.error('Error while fetching simulators:', err)
                    this.error = 'Impossible to load simulators. Please try again later.'
                    this.loading = false
                })
        },

        labelLevel(l) {
            if (l === 'intro') return 'Intro'
            if (l === 'core') return 'Core'
            return 'Advanced'
        },

        goPlay(s) {
            this.$router.push({ path: '/simulator/play', query: { id: s.id } })
        }
    }
}
</script>

<style scoped>
.simHome {
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px 16px 44px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
    color: #0f172a;
}

.head {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 14px;
}

.h1 {
    margin: 0 0 6px;
    font-size: 28px;
    font-weight: 900;
}

.sub {
    margin: 0;
    color: #475569;
    max-width: 640px;
    line-height: 1.35;
}

.tools {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    align-items: center;
}

.search {
    min-width: 260px;
    width: 320px;
    max-width: 100%;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 10px 12px;
    outline: none;
    background: #fff;
}

.select {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 10px 12px;
    background: #fff;
}

.grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
}

@media (max-width: 860px) {
    .grid {
        grid-template-columns: 1fr;
    }
}

.card {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    padding: 14px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    cursor: pointer;
    transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.card:hover {
    transform: translateY(-1px);
    box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
    border-color: #cbd5e1;
}

.top {
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.icon {
    font-size: 34px;
    width: 44px;
    height: 44px;
    display: grid;
    place-items: center;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #fbfdff;
}

.meta {
    min-width: 0;
    flex: 1;
}

.title {
    font-weight: 900;
    font-size: 16px;
    margin-bottom: 6px;
}

.desc {
    color: #475569;
    line-height: 1.35;
    margin-bottom: 10px;
}

.chips {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    margin-bottom: 8px;
}

.chip {
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
}

.tags {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.tag {
    font-size: 12px;
    font-weight: 900;
    color: #0f172a;
    border: 1px solid #e2e8f0;
    background: #fff;
    padding: 6px 10px;
    border-radius: 999px;
}

.bottom {
    margin-top: 12px;
    display: flex;
    justify-content: flex-end;
}

.btn {
    border: 1px solid #0f172a;
    background: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
}

.note {
    margin-top: 12px;
    color: #64748b;
    font-size: 12px;
}

.loading {
    text-align: center;
    padding: 40px 20px;
    color: #64748b;
    font-size: 16px;
}

.error-message {
    background-color: #fee2e2;
    color: #991b1b;
    padding: 12px 16px;
    border-radius: 8px;
    border-left: 4px solid #dc2626;
    margin-bottom: 20px;
    font-size: 14px;
}
</style>