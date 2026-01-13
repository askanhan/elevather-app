<template>
    <div class="sm">
        <header class="head">
            <div>
                <h1 class="h1">Stories &amp; Models</h1>
                <p class="sub">
                    Inspiration (stories) and practical frameworks (models). Partner-created content will replace these
                    placeholders.
                </p>
            </div>

            <div class="tools">
                <input v-model="query" class="search" type="search" placeholder="Search stories, people, topics…" />
                <select v-model="typeFilter" class="select" aria-label="Type filter">
                    <option value="all">All types</option>
                    <option value="bio">Bios</option>
                    <option value="article">Articles</option>
                    <option value="video">Videos</option>
                    <option value="model">Models</option>
                </select>
            </div>
        </header>

        <div class="tabs">
            <button class="tab" :class="{ on: activeTab === 'stories' }" @click="activeTab = 'stories'">
                Stories
            </button>
            <button class="tab" :class="{ on: activeTab === 'models' }" @click="activeTab = 'models'">
                Models
            </button>
        </div>

        <!-- STORIES -->
        <section v-if="activeTab === 'stories'" class="section">
            <div class="sectionHead">
                <h2 class="h2">Stories</h2>
                <p class="hint">Short bios, articles, and videos to spark courage and reflection.</p>
            </div>

            <div class="group">
                <button class="groupHead" @click="toggle('bios')">
                    <span class="gTitle">Bios</span>
                    <span class="gMeta">{{ filteredBios.length }}</span>
                    <span class="chev" :class="{ open: isOpen('bios') }">⌄</span>
                </button>

                <div v-show="isOpen('bios')" class="grid">
                    <article v-for="b in filteredBios" :key="b.id" class="card" @click="openStory(b)">
                        <div class="cardTop">
                            <div class="avatar">{{ b.avatar }}</div>
                            <div class="cardText">
                                <div class="title">{{ b.name }}</div>
                                <div class="meta">{{ b.role }} · {{ b.country }}</div>
                                <div class="desc">{{ b.summary }}</div>
                            </div>
                        </div>
                        <div class="cardBottom">
                            <div class="tags">
                                <span v-for="t in b.tags" :key="t" class="tag">{{ t }}</span>
                            </div>
                            <div class="cta">Open bio →</div>
                        </div>
                    </article>
                </div>
            </div>

            <div class="group">
                <button class="groupHead" @click="toggle('articles')">
                    <span class="gTitle">Articles</span>
                    <span class="gMeta">{{ filteredArticles.length }}</span>
                    <span class="chev" :class="{ open: isOpen('articles') }">⌄</span>
                </button>

                <div v-show="isOpen('articles')" class="grid">
                    <article v-for="a in filteredArticles" :key="a.id" class="card" @click="openStory(a)">
                        <div class="cardTop">
                            <div class="thumb">📰</div>
                            <div class="cardText">
                                <div class="title">{{ a.title }}</div>
                                <div class="meta">{{ a.readTime }} · {{ a.topic }}</div>
                                <div class="desc">{{ a.summary }}</div>
                            </div>
                        </div>
                        <div class="cardBottom">
                            <div class="tags">
                                <span v-for="t in a.tags" :key="t" class="tag">{{ t }}</span>
                            </div>
                            <div class="cta">Read →</div>
                        </div>
                    </article>
                </div>
            </div>

            <div class="group">
                <button class="groupHead" @click="toggle('videos')">
                    <span class="gTitle">Videos</span>
                    <span class="gMeta">{{ filteredVideos.length }}</span>
                    <span class="chev" :class="{ open: isOpen('videos') }">⌄</span>
                </button>

                <div v-show="isOpen('videos')" class="grid">
                    <article v-for="v in filteredVideos" :key="v.id" class="card" @click="openStory(v)">
                        <div class="cardTop">
                            <div class="thumb">🎬</div>
                            <div class="cardText">
                                <div class="title">{{ v.title }}</div>
                                <div class="meta">{{ v.duration }} · {{ v.topic }}</div>
                                <div class="desc">{{ v.summary }}</div>
                            </div>
                        </div>
                        <div class="cardBottom">
                            <div class="tags">
                                <span v-for="t in v.tags" :key="t" class="tag">{{ t }}</span>
                            </div>
                            <div class="cta">Watch →</div>
                        </div>
                    </article>
                </div>
            </div>
        </section>

        <!-- MODELS -->
        <section v-else class="section">
            <div class="sectionHead">
                <h2 class="h2">Models</h2>
                <p class="hint">Reusable frameworks: scripts, checklists, and decision tools.</p>
            </div>

            <div class="grid">
                <article v-for="m in filteredModels" :key="m.id" class="card" @click="openModel(m)">
                    <div class="cardTop">
                        <div class="modelIcon">{{ m.icon }}</div>
                        <div class="cardText">
                            <div class="title">{{ m.title }}</div>
                            <div class="meta">{{ m.format }} · {{ m.focus }}</div>
                            <div class="desc">{{ m.summary }}</div>
                        </div>
                    </div>

                    <div class="panel">
                        <div class="panelTitle">Inside</div>
                        <ul class="ul">
                            <li v-for="(b, idx) in m.includes" :key="idx">{{ b }}</li>
                        </ul>
                    </div>

                    <div class="cardBottom">
                        <div class="tags">
                            <span v-for="t in m.tags" :key="t" class="tag">{{ t }}</span>
                        </div>
                        <div class="cta">Open model →</div>
                    </div>
                </article>
            </div>
        </section>

        <p class="note">
            Tip: Later we can connect “Models” to the Power Simulator debrief: after a scenario, recommend a model + a
            course.
        </p>
    </div>
