import Vue from 'vue'

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

            sent: false,
            
            storySubmitError: '',

            // Error modal popup
            showErrorModal: false,
            errorModalMessage: '',

            // Delete confirmation modal
            showDeleteModal: false,
            storyToDelete: null,
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
            
            // PRIORITY 1: Check if story is in our tracking list (most reliable)
            if (this.myStoryIds.has(story.id)) {
                console.log(`✅ Story ${story.id} is in user's list (from myStoryIds set)`)
                return true
            }
            
            // PRIORITY 2: Try multiple ways to get user_id from the story object
            const storyUserId = story.user_id || story.user?.id || story.author_id || story.userId
            
            if (storyUserId === this.currentUserId) {
                console.log(`✅ Story ${story.id} is owned by user (user_id match: ${storyUserId})`)
                // Add to tracking for future reference
                this.myStoryIds.add(story.id)
                return true
            }
            
            // DEBUG: Log why story is not owned
            if (storyUserId === undefined) {
                console.log(`⚠️ Story ${story.id}: No user_id in backend response (backend issue)`)
            } else {
                console.log(`❌ Story ${story.id}: Owned by user ${storyUserId}, not by current user ${this.currentUserId}`)
            }
            
            return false
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
                this.storiesTab = 'pending'

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
                this.storiesTab = 'pending'

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

