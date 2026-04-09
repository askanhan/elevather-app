export default {
    name: 'StoriesModels',

    data() {
        return {
            storiesTab: 'real',

            query: '',

            openIds: new Set(),

            currentUserId: 1,

            showUserStoriesOnly: false,

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
        }
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filteredPool() {
            const q = this.q
            // Use userStories if filtering own stories, otherwise use allStories
            const stories = this.showUserStoriesOnly 
                ? (this.$store.state.userStories || [])
                : (this.$store.state.allStories || [])

            return (stories || []).filter(p => {
                const hay = (
                    (p.text || p.content || '') + ' ' +
                    (p.track || p.category?.title || '') + ' ' +
                    (p.when || p.created_at || '') + ' ' +
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
        async loadStories() {
            try {
                await this.$store.dispatch('fetchAllStories', { viewerId: this.currentUserId })
            } catch (error) {
                console.error('Error loading stories:', error)
            }
        },

        toggleUserStoriesOnly() {
            this.showUserStoriesOnly = !this.showUserStoriesOnly
            if (this.showUserStoriesOnly) {
                this.loadUserStories()
            } else {
                this.loadStories()
            }
        },

        async loadUserStories() {
            try {
                await this.$store.dispatch('fetchUserStories', { userId: this.currentUserId, viewerId: this.currentUserId })
            } catch (error) {
                console.error('Error loading user stories:', error)
            }
        },

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
    },

    mounted() {
        this.loadStories()
    }
}
