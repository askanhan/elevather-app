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

        <section class="list">
            <article v-for="track in filteredTracks" :key="track.id" class="trackCard">
                <button class="trackHeader" @click="toggle(track.id)">
                    <div class="left">
                        <div class="badge" :style="{ background: track.color }">{{ track.short }}</div>
                        <div class="headText">
                            <h2 class="trackTitle">{{ track.title }}</h2>
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

                    <button v-for="m in filteredModules(track)" :key="m.title" class="module" @click="goToCourse">
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
                        Partner-created content will replace these placeholders.
                    </p>
                </div>
            </article>
        </section>
    </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: 'JourneyHome',

    data() {
        return {
            query: '',
            statusFilter: 'all',

            // collapsed by default
            openIds: new Set(),

            tracks: [
                {
                    id: 'dare',
                    short: 'I Dare',
                    title: 'I Dare Track',
                    description: 'Confidence, boundaries, visibility, and courage in everyday moments.',
                    pace: '10–15 minutes/day',
                    focus: 'Self-trust & action',
                    color: '#2D6CDF',
                    modules: [
                        {
                            title: 'Micro-Courage',
                            level: 'intro',
                            status: 'done',
                            summary: 'Build courage through tiny, repeatable actions that stretch you safely.',
                            outcomes: ['Name your fear pattern', 'Take one brave micro-step daily', 'Track wins without perfectionism']
                        },
                        {
                            title: 'Boundaries & Saying No',
                            level: 'core',
                            status: 'in_progress',
                            summary: 'Set clear boundaries without guilt, drama, or long explanations.',
                            outcomes: ['Use a 3-sentence boundary script', 'Handle pushback calmly', 'Reduce people-pleasing loops']
                        },
                        {
                            title: 'Visibility: Speak Up',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Practice speaking up with grounded authority in meetings and groups.',
                            outcomes: ['Interrupt interruption', 'Claim contributions', 'Increase leadership presence']
                        }
                    ]
                },

                {
                    id: 'earn',
                    short: 'I Earn',
                    title: 'I Earn Track',
                    description: 'Money clarity, negotiation, career moves, and economic independence.',
                    pace: '2–3 sessions/week',
                    focus: 'Income & leverage',
                    color: '#1F9D63',
                    modules: [
                        {
                            title: 'Your Money Map',
                            level: 'intro',
                            status: 'in_progress',
                            summary: 'Understand your money story, constraints, and what you can influence.',
                            outcomes: ['Identify money beliefs', 'Build a monthly map', 'Pick one leverage point']
                        },
                        {
                            title: 'Negotiation Basics',
                            level: 'core',
                            status: 'not_started',
                            summary: 'Prepare and negotiate without apologizing for your needs.',
                            outcomes: ['Set target & walk-away', 'Use assertive language', 'Negotiate beyond salary']
                        },
                        {
                            title: 'Enterprise Seed',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Turn skills into an offer aligned with socio-ecological transformation.',
                            outcomes: ['Define value proposition', 'Design a small pilot', 'Plan first 10 customers/users']
                        }
                    ]
                },

                {
                    id: 'lead',
                    short: 'I Lead',
                    title: 'I Lead Track',
                    description: 'Ethical power, decision-making, and responsibility without abuse.',
                    pace: 'Weekly deep work',
                    focus: 'Power & responsibility',
                    color: '#8B5CF6',
                    modules: [
                        {
                            title: 'Power Literacy',
                            level: 'intro',
                            status: 'done',
                            summary: 'Reframe power from “bad” to “useful” and learn ethical power patterns.',
                            outcomes: ['Spot power dynamics', 'Name your power style', 'Avoid self-sabotage']
                        },
                        {
                            title: 'Decision-Making Under Pressure',
                            level: 'core',
                            status: 'not_started',
                            summary: 'Make decisions with limited info, manage risk, and stay accountable.',
                            outcomes: ['Use a 5-step framework', 'Communicate decisions clearly', 'Recover from mistakes faster']
                        },
                        {
                            title: 'Leadership in Community',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Lead locally: associations, NGOs, local politics, civic initiatives.',
                            outcomes: ['Build a coalition', 'Run inclusive meetings', 'Turn ideas into action']
                        }
                    ]
                },

                {
                    id: 'speak',
                    short: 'I Speak',
                    title: 'I Speak Track',
                    description: 'Communication, conflict navigation, and influence without shrinking.',
                    pace: '15 minutes/day',
                    focus: 'Voice & relationships',
                    color: '#F59E0B',
                    modules: [
                        {
                            title: 'Communication Foundations',
                            level: 'intro',
                            status: 'done',
                            summary: 'Say more with fewer words: clarity, tone, structure.',
                            outcomes: ['Make clear requests', 'Reduce over-explaining', 'Stay calm in tense moments']
                        },
                        {
                            title: 'Conflict With Care',
                            level: 'core',
                            status: 'in_progress',
                            summary: 'Handle conflict without freezing, fawning, or exploding.',
                            outcomes: ['Name the issue precisely', 'Set limits respectfully', 'Exit unsafe conversations']
                        },
                        {
                            title: 'Influence Through Story',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Use stories to mobilize support without manipulation.',
                            outcomes: ['Craft a personal narrative', 'Pitch ideas clearly', 'Build support networks']
                        }
                    ]
                },

                {
                    id: 'build',
                    short: 'I Build',
                    title: 'I Build Track',
                    description: 'Create initiatives: projects, teams, partnerships, and community impact.',
                    pace: '2 sessions/week',
                    focus: 'Action & execution',
                    color: '#EF4444',
                    modules: [
                        {
                            title: 'From Idea to Pilot',
                            level: 'intro',
                            status: 'not_started',
                            summary: 'Turn a vague idea into a small, testable pilot within two weeks.',
                            outcomes: ['Define a small scope', 'Pick success metrics', 'Recruit 3 pilot participants']
                        },
                        {
                            title: 'Partnership & Stakeholders',
                            level: 'core',
                            status: 'not_started',
                            summary: 'Map allies and blockers, then build support with clear asks.',
                            outcomes: ['Stakeholder map', '1-page partnership pitch', 'Run a first meeting confidently']
                        },
                        {
                            title: 'Sustainable Operations',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Make it last: roles, routines, communication, and sustainable work.',
                            outcomes: ['Define roles & responsibilities', 'Set weekly routines', 'Prevent burnout patterns']
                        }
                    ]
                },

                {
                    id: 'impact',
                    short: 'I Impact',
                    title: 'I Impact Track',
                    description: 'Socio-ecological transformation: systems thinking, civic action, policy literacy.',
                    pace: 'Weekly deep work',
                    focus: 'Society & change',
                    color: '#06B6D4',
                    modules: [
                        {
                            title: 'Systems Thinking Basics',
                            level: 'intro',
                            status: 'not_started',
                            summary: 'Understand how systems behave and where small interventions matter.',
                            outcomes: ['Identify feedback loops', 'Spot leverage points', 'Avoid “quick fix” traps']
                        },
                        {
                            title: 'Civic Action Toolkit',
                            level: 'core',
                            status: 'not_started',
                            summary: 'Take local action: petitions, councils, associations, and public voice.',
                            outcomes: ['Choose one local issue', 'Plan one civic action', 'Build a micro-coalition']
                        },
                        {
                            title: 'Gender Lens in Transformation',
                            level: 'advanced',
                            status: 'not_started',
                            summary: 'Apply a gender-just lens to digitalization and socio-ecological transitions.',
                            outcomes: ['Name gendered impacts', 'Create a critique + proposal', 'Communicate to decision-makers']
                        }
                    ]
                }
            ]
        }
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

        goToCourse() {
            // as you requested: click a course -> go to /course
            // if you prefer by name:
            // this.$router.push({ name: 'course' })
            this.$router.push('/course')
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
    display: block;
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
    /* line-height: 1; */
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