</template>

<script>
export default {
    name: 'StoriesModels',

    data() {
        return {
            activeTab: 'stories',
            query: '',
            typeFilter: 'all',

            // collapsed sections: open none by default (presentation-friendly)
            openIds: new Set(),

            bios: [
                { id: 'b1', type: 'bio', avatar: '👩‍💼', name: 'Nora', role: 'NGO coordinator', country: 'Belgium', summary: 'From quiet contributor to community organiser through small brave asks.', tags: ['I Dare', 'Community', 'Boundaries'] },
                { id: 'b2', type: 'bio', avatar: '👩‍🔧', name: 'Leila', role: 'Manufacturing supervisor', country: 'Germany', summary: 'Learned to lead ethically while handling resistance and pressure.', tags: ['I Lead', 'Ethical power', 'Decisions'] },
                { id: 'b3', type: 'bio', avatar: '👩‍💻', name: 'Mina', role: 'Product designer', country: 'Turkey', summary: 'Built confidence in meetings and negotiated better roles without burnout.', tags: ['I Speak', 'I Earn', 'Visibility'] }
            ],

            articles: [
                { id: 'a1', type: 'article', title: 'The 3-Sentence Boundary Script', readTime: '4 min', topic: 'Boundaries', summary: 'A simple structure to say no without guilt or drama.', tags: ['Boundaries', 'I Dare'] },
                { id: 'a2', type: 'article', title: 'Ethical Power: Leading Without Abuse', readTime: '6 min', topic: 'Leadership', summary: 'Power isn’t the problem. Unexamined power is.', tags: ['I Lead', 'Ethical power'] },
                { id: 'a3', type: 'article', title: 'Gender Lens in Digital Transformation', readTime: '7 min', topic: 'Society & Change', summary: 'How automation and AI can silently reproduce inequalities and what to do.', tags: ['I Impact', 'Digital'] }
            ],

            videos: [
                { id: 'v1', type: 'video', title: 'Calm Delivery Practice', duration: '2:10', topic: 'Communication', summary: 'Tone and pacing that make your boundary land.', tags: ['I Speak', 'Boundaries'] },
                { id: 'v2', type: 'video', title: 'Negotiation Without Apology', duration: '3:40', topic: 'Money & Work', summary: 'A quick prep checklist before you negotiate.', tags: ['I Earn', 'Negotiation'] }
            ],

            models: [
                {
                    id: 'm1',
                    type: 'model',
                    icon: '🧩',
                    title: 'Boundary Script Builder',
                    format: 'Template',
                    focus: 'Everyday boundaries',
                    summary: 'Create a calm, short boundary message in under 60 seconds.',
                    includes: ['Situation → Limit → Alternative', 'Pushback responses', 'Tone guidance'],
                    tags: ['Boundaries', 'I Dare', 'I Speak']
                },
                {
                    id: 'm2',
                    type: 'model',
                    icon: '⚖️',
                    title: 'Ethical Power Checklist',
                    format: 'Checklist',
                    focus: 'Leadership decisions',
                    summary: 'A quick scan to avoid harm and improve fairness before you decide.',
                    includes: ['Who benefits / who pays', 'Consent & transparency', 'Accountability step'],
                    tags: ['I Lead', 'Ethical power']
                },
                {
                    id: 'm3',
                    type: 'model',
                    icon: '🗺️',
                    title: 'Systems Change Map',
                    format: 'Canvas',
                    focus: 'Socio-ecological transformation',
                    summary: 'Map actors, incentives, and leverage points for a local issue.',
                    includes: ['Stakeholders', 'Feedback loops', 'Leverage points'],
                    tags: ['I Impact', 'Civic action']
                }
            ]
        }
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filteredBios() {
            return this.filterList(this.bios)
        },
        filteredArticles() {
            return this.filterList(this.articles)
        },
        filteredVideos() {
            return this.filterList(this.videos)
        },
        filteredModels() {
            return this.filterList(this.models)
        }
    },

    methods: {
        toggle(id) {
            const s = new Set(this.openIds)
            if (s.has(id)) s.delete(id)
            else s.add(id)
            this.openIds = s
        },

        isOpen(id) {
            return this.openIds && this.openIds.has(id)
        },

        filterList(list) {
            const q = this.q
            const tf = this.typeFilter

            return (list || []).filter(x => {
                const hay = (
                    (x.title || '') + ' ' +
                    (x.name || '') + ' ' +
                    (x.summary || '') + ' ' +
                    (x.topic || '') + ' ' +
                    (x.role || '') + ' ' +
                    (x.country || '') + ' ' +
                    ((x.tags || []).join(' ')) + ' ' +
                    ((x.includes || []).join(' '))
                ).toLowerCase()

                const matchQ = q ? hay.includes(q) : true
                const matchT = (tf === 'all') ? true : (x.type === tf)
                return matchQ && matchT
            })
        },

        openStory(item) {
            // mock route — you can swap to { name: 'story' } later
            this.$router.push('/story')
        },

        openModel(item) {
            this.$router.push('/model')
        }
    }
}
</script>

