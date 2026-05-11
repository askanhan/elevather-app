// Mapping for localisation IDs to text (backward compatible)
// Now backend stores text directly (e.g., "Community") but we keep this for legacy data
const CONTEXT_TEXT_MAP = {
    1: 'Work',
    2: 'Family',
    3: 'Community',
    4: 'Self',
    'Work': 'Work',
    'Family': 'Family',
    'Community': 'Community',
    'Self': 'Self'
}

export default {
    name: 'StoriesModels',

    data() {
        return {
            storiesTab: 'real',

            query: '',

            openIds: new Set(),

            currentUserId: 1,

            showUserStoriesOnly: false,

            // Track stories created/owned by current user
            myStoryIds: new Set(),

            // local reaction state (mock)
            reactions: {},

            newStory: {
                text: '',
                track: '',
                context: 'Work',
                tags: []
            },

            storiesTab: 'inspire',           // ilk açılışta inspirational gösteriyor
            inspireTopic: 'all',
            inspireTopics: ['Career', 'Leadership', 'Resilience', 'Family', 'Mental Health', 'Tech', 'Entrepreneurship'],
            expandedInspire: [],
            savedInspire: [],
            inspiredBy: [],

            sent: false,

            storySubmitError: '',

            // Error modal popup
            showErrorModal: false,
            errorModalMessage: '',

            // Delete confirmation modal
            showDeleteModal: false,
            storyToDelete: null,
            inspirationalStories: [
                {
                    id: 'ins-1',
                    name: 'Sarah Mendel',
                    role: 'Senior Engineer, fintech',
                    topic: 'Tech',
                    title: 'Switching careers at 34, without apology',
                    image: 'https://placehold.co/600x400/png?text=Sarah',
                    excerpt: 'I left a stable HR job to learn to code. Everyone said it was reckless. Two years later I shipped my first production system.',
                    story: [
                        'For ten years I worked in HR. Comfortable, predictable, and slowly draining me. I kept opening DevTools on random websites just to see how things worked.',
                        'At 34 I quit. I had eight months of savings and zero engineering background. The first six months were brutal — imposter syndrome wakes you up at 3am.',
                        'What changed me was finding a community of late-career switchers. Suddenly my "weakness" (starting late) became context. I knew how teams actually fight, how managers think, how products fail because of people not code.',
                        'I shipped my first production system two years in. Nothing about that journey was linear, and I would not change it.',
                    ],
                    quote: 'You are not late. You are exactly where your story needed you to be.',
                    tags: ['#careerchange', '#tech', '#latebloomer'],
                    inspired_count: 142,
                    featured: true,
                },
                {
                    id: 'ins-2',
                    name: 'Amara K.',
                    role: 'Founder, social enterprise',
                    topic: 'Entrepreneurship',
                    title: 'Building when no one believes you yet',
                    image: 'https://placehold.co/600x400/png?text=Amara',
                    excerpt: 'Eleven investor rejections in one month. The twelfth said yes. The difference was not my pitch — it was that I stopped apologizing for it.',
                    story: [
                        'I pitched a women-focused micro-lending platform. Eleven rejections in thirty days. One investor literally said "the market is too small" about half the population.',
                        'I rewrote nothing about the deck. I changed how I walked into the room. I stopped over-explaining, stopped softening, stopped pre-empting their objections.',
                        'The twelfth investor wrote our first check. We are now in three countries.',
                    ],
                    quote: 'Confidence is not the absence of doubt. It is refusing to let doubt do the talking.',
                    tags: ['#startup', '#fundraising', '#womeninbusiness'],
                    inspired_count: 98,
                },
                {
                    id: 'ins-3',
                    name: 'Leyla T.',
                    role: 'Clinical psychologist',
                    topic: 'Mental Health',
                    title: 'I treat burnout for a living. I still got it.',
                    image: 'https://placehold.co/600x400/png?text=Leyla',
                    excerpt: 'I spent years telling clients to rest. It took collapsing in my own office to follow my own advice.',
                    story: [
                        'I was the therapist friends called when things broke. I was good at it. Too good — I never thought the rules applied to me.',
                        'One Tuesday I could not get up from my chair between sessions. Not physically tired. Empty. The kind of empty you cannot caffeine your way out of.',
                        'I took three months off. The hardest part was not the rest. It was learning that being unavailable did not make me less valuable.',
                    ],
                    quote: 'Rest is not a reward you earn. It is the ground you stand on.',
                    tags: ['#burnout', '#selfcare', '#psychology'],
                    inspired_count: 211,
                },
                {
                    id: 'ins-4',
                    name: 'Rania B.',
                    role: 'Engineering manager',
                    topic: 'Leadership',
                    title: 'The first time I said no in a meeting',
                    image: 'https://placehold.co/600x400/png?text=Rania',
                    excerpt: 'I was the youngest woman in the room for years. I learned to nod. Then one Q4 I just stopped.',
                    story: [
                        'For four years I was the only woman on my leadership team, and the youngest by a decade. I nodded a lot. I "took it offline" a lot.',
                        'In our Q4 planning my director proposed a deadline that would burn out my team for a feature no customer asked for. I said no. Not softly, not with five qualifiers. Just no, and here is why.',
                        'The silence was loud. Then someone else said "I agree with Rania." Then another. The deadline moved.',
                    ],
                    quote: 'Your seat at the table only matters if you are willing to use your voice from it.',
                    tags: ['#leadership', '#womenintech', '#boundaries'],
                    inspired_count: 167,
                },
            ],
        }
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        isGuest() {
            return this.$store.state.guestMode || false
        },

        filteredInspire() {
            if (this.inspireTopic === 'all') return this.inspirationalStories.filter(s => !s.featured);
            return this.inspirationalStories.filter(
                s => !s.featured && s.topic === this.inspireTopic
            );
        },
        featuredInspire() {
            return this.inspirationalStories.find(s => s.featured);
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

        trackOptions() {
            return this.$store.state.storyCategories || []
        },

        tagOptions() {
            return this.$store.state.storyTags || []
        },

        canSend() {
            return (this.newStory.text || '').trim().length > 0
        },

        pendingStoriesList() {
            return this.$store.state.pendingStories || []
        },

        pendingStoriesCount() {
            return this.pendingStoriesList.length
        }
    },

    methods: {
        toggleInspireExpand(id) {
            const i = this.expandedInspire.indexOf(id);
            if (i === -1) this.expandedInspire.push(id);
            else this.expandedInspire.splice(i, 1);
        },
        toggleSaveInspire(id) {
            const i = this.savedInspire.indexOf(id);
            if (i === -1) this.savedInspire.push(id);
            else this.savedInspire.splice(i, 1);
        },
        toggleInspiredBy(id) {
            const story = this.inspirationalStories.find(s => s.id === id);
            if (!story) return;
            const i = this.inspiredBy.indexOf(id);
            if (i === -1) {
                this.inspiredBy.push(id);
                story.inspired_count = (story.inspired_count || 0) + 1;
            } else {
                this.inspiredBy.splice(i, 1);
                story.inspired_count = Math.max(0, (story.inspired_count || 1) - 1);
            }
        },
        openInspireDetail(story) {
            this.toggleInspireExpand(story.id);
            // İsteğe bağlı: tam sayfa modal aç
        },
        // Helper: convert localisation ID to text
        getContextText(localisationId) {
            return CONTEXT_TEXT_MAP[localisationId] || CONTEXT_TEXT_MAP[parseInt(localisationId)] || 'Unknown'
        },

        // Helper: get context from story (handles multiple field names)
        getStoryContext(story) {
            if (!story) return 'Unknown'

            // Try different field names for localisation
            const localisationId = story.localisation || story.context || story.context_id
            return this.getContextText(localisationId)
        },

        // Helper: check if story belongs to current user
        isOwnStory(story) {
            if (!story) return false

            return story.user_id == this.currentUserId
        },

        formatStoryDate(date) {
            if (!date) return '';
            const d = typeof date === 'string' ? new Date(date) : date;
            if (isNaN(d.getTime())) return date;  // fallback
          
            const diffMs = Date.now() - d.getTime();
            const min = Math.floor(diffMs / 60000);
            const hr  = Math.floor(diffMs / 3600000);
            const day = Math.floor(diffMs / 86400000);
          
            if (min < 1)   return 'just now';
            if (min < 60)  return `${min}m ago`;
            if (hr  < 24)  return `${hr}h ago`;
            if (day < 7)   return `${day}d ago`;
            if (day < 30)  return `${Math.floor(day / 7)}w ago`;
          
            return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
          }, 

        async loadStories() {
            try {
                // Load both all stories and user stories to cross-reference
                await Promise.all([
                    this.$store.dispatch('fetchAllStories', { viewerId: this.currentUserId }),
                    this.$store.dispatch('fetchUserStories', { userId: this.currentUserId, viewerId: this.currentUserId })
                ])

                // Add all user stories to tracking set (these are definitely ours)
                const userStories = this.$store.state.userStories || []
                userStories.forEach(story => {
                    this.myStoryIds.add(story.id)
                    console.log(`✅ Added user story to tracking: ${story.id}`)
                })

                // Also check allStories for explicit user_id field (backup)
                const allStories = this.$store.state.allStories || []
                allStories.forEach(story => {
                    const storyUserId = story.user_id || story.user?.id || story.author_id
                    if (storyUserId === this.currentUserId) {
                        this.myStoryIds.add(story.id)
                        console.log(`✅ Story ${story.id} has user_id match in allStories`)
                    }
                })

                console.log(`📚 Loaded all stories. User owns: ${this.myStoryIds.size} story(ies)`)
            } catch (error) {
                console.error('Error loading stories:', error)
            }
        },

        async loadStoryCategories() {
            try {
                await this.$store.dispatch('fetchStoryCategories')
                // Set default track to first category if available
                if (this.trackOptions.length > 0 && !this.newStory.track) {
                    this.newStory.track = this.trackOptions[0].name || this.trackOptions[0].title
                    console.log(`✅ Set default track to: ${this.newStory.track}`)
                }
            } catch (error) {
                console.error('Error loading story categories:', error)
            }
        },

        async loadStoryTags() {
            try {
                await this.$store.dispatch('fetchStoryTags')
                console.log(`✅ Loaded ${this.tagOptions.length} story tags`)
            } catch (error) {
                console.error('Error loading story tags:', error)
            }
        },

        async loadPendingStories() {
            try {
                await this.$store.dispatch('fetchPendingStories', this.currentUserId)
                console.log(`📋 Loaded ${this.pendingStoriesCount} pending stories`)
            } catch (error) {
                console.error('Error loading pending stories:', error)
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
                // All user stories belong to current user - track them all
                const userStories = this.$store.state.userStories || []
                userStories.forEach(story => {
                    this.myStoryIds.add(story.id)
                })
                console.log(`👤 Loaded user stories. Total: ${this.myStoryIds.size}`)
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

        async toggleReaction(postId, kind) {
            // Find the post in the store
            const post = (this.$store.state.allStories || []).find(x => x.id === postId)
            if (!post) return

            try {
                // Call the actual API through the store action
                const result = await this.$store.dispatch('toggleStoryReaction', {
                    storyId: postId,
                    reactionType: kind,
                    userId: this.currentUserId
                })

                // Track local reaction state for UI feedback
                const r = this.reactions[postId] || { relatable: false, support: false }

                // Initialize reactions_count if needed
                if (!post.reactions_count) {
                    post.reactions_count = { relatable: 0, support: 0 }
                }

                // Update local state based on backend action
                if (result.action === 'created') {
                    // User added a reaction
                    r[kind] = true
                    post.reactions_count[kind] = (post.reactions_count[kind] || 0) + 1
                } else if (result.action === 'updated') {
                    // User switched from one reaction to another
                    if (r.relatable && kind !== 'relatable') {
                        r.relatable = false
                        post.reactions_count.relatable = Math.max(0, (post.reactions_count.relatable || 1) - 1)
                    }
                    if (r.support && kind !== 'support') {
                        r.support = false
                        post.reactions_count.support = Math.max(0, (post.reactions_count.support || 1) - 1)
                    }
                    r[kind] = true
                    post.reactions_count[kind] = (post.reactions_count[kind] || 0) + 1
                } else if (result.action === 'deleted') {
                    // User removed their reaction
                    r[kind] = false
                    post.reactions_count[kind] = Math.max(0, (post.reactions_count[kind] || 1) - 1)
                }

                // Use Vue.set for proper reactivity
                Vue.set(this.reactions, postId, r)
            } catch (error) {
                console.error('Error toggling reaction:', error)
            }
        },

        openComments() {
            // mock
            this.$router.push('/story-reply')
        },

        // ---- share story (mock) ----
        toggleTag(tag) {
            // tag is now an object with {id, name}
            const tagId = tag.id
            const arr = this.newStory.tags || []
            const idx = arr.indexOf(tagId)

            if (idx === -1) {
                // Add tag if limit not reached
                if (arr.length < 3) {
                    arr.push(tagId)
                }
            } else {
                arr.splice(idx, 1)
            }
            this.newStory.tags = arr
            console.log('📌 Updated tags:', this.newStory.tags)
        },

        isTagSelected(tagId) {
            return (this.newStory.tags || []).includes(tagId)
        },

        submitStory() {
            if (!this.canSend) {
                console.log('⚠️ Cannot send story - text too short (<12 chars)')
                return
            }

            console.log('📝 [submitStory] Submitting story...', this.newStory)
            console.log('📝 [submitStory] currentUserId:', this.currentUserId)

            // Clear error message
            this.storySubmitError = ''

            // Call the action to create story
            const storyPayload = {
                userId: this.currentUserId,
                content: (this.newStory.text || '').trim(),
                track: this.newStory.track,
                context: this.newStory.context,
                tags: (this.newStory.tags || []).slice(0, 3)
            }

            console.log('📝 [submitStory] Dispatching createStory with payload:', storyPayload)

            this.$store.dispatch('createStory', storyPayload)
                .then((createdStory) => {
                    console.log('✅ Story submitted successfully!', createdStory)
                    this.$message.success('✅ Story submitted successfully!')

                    // IMPORTANT: Track the newly created story immediately
                    // if (createdStory && createdStory.id) {
                    //     this.myStoryIds.add(createdStory.id)
                    //     console.log(`✅ Tracked new story: ${createdStory.id}`)
                    // }

                    // Success: show sent message and reset form
                    this.sent = true
                    this.storySubmitError = ''
                    this.newStory.text = ''
                    this.newStory.tags = []
                    this.newStory.track = 'I Dare'
                    this.newStory.context = 'Work'

                    // Switch to Pending Stories to see it (story awaits moderation)
                    // this.storiesTab = 'pending'

                    // Reload stories to see the new one
                    this.loadStories()
                    this.loadPendingStories()

                    // Hide sent message after 2 seconds and redirect
                    // setTimeout(() => {
                    //     this.sent = false
                    //     console.log('🔄 Redirecting to Stories page...')
                    //     // Redirect to stories page
                    //     this.$router.push('/stories')
                    // }, 2000)
                })
                .catch(error => {
                    console.error('❌ [submitStory] Error submitting story:', error)
                    console.error('❌ [submitStory] Error message:', error.message)
                    console.error('❌ [submitStory] Full error:', error)
                    this.sent = false

                    // Check for rate limiting error
                    if (error.response && error.response.status === 429) {
                        this.errorModalMessage = '✨ One inspiring story per day keeps our community thriving! Come back tomorrow to share your next story.'
                    } else if (error.response && error.response.data && error.response.data.error) {
                        this.errorModalMessage = error.response.data.error
                    } else {
                        this.errorModalMessage = 'Failed to submit story. Please try again.'
                    }
                    this.showErrorModal = true
                })
        },

        submitStoryWithName() {
            if (!this.canSend) {
                console.log('⚠️ Cannot send story - text too short')
                return
            }

            // Get user's first name from state.user (same source as menubar)
            const user = this.$store.state.user
            let firstName = 'User'

            if (user) {
                // Try different field names for first name
                firstName = user.first_name || user.firstName || user.name || user.username || 'User'
                // Extract just the first name if it contains a space
                if (firstName && firstName.includes(' ')) {
                    firstName = firstName.split(' ')[0]
                }
            }

            console.log('📝 [submitStoryWithName] Submitting story with name:', firstName)
            console.log('📝 [submitStoryWithName] currentUserId:', this.currentUserId)

            // Clear error message
            this.storySubmitError = ''

            // Call the action to create story with author name
            const storyPayload = {
                userId: this.currentUserId,
                content: (this.newStory.text || '').trim(),
                track: this.newStory.track,
                context: this.newStory.context,
                tags: (this.newStory.tags || []).slice(0, 3),
                authorName: firstName  // Pass the first name instead of Anonymous
            }

            console.log('📝 [submitStoryWithName] Dispatching createStory with payload:', storyPayload)

            this.$store.dispatch('createStory', storyPayload)
                .then((createdStory) => {
                    console.log('✅ Story submitted successfully with name!', createdStory)

                    // IMPORTANT: Track the newly created story immediately
                    if (createdStory && createdStory.id) {
                        this.myStoryIds.add(createdStory.id)
                        console.log(`✅ Tracked new story: ${createdStory.id}`)
                    }

                    // Success: show sent message and reset form
                    this.sent = true
                    this.storySubmitError = ''
                    this.newStory.text = ''
                    this.newStory.tags = []
                    this.newStory.track = 'I Dare'
                    this.newStory.context = 'Work'

                    // Switch to Pending Stories to see it (story awaits moderation)
                    // this.storiesTab = 'pending'

                    // Reload stories to see the new one
                    this.loadStories()
                    this.loadPendingStories()

                    // Hide sent message after 2 seconds and redirect
                    setTimeout(() => {
                        this.sent = false
                        console.log('🔄 Redirecting to Stories page...')
                        // Redirect to stories page
                        this.$router.push('/stories')
                    }, 2000)
                })
                .catch(error => {
                    console.error('❌ [submitStoryWithName] Error submitting story:', error)
                    console.error('❌ [submitStoryWithName] Error message:', error.message)
                    console.error('❌ [submitStoryWithName] Full error:', error)
                    this.sent = false

                    // Check for rate limiting error
                    if (error.response && error.response.status === 429) {
                        this.errorModalMessage = '✨ One inspiring story per day keeps our community thriving! Come back tomorrow to share your next story.'
                    } else if (error.response && error.response.data && error.response.data.error) {
                        this.errorModalMessage = error.response.data.error
                    } else {
                        this.errorModalMessage = 'Failed to submit story. Please try again.'
                    }
                    this.showErrorModal = true
                })
        },

        closeErrorModal() {
            this.showErrorModal = false
            this.errorModalMessage = ''
            this.storiesTab = 'real'
        },

        deleteStory(storyId) {
            // Show modal instead of browser confirm
            this.storyToDelete = storyId
            this.showDeleteModal = true
        },

        cancelDelete() {
            this.showDeleteModal = false
            this.storyToDelete = null
        },

        async confirmDeleteStory() {
            const storyId = this.storyToDelete
            this.showDeleteModal = false
            this.storyToDelete = null

            try {
                console.log(`🗑️ Deleting story ${storyId}...`)
                await this.$store.dispatch('deleteStory', {
                    storyId: storyId,
                    userId: this.currentUserId
                })
                // Remove from tracking
                this.myStoryIds.delete(storyId)
                console.log(`✅ Story ${storyId} deleted successfully!`)
                // No alert - just reload
                this.loadStories()
            } catch (error) {
                console.error('❌ Error deleting story:', error)
                alert('Failed to delete story. Please try again.')
            }
        }
    },

    mounted() {
        this.loadStories()
        this.loadStoryCategories()
        this.loadStoryTags()
        this.loadPendingStories()
    }
}

