<!-- src/views/Stories.vue -->
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

        <!-- Main tabs: Stories / Models -->
        <div class="tabs">
            <button class="tab" :class="{ on: activeTab === 'stories' }" @click="activeTab = 'stories'">
                Stories
            </button>
            <button class="tab" :class="{ on: activeTab === 'models' }" @click="activeTab = 'models'">
                Models
            </button>
        </div>

        <section v-if="activeTab === 'stories'" class="section">

            <!-- Community tabs: Real Stories / Share your story -->
            <div class="subtabs">
                <button class="subtab" :class="{ on: storiesTab === 'fromus' }" @click="storiesTab = 'fromus'">
                    From Us
                </button>
                <button class="subtab" :class="{ on: storiesTab === 'real' }" @click="storiesTab = 'real'">
                    Real Stories
                </button>
                <button class="subtab" :class="{ on: storiesTab === 'share' }" @click="storiesTab = 'share'">
                    Share your story
                </button>
            </div>


            <!-- STORIES -->
            <div v-if="storiesTab === 'fromus'" class="fromusStories">

                <!-- Existing partner content (collapsible groups) -->
                <div class="sectionHead spaced">
                    <h2 class="h2">Partner stories</h2>
                    <p class="hint">Bios, articles, and videos to spark courage and reflection.</p>
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
            </div>

            <!-- Real Stories feed -->
            <div v-if="storiesTab === 'real'" class="realStories">

                <div class="sectionHead">
                    <h2 class="h2">Real Stories</h2>
                    <p class="hint">Anonymous one-liners from real life. No “likes”. Only “I relate” and “Support”.</p>
                </div>

                <div class="feed">
                    <article v-for="p in filteredPool" :key="p.id" class="post">
                        <div class="postHead">
                            <div class="anon">
                                <span class="anonDot"></span>
                                <span class="anonTxt">Anonymous</span>
                            </div>
                            <div class="postMeta">
                                <span class="chip">{{ p.track }}</span>
                                <span class="chip">{{ p.when }}</span>
                            </div>
                        </div>

                        <div class="postBody">
                            <div class="postText">{{ p.text }}</div>

                            <div v-if="p.tags && p.tags.length" class="tagRow">
                                <span v-for="t in p.tags" :key="t" class="tag">{{ t }}</span>
                            </div>
                        </div>

                        <div class="postActions">
                            <button class="pillBtn" :class="{ on: reacted(p.id, 'relate') }"
                                @click="toggleReaction(p.id, 'relate')">
                                <span class="ic">🤝</span>
                                <span>I relate</span>
                                <span class="count">{{ p.relate }}</span>
                            </button>

                            <button class="pillBtn" :class="{ on: reacted(p.id, 'support') }"
                                @click="toggleReaction(p.id, 'support')">
                                <span class="ic">💗</span>
                                <span>Support</span>
                                <span class="count">{{ p.support }}</span>
                            </button>

                            <button class="pillBtn ghost" @click="openComments(p)">
                                <span class="ic">💬</span>
                                <span>Reply</span>
                            </button>
                        </div>
                    </article>
                </div>

                <div class="miniTip">
                    Tip: later we can connect this feed to Power Simulator outcomes (recommend a model + a course).
                </div>
            </div>

            <!-- Share your story -->
            <div v-if="storiesTab === 'share'" class="shareStory">

                <div class="sectionHead">
                    <h2 class="h2">Share your story</h2>
                    <p class="hint">
                        This will be posted anonymously. Keep it short and real. One moment is enough.
                    </p>
                </div>

                <div class="shareCard">
                    <div class="anonBanner">
                        <span class="anonShield">🛡️</span>
                        <div class="anonBannerTxt">
                            <div class="anonTitle">Anonymous by default</div>
                            <div class="anonDesc">We do not show names. In the real app, we would also review harmful
                                content.</div>
                        </div>
                    </div>

                    <label class="lbl">Your one-liner</label>
                    <textarea v-model="newStory.text" class="ta" maxlength="220"
                        placeholder="Example: “I said no to my boss today and I didn’t explain for 10 minutes.”"></textarea>

                    <div class="row">
                        <div class="field">
                            <label class="lbl">Track</label>
                            <select v-model="newStory.track" class="select2">
                                <option value="I Dare">I Dare</option>
                                <option value="I Speak">I Speak</option>
                                <option value="I Earn">I Earn</option>
                                <option value="I Lead">I Lead</option>
                                <option value="I Impact">I Impact</option>
                            </select>
                        </div>

                        <div class="field">
                            <label class="lbl">Context</label>
                            <select v-model="newStory.context" class="select2">
                                <option value="Work">Work</option>
                                <option value="Family">Family</option>
                                <option value="Community">Community</option>
                                <option value="Self">Self</option>
                            </select>
                        </div>
                    </div>

                    <label class="lbl">Optional tags (mock)</label>
                    <div class="chipsPick">
                        <button v-for="t in tagOptions" :key="t" class="pick" :class="{ on: newStory.tags.includes(t) }"
                            @click="toggleTag(t)" type="button">
                            {{ t }}
                        </button>
                    </div>

                    <div class="shareBottom">
                        <div class="counter">{{ (newStory.text || '').length }}/220</div>
                        <button class="send" :disabled="!canSend" @click="submitStory">
                            Share anonymously
                        </button>
                    </div>

                    <div v-if="sent" class="sent">
                        ✅ Submitted (mock). In the real app, this would appear in “Real Stories” after review.
                    </div>
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

            <p class="note">
                Tip: Later we can connect “Models” to the Power Simulator debrief: after a scenario, recommend a model +
                a course.
            </p>
        </section>

    </div>
</template>

<script>
export default {
    name: 'StoriesModels',

    data() {
        return {
            activeTab: 'stories',
            storiesTab: 'real',

            query: '',
            typeFilter: 'all',

            openIds: new Set(),

            // --- Anonymous Story Pool (mock) ---
            pool: [
                { id: 'p1', text: 'I said no to my boss today… and I didn’t explain for 10 minutes.', track: 'I Dare', when: 'Today', tags: ['Boundaries', 'Work'], relate: 21, support: 14 },
                { id: 'p2', text: 'I asked for money. My voice shook, but I asked anyway.', track: 'I Earn', when: 'Yesterday', tags: ['Negotiation'], relate: 34, support: 29 },
                { id: 'p3', text: 'I froze in a meeting, then I came back and said: “Let me finish my point.”', track: 'I Speak', when: 'This week', tags: ['Meetings', 'Visibility'], relate: 18, support: 22 },
                { id: 'p4', text: 'I didn’t take the “helper” role automatically. I waited. Someone else did it.', track: 'I Lead', when: 'This week', tags: ['Roles', 'Power'], relate: 27, support: 16 },
                { id: 'p5', text: 'I stopped doom-scrolling and used that time to send one civic email.', track: 'I Impact', when: 'Last week', tags: ['Civic action'], relate: 12, support: 9 }
            ],

            // local reaction state (mock)
            reactions: {},

            newStory: {
                text: '',
                track: 'I Dare',
                context: 'Work',
                tags: []
            },

            tagOptions: ['Boundaries', 'Meetings', 'Money', 'Family', 'Community', 'Burnout', 'Visibility'],

            sent: false,

            // partner content placeholders (existing)
            bios: [
                { id: 'b1', type: 'bio', avatar: '👩‍💼', name: 'Nora', role: 'NGO coordinator', country: 'Belgium', summary: 'From quiet contributor to community organiser through small brave asks.', tags: ['I Dare', 'Community', 'Boundaries'] },
                { id: 'b2', type: 'bio', avatar: '👩‍🔧', name: 'Leila', role: 'Manufacturing supervisor', country: 'Germany', summary: 'Learned to lead ethically while handling resistance and pressure.', tags: ['I Lead', 'Ethical power', 'Decisions'] },
                { id: 'b3', type: 'bio', avatar: '👩‍💻', name: 'Mina', role: 'Product designer', country: 'Turkey', summary: 'Built confidence in meetings and negotiated better roles without burnout.', tags: ['I Speak', 'I Earn', 'Visibility'] }
            ],

            articles: [
                { 
                    id: 'a1', 
                    type: 'article', 
                    title: 'The 3-Sentence Boundary Script', 
                    readTime: '4 min', 
                    topic: 'Boundaries', 
                    summary: 'A simple structure to say no without guilt or drama.', 
                    tags: ['Boundaries', 'I Dare'],
                    slides: [
                        {
                            id: 'a1_intro',
                            type: 'intro',
                            icon: '🗣️',
                            title: 'The 3-Sentence Boundary Script',
                            text: 'Master the simplest way to communicate limits without guilt, explanation, or drama.',
                            bullets: [
                                'Structure: Situation → Limit → Alternative',
                                'Say no with clarity and respect',
                                'Keep it short and memorable'
                            ]
                        },
                        {
                            id: 'a1_text1',
                            type: 'text',
                            title: 'The Framework',
                            text: 'The 3-sentence boundary script gives you a proven structure:\n\n1. Situation: "When you interrupt me in meetings..."\n2. Limit: "...I lose my train of thought and feel dismissed."\n3. Alternative: "...I\'d prefer if you wait until I finish, then I\'d love your input."\n\nThis keeps your message short, specific, and actionable.',
                            points: [
                                'Use "When..." not "You always..." - less accusatory',
                                'State impact neutrally with "I feel..." or "it makes difficult..."',
                                'Always offer an alternative - shows respect',
                                'Keep under 30 seconds - short is powerful'
                            ]
                        },
                        {
                            id: 'a1_mcq',
                            type: 'mcq',
                            title: 'Check Your Understanding',
                            text: 'Which follows the 3-sentence boundary structure best?',
                            options: [
                                { id: 'a', label: '"I can\'t do that" - short and firm' },
                                { id: 'b', label: '"When you interrupt... I feel dismissed... I\'d prefer..." ' },
                                { id: 'c', label: '"You\'re wrong and you need to stop"' }
                            ],
                            feedback: {
                                a: 'Too blunt without explanation or goodwill.',
                                b: 'Exactly! You named situation, impact, and alternative.',
                                c: 'This attacks rather than sets a boundary. Damages relationships.'
                            }
                        },
                        {
                            id: 'a1_summary',
                            type: 'summary',
                            title: 'What You\'ve Learned',
                            text: 'The 3-sentence boundary script is your toolkit for professional, compassionate "no."',
                            bullets: [
                                'Situation: Describe what\'s happening without blame',
                                'Limit: Clearly state your boundary',
                                'Alternative: Offer a workable path forward',
                                'Practice until it feels natural'
                            ],
                            nextAction: 'Try creating your own 3-sentence boundary for a real situation.'
                        },
                        {
                            id: 'a1_done',
                            type: 'done',
                            title: 'Great Work!',
                            text: 'You\'ve mastered the framework. Now practice it in real conversations.'
                        }
                    ]
                },
                { id: 'a2', type: 'article', title: 'Ethical Power: Leading Without Abuse', readTime: '6 min', topic: 'Leadership', summary: 'Power isn’t the problem. Unexamined power is.', tags: ['I Lead', 'Ethical power'] },
                { id: 'a3', type: 'article', title: 'Gender Lens in Digital Transformation', readTime: '7 min', topic: 'Society & Change', summary: 'How automation and AI can silently reproduce inequalities and what to do.', tags: ['I Impact', 'Digital'] }
            ],

            videos: [
                { 
                    id: 'v1', 
                    type: 'video', 
                    title: 'Calm Delivery Practice', 
                    duration: '2:10', 
                    topic: 'Communication', 
                    summary: 'Tone and pacing that make your boundary land.',
                    author: 'Video',
                    tags: ['I Speak', 'Boundaries'],
                    slides: [
                        {
                            id: 'v1_intro',
                            type: 'intro',
                            icon: '🎬',
                            title: 'Calm Delivery Practice',
                            text: 'Watch how tone and pacing make your boundary message land perfectly—even in high-stress situations.',
                            bullets: [
                                'Why tone matters more than words',
                                'Pacing techniques to stay in control',
                                'Practice scenarios with feedback'
                            ]
                        },
                        {
                            id: 'v1_video',
                            type: 'video',
                            title: 'Watch: How to Deliver a Boundary Calmly',
                            text: 'This 2-minute demo shows the difference between rushed, angry, and calm delivery of the same boundary message.',
                            duration: '2:10',
                            mediaText: 'Calm Delivery Demo Video',
                            summary: 'Key lesson: Your tone often matters more than your words. Slow down, breathe, and deliver with respect.'
                        },
                        {
                            id: 'v1_text',
                            type: 'text',
                            title: 'Pacing Tips from the Video',
                            text: 'Here are the techniques you saw modeled:',
                            points: [
                                'Pause before you speak. Take 2-3 deep breaths. This signals control.',
                                'Speak slower than you think you need to. Aim for 2 seconds per sentence.',
                                'Lower your pitch slightly. Higher pitch sounds defensive or scared.',
                                'Pause between sentences. Give your message room to land.',
                                'Maintain steady eye contact. This shows confidence, not anger.'
                            ]
                        },
                        {
                            id: 'v1_mcq',
                            type: 'mcq',
                            title: 'Scenario: Which Delivery Works Best?',
                            text: 'You need to set a boundary about late arrivals. Which approach is most likely to succeed?',
                            options: [
                                { id: 'a', label: 'Speak quickly and firmly to show you\'re serious.' },
                                { id: 'b', label: 'Slow down, speak clearly, maintain eye contact, and pause between thoughts.' },
                                { id: 'c', label: 'Raise your voice to make sure they take you seriously.' }
                            ],
                            feedback: {
                                a: 'Speed reads as panic or anger, not authority.',
                                b: 'Exactly. Calm, deliberate delivery shows real confidence and respect.',
                                c: 'Raising your voice triggers defensiveness. It weakens your message.'
                            }
                        },
                        {
                            id: 'v1_summary',
                            type: 'summary',
                            title: 'Key Takeaways',
                            text: 'Calm delivery is a learnable skill that transforms how people receive your boundaries.',
                            bullets: [
                                'Pause and breathe before speaking',
                                'Slower pace = clearer, more powerful message',
                                'Lower pitch conveys calm authority',
                                'Pauses let your words sink in',
                                'Eye contact shows respect and confidence'
                            ],
                            nextAction: 'Record yourself practicing a boundary message. Listen for pacing and tone.'
                        },
                        {
                            id: 'v1_done',
                            type: 'done',
                            title: 'Excellent Progress!',
                            text: 'You now understand how to deliver any boundary with calm, clear authority.'
                        }
                    ]
                },
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

        filteredPool() {
            const q = this.q
            const tf = this.typeFilter

            return (this.pool || []).filter(p => {
                const hay = (
                    (p.text || '') + ' ' +
                    (p.track || '') + ' ' +
                    (p.when || '') + ' ' +
                    ((p.tags || []).join(' '))
                ).toLowerCase()

                const matchQ = q ? hay.includes(q) : true

                // typeFilter includes bios/articles/videos/models — for the pool, treat "all" as show, otherwise show only if "all"
                const matchT = (tf === 'all') ? true : false

                return matchQ && matchT
            })
        },

        filteredBios() { return this.filterList(this.bios) },
        filteredArticles() { return this.filterList(this.articles) },
        filteredVideos() { return this.filterList(this.videos) },
        filteredModels() { return this.filterList(this.models) },

        canSend() {
            return (this.newStory.text || '').trim().length >= 12
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

        openStory(story) {
            // Save story data to store including custom slides
            this.$store.commit('SET_SELECTED_STORY', {
                title: story.name || story.title,
                type: story.type === 'bio' ? 'Bio' : story.type === 'article' ? 'Article' : 'Video',
                author: story.name || story.title,
                ...story
            })
            this.$router.push('/story')
        },

        openModel() {
            this.$router.push('/model')
        },

        // ---- anonymous reactions (mock) ----
        reacted(postId, kind) {
            const r = this.reactions[postId] || {}
            return !!r[kind]
        },

        toggleReaction(postId, kind) {
            const post = (this.pool || []).find(x => x.id === postId)
            if (!post) return

            const r = this.reactions[postId] || { relate: false, support: false }
            const next = !r[kind]

            // update counts (mock)
            if (kind === 'relate') post.relate += next ? 1 : -1
            if (kind === 'support') post.support += next ? 1 : -1

            r[kind] = next
            this.$set(this.reactions, postId, r)
        },

        openComments() {
            // mock
            this.$router.push('/story-reply')
        },

        // ---- share story (mock) ----
        toggleTag(tag) {
            const arr = this.newStory.tags || []
            const idx = arr.indexOf(tag)
            if (idx === -1) arr.push(tag)
            else arr.splice(idx, 1)
            this.newStory.tags = arr
        },

        submitStory() {
            if (!this.canSend) return

            // push to top of feed (mock, anonymous)
            const newPost = {
                id: 'p' + Math.random().toString(16).slice(2),
                text: (this.newStory.text || '').trim(),
                track: this.newStory.track,
                when: 'Just now',
                tags: (this.newStory.tags || []).slice(0, 3),
                relate: 0,
                support: 0
            }

            this.pool.unshift(newPost)

            this.sent = true
            this.newStory.text = ''
            this.newStory.tags = []
            this.newStory.track = 'I Dare'
            this.newStory.context = 'Work'

            // jump to Real Stories to see it
            this.storiesTab = 'real'

            setTimeout(() => { this.sent = false }, 2500)
        }
    }
}
</script>

<style scoped>
.sm {
    --brand-pink: #ff2d7a;
    --brand-blue: #2d6cdf;
    --bg: #f7fbff;
    --card: #ffffff;
    --line: #e6eef7;
    --ink: #0f172a;
    --muted: #64748b;
    --shadow: 0 10px 28px rgba(15, 23, 42, 0.08);

    max-width: 1100px;
    margin: 0 auto;
    padding: 20px 16px 44px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
    color: var(--ink);
    background: var(--bg);
    min-height: 100vh;
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
    border: 1px solid var(--line);
    border-radius: 14px;
    padding: 10px 12px;
    outline: none;
    background: #fff;
}

.select {
    border: 1px solid var(--line);
    border-radius: 14px;
    padding: 10px 12px;
    background: #fff;
}

.tabs {
    display: inline-flex;
    gap: 8px;
    padding: 6px;
    border: 1px solid var(--line);
    border-radius: 999px;
    background: #fff;
    margin-bottom: 12px;
    box-shadow: var(--shadow);
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
    background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
    color: #fff;
}

.subtabs {
    display: inline-flex;
    gap: 8px;
    padding: 6px;
    border: 1px solid var(--line);
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.75);
    margin: 4px 0 12px;
}

.subtab {
    border: 0;
    background: transparent;
    padding: 10px 14px;
    border-radius: 999px;
    font-weight: 900;
    cursor: pointer;
    color: #334155;
}

.subtab.on {
    background: #0f172a;
    color: #fff;
}

.sectionHead {
    margin-bottom: 10px;
}

.sectionHead.spaced {
    margin-top: 18px;
}

.h2 {
    margin: 0 0 6px;
    font-size: 18px;
    font-weight: 900;
}

.hint {
    margin: 0;
    color: var(--muted);
}

/* Real Stories feed */
.feed {
    display: grid;
    gap: 12px;
}

.post {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 20px;
    padding: 14px;
    box-shadow: var(--shadow);
}

.postHead {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 10px;
}

.anon {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-weight: 900;
}

.anonDot {
    width: 10px;
    height: 10px;
    border-radius: 999px;
    background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
}

.anonTxt {
    color: #334155;
}

.postMeta {
    display: inline-flex;
    gap: 8px;
    flex-wrap: wrap;
}

.chip {
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid var(--line);
    background: rgba(230, 238, 247, 0.65);
}

.postText {
    font-size: 18px;
    font-weight: 900;
    line-height: 1.3;
    letter-spacing: -0.01em;
}

.tagRow {
    margin-top: 10px;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.tag {
    font-size: 12px;
    font-weight: 900;
    border: 1px solid var(--line);
    background: #fbfdff;
    padding: 6px 10px;
    border-radius: 999px;
}

.postActions {
    margin-top: 12px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.pillBtn {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 999px;
    padding: 10px 12px;
    cursor: pointer;
    font-weight: 900;
    display: inline-flex;
    gap: 8px;
    align-items: center;
}

.pillBtn .count {
    margin-left: 2px;
    color: var(--muted);
}

.pillBtn.on {
    border-color: rgba(45, 108, 223, 0.28);
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.08));
}

.pillBtn.ghost {
    background: rgba(230, 238, 247, 0.35);
}

.ic {
    width: 18px;
    display: inline-block;
    text-align: center;
}

.miniTip {
    margin-top: 12px;
    font-size: 12px;
    font-weight: 900;
    color: var(--muted);
}

/* Share */
.shareCard {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 20px;
    padding: 14px;
    box-shadow: var(--shadow);
}

.anonBanner {
    border: 1px solid rgba(45, 108, 223, 0.18);
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.06));
    border-radius: 18px;
    padding: 12px;
    display: flex;
    gap: 10px;
    align-items: center;
    margin-bottom: 12px;
}

.anonShield {
    width: 44px;
    height: 44px;
    border-radius: 16px;
    border: 1px solid var(--line);
    background: rgba(255, 255, 255, 0.7);
    display: grid;
    place-items: center;
    font-size: 18px;
}

.anonTitle {
    font-weight: 900;
}

.anonDesc {
    margin-top: 2px;
    color: #475569;
    font-weight: 900;
    font-size: 12px;
    line-height: 1.3;
}

.lbl {
    display: block;
    font-size: 12px;
    font-weight: 900;
    color: #334155;
    margin: 10px 0 6px;
}

.ta {
    width: 100%;
    min-height: 120px;
    border: 1px solid var(--line);
    border-radius: 18px;
    padding: 12px;
    outline: none;
    resize: vertical;
    font-family: inherit;
    font-weight: 900;
    color: var(--ink);
    line-height: 1.35;
}

.ta:focus {
    border-color: rgba(45, 108, 223, 0.35);
}

.row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
    margin-top: 10px;
}

@media (max-width: 720px) {
    .row {
        grid-template-columns: 1fr;
    }
}

.field {
    display: grid;
}

.select2 {
    border: 1px solid var(--line);
    border-radius: 14px;
    padding: 10px 12px;
    background: #fff;
    font-weight: 900;
}

.chipsPick {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.pick {
    border: 1px solid var(--line);
    background: #fbfdff;
    border-radius: 999px;
    padding: 8px 10px;
    font-weight: 900;
    cursor: pointer;
}

.pick.on {
    border-color: rgba(255, 45, 122, 0.28);
    background: rgba(255, 45, 122, 0.10);
}

.shareBottom {
    margin-top: 12px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    flex-wrap: wrap;
}

.counter {
    color: var(--muted);
    font-weight: 900;
    font-size: 12px;
}

.send {
    border: 0;
    cursor: pointer;
    font-weight: 900;
    color: #fff;
    padding: 12px 14px;
    border-radius: 14px;
    background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
    box-shadow: 0 14px 28px rgba(45, 108, 223, 0.18);
}

.send:disabled {
    opacity: 0.55;
    cursor: not-allowed;
    box-shadow: none;
}

.sent {
    margin-top: 10px;
    font-weight: 900;
    color: #0f172a;
    border: 1px solid rgba(34, 197, 94, 0.28);
    background: rgba(34, 197, 94, 0.08);
    border-radius: 14px;
    padding: 10px 12px;
}

/* Existing partner content blocks */
.group {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    overflow: hidden;
    margin-bottom: 12px;
    box-shadow: var(--shadow);
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
    border: 1px solid var(--line);
    background: rgba(230, 238, 247, 0.65);
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
    border-top: 1px solid var(--line);
    background: #fbfdff;
}

@media (max-width: 860px) {
    .grid {
        grid-template-columns: 1fr;
    }
}

.card {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    padding: 14px;
    cursor: pointer;
    transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.card:hover {
    transform: translateY(-1px);
    box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
    border-color: rgba(45, 108, 223, 0.22);
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
    border: 1px solid var(--line);
    border-radius: 16px;
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
    color: var(--muted);
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
    border: 1px solid var(--line);
    border-radius: 16px;
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

.cta {
    font-weight: 900;
    color: #0f172a;
}

.note {
    margin-top: 10px;
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
}
</style>