<style scoped>
.sm {
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px 16px 44px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
    color: #0f172a;
}

.head {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 12px;
}

.h1 {
    margin: 0 0 6px;
    font-size: 28px;
    font-weight: 900;
}

.sub {
    margin: 0;
    color: #475569;
    max-width: 680px;
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
    width: 340px;
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

.tabs {
    display: inline-flex;
    gap: 8px;
    padding: 6px;
    border: 1px solid #e2e8f0;
    border-radius: 999px;
    background: #fff;
    margin-bottom: 12px;
}

.tab {
    border: 0;
    background: transparent;
    padding: 10px 14px;
    border-radius: 999px;
    font-weight: 900;
    cursor: pointer;
    color: #334155;
}

.tab.on {
    background: #0f172a;
    color: #fff;
}

.sectionHead {
    margin-bottom: 10px;
}

.h2 {
    margin: 0 0 6px;
    font-size: 18px;
    font-weight: 900;
}

.hint {
    margin: 0;
    color: #64748b;
}

.group {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.groupHead {
    width: 100%;
    border: 0;
    background: #fff;
    padding: 12px 14px;
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    text-align: left;
}

.gTitle {
    font-weight: 900;
}

.gMeta {
    margin-left: auto;
    font-size: 12px;
    font-weight: 900;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
    padding: 6px 10px;
    border-radius: 999px;
}

.chev {
    font-size: 20px;
    transform: rotate(0deg);
    transition: transform 0.12s ease;
}

.chev.open {
    transform: rotate(180deg);
}

.grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
    padding: 12px;
    border-top: 1px solid #e2e8f0;
    background: #fbfdff;
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
    cursor: pointer;
    transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.card:hover {
    transform: translateY(-1px);
    box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
    border-color: #cbd5e1;
}

.cardTop {
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.avatar,
.thumb,
.modelIcon {
    width: 46px;
    height: 46px;
    display: grid;
    place-items: center;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #fbfdff;
    font-size: 22px;
    flex: 0 0 auto;
}

.cardText {
    min-width: 0;
    flex: 1;
}

.title {
    font-weight: 900;
    margin-bottom: 6px;
}

.meta {
    color: #64748b;
    font-size: 12px;
    font-weight: 900;
    margin-bottom: 8px;
}

.desc {
    color: #475569;
    line-height: 1.35;
}

.panel {
    margin-top: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #fbfdff;
    padding: 12px;
}

.panelTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 8px;
}

.ul {
    margin: 0;
    padding-left: 18px;
    color: #334155;
}

.cardBottom {
    margin-top: 12px;
    display: flex;
    gap: 10px;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
}

.tags {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.tag {
    font-size: 12px;
    font-weight: 900;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
    padding: 6px 10px;
    border-radius: 999px;
}

.cta {
    font-weight: 900;
    color: #0f172a;
}

.note {
    margin-top: 10px;
    color: #64748b;
    font-size: 12px;
}
</style>