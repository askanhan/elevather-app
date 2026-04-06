export default {
    name: 'StoriesModels',

    data() {
        return {
            storiesTab: 'real',

            query: '',

            openIds: new Set(),

            // --- Anonymous Story Pool (mock) ---
            pool: [
                { id: 'p1', text: 'I said no to my boss today... and I didn\'t explain for 10 minutes.', track: 'I Dare', when: 'Today', tags: ['Boundaries', 'Work'], relate: 21, support: 14 },
                { id: 'p2', text: 'I asked for money. My voice shook, but I asked anyway.', track: 'I Earn', when: 'Yesterday', tags: ['Negotiation'], relate: 34, support: 29 },
                { id: 'p3', text: 'I froze in a meeting, then I came back and said: "Let me finish my point."', track: 'I Speak', when: 'This week', tags: ['Meetings', 'Visibility'], relate: 18, support: 22 },
                { id: 'p4', text: 'I didn\'t take the "helper" role automatically. I waited. Someone else did it.', track: 'I Lead', when: 'This week', tags: ['Roles', 'Power'], relate: 27, support: 16 },
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
                { id: 'a2', type: 'article', title: 'Ethical Power: Leading Without Abuse', readTime: '6 min', topic: 'Leadership', summary: 'Power isn\'t the problem. Unexamined power is.', tags: ['I Lead', 'Ethical power'] },
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
        }
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filteredPool() {
            const q = this.q

            return (this.pool || []).filter(p => {
                const hay = (
                    (p.text || '') + ' ' +
                    (p.track || '') + ' ' +
                    (p.when || '') + ' ' +
                    ((p.tags || []).join(' '))
                ).toLowerCase()

                const matchQ = q ? hay.includes(q) : true

                return matchQ
            })
        },

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
