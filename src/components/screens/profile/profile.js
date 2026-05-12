import { mapState } from 'vuex'

export default {
    name: 'ProfileMock',

    data() {
        return {
            mission: '',
            myGoals: [],
            user: {
                streakDays: 4,
                trend: 'Rising',
                mission: 'I want to take responsibility in my community without burning out.'
            },

            tracks: [],

            stats: {
                completedCourses: 0,
                minutes: 0,
                simulations: 0
            },

            patterns: {
                blocker: 'Overload',
                booster: 'Boundaries',
                context: 'Work meetings'
            },

            toolkit: {
                scripts: 5,
                models: 3,
                stories: 7,
                bookmarks: 4
            },

            journal: [
                {
                    id: 'j1',
                    date: 'Yesterday',
                    track: 'I Dare',
                    title: 'My boundary this week',
                    snippet: 'I can\'t take this on right now. I can support with X instead...'
                },
                {
                    id: 'j2',
                    date: '3 days ago',
                    track: 'I Speak',
                    title: 'Conflict with care',
                    snippet: 'When I felt interrupted, I paused and said: "Let me finish my point."'
                },
                {
                    id: 'j3',
                    date: 'Last week',
                    track: 'I Lead',
                    title: 'Decision under pressure',
                    snippet: 'I chose the smallest safe step, communicated it clearly, and asked for input later.'
                }
            ],

            badges: [
                { id: 'b1', icon: '🛡️', title: 'Boundary Starter', sub: 'Completed 3 boundary practices' },
                { id: 'b2', icon: '🎤', title: 'Voice Builder', sub: 'Spoke up in 5 situations' },
                { id: 'b3', icon: '🌱', title: 'Impact Seed', sub: 'Designed a tiny civic pilot' }
            ],

            prefs: {
                language: 'English',
                notifications: 'On'
            }
        }
    },

    computed: {
        ...mapState(['journeyCategories', 'userProgress', 'simulatorResults', 'myProfile']),

        userName() {
            const user = this.$store.state.user
            if (user) {
                let name = user.first_name || user.firstName || user.name || user.username || 'User'
                // If it contains a space, take only first name
                if (name && name.includes(' ')) {
                    name = name.split(' ')[0]
                }
                return name
            }
        },

        userId() {
            return this.$store.state.user?.id
        },

        focusTrack() {
            const top = (this.tracks || []).slice().sort((a, b) => (b.value || 0) - (a.value || 0))[0]
            return top ? top.label : 'I Dare'
        },

        trendClass() {
            if (this.user.trend === 'Rising') return 'trendRising'
            if (this.user.trend === 'Drained') return 'trendDrained'
            return 'trendStable'
        }
    },

    async mounted() {
        // Load user profile
        this.$store.dispatch('getMyProfile', this.userId)
            .catch(err => console.error('Error loading profile:', err))

        // Load user progress data
        this.loadUserProgressData()
        await this.loadGoalsAndMission()
    },

    watch: {
        // Watch for changes in userProgress from store and reload data
        'userProgress.length': function (newLen, oldLen) {
            if (newLen !== oldLen) {
                // console.log('User progress array length changed from', oldLen, 'to', newLen, ', refreshing profile data')
                this.loadUserProgressData()
            }
        },
        // Also watch for deep changes
        // userProgress: {
        //     handler(newVal) {
        //         console.log('User progress deep watcher triggered, data changed')
        //         this.loadUserProgressData()
        //     },
        //     deep: true
        // }
    },

    methods: {
        async loadUserProgressData() {
            try {
                // Fetch journey data (categories/tracks)
                await this.$store.dispatch('fetchJourneyData')
                // Fetch user progress
                await this.$store.dispatch('fetchUserProgress', this.userId)

                // console.log('Journey Categories:', this.journeyCategories)
                // console.log('User Progress:', this.userProgress)
                // console.log('Simulator Results:', this.simulatorResults)

                // Process and format tracks data from journeyCategories
                if (this.journeyCategories && Array.isArray(this.journeyCategories)) {
                    const colors = ['#2D6CDF', '#1F9D63', '#8B5CF6', '#F59E0B', '#EF4444', '#06B6D4']
                    const journeyModules = this.$store.state.journeyModules || []

                    this.tracks = this.journeyCategories.map((category, index) => {
                        // console.log('Processing category:', category, 'at index', index)

                        // Assign first 3 colors explicitly: blue, green, purple
                        const categoryColors = ['#2D6CDF', '#1F9D63', '#8B5CF6']
                        let color = categoryColors[index] || colors[index % colors.length]

                        // console.log('Assigned color:', color, 'for index:', index)

                        // Find all modules that belong to this category
                        const modulesInCategory = journeyModules.filter(m => m.module_category_id === category.id)
                        const moduleIdsInCategory = modulesInCategory.map(m => m.id)

                        // Find all progress items for modules in this category
                        const categoryProgress = this.userProgress.filter(p =>
                            moduleIdsInCategory.includes(p.owner_id) &&
                            p.owner_type === 'module'  // Only count course modules, not other types
                        )

                        // Count completed vs total for this category
                        // console.log('Category progress items for', category.title, ':', categoryProgress)
                        const completed = categoryProgress.filter(p => {
                            const status = String(p.status).toLowerCase().trim()
                            return status === 'completed' || status === 'done'
                        }).length
                        const total = categoryProgress.length

                        // Calculate percentage for progress bar
                        const value = total > 0 ? Math.round((completed / total) * 100) : 0

                        const trackName = category.name || category.title || category.label || `Track ${index + 1}`
                        // console.log(`Track ${index}: name="${trackName}", completed=${completed}, total=${total}, color=${color}`)

                        return {
                            id: category.id,
                            label: trackName,
                            value: Math.min(Math.max(value, 0), 100),
                            color: color,
                            completed: completed,
                            total: total
                        }
                    })
                }

                // Calculate stats from userProgress - only count actual course modules
                if (this.userProgress && Array.isArray(this.userProgress)) {
                    const courseProgress = this.userProgress.filter(p => p.owner_type === 'module')
                    const simulatorProgress = this.userProgress.filter(p => p.owner_type === 'simulator')

                    // console.log('All courseProgress items:', courseProgress)
                    // console.log('All status values:', courseProgress.map(p => ({ id: p.id, status: p.status, statusLower: String(p.status).toLowerCase() })))

                    const completedModules = courseProgress.filter(p => {
                        const status = String(p.status).toLowerCase().trim()
                        return status === 'completed' || status === 'done'
                    }).length
                    const totalModules = courseProgress.length

                    const completedSimulations = simulatorProgress.filter(p => {
                        const status = String(p.status).toLowerCase().trim()
                        return status === 'completed' || status === 'done'
                    }).length
                    const totalSimulations = simulatorProgress.length

                    // console.log('All simulatorProgress items:', simulatorProgress)
                    // console.log(`Stats: courses=${completedModules}/${totalModules}, simulations=${completedSimulations}/${totalSimulations}`)

                    this.stats = {
                        completedCourses: `${completedModules}/${totalModules}`,
                        minutes: courseProgress.reduce((sum, p) => sum + (p.minutes_spent || p.duration || 0), 0),
                        simulations: `${completedSimulations}/${totalSimulations}`
                    }
                }
            } catch (error) {
                // console.error('Error loading user progress data:', error)
                // Fallback: show default empty state
                this.tracks = []
                this.stats = {
                    completedCourses: '0/0',
                    minutes: 0,
                    simulations: '0/0'
                }
            }
        },
        formatResultDate(date) {
            if (!date) return ''
            const now = new Date()
            const resultDate = new Date(date)
            const diffMs = now - resultDate
            const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))

            if (diffDays === 0) return 'Today'
            if (diffDays === 1) return 'Yesterday'
            if (diffDays < 7) return `${diffDays} days ago`
            if (diffDays < 30) return `${Math.floor(diffDays / 7)}w ago`
            return resultDate.toLocaleDateString()
        },
        openUrl(url) {
            if (!url) return
            try {
                window.open(url, '_blank')
            } catch (e) {
                window.location.href = url
            }
        },


        async loadGoalsAndMission() {
            try {
                // console.log(this.userId, "Loading goals and mission for userId:", this.userId)
                let res = this.$store.dispatch('getGoalsAndMissions', { userId: this.userId })
                // console.log(res, this.userId, "Loading goals and mission for userId:", { userId: this.userId })
                const [goalsRes, missionRes] = res ? await res : [{ data: [] }, { data: { mission: '' } }]

                this.myGoals = goalsRes.data || []
                this.mission = missionRes.data?.mission || ''
            } catch (e) {
                console.error('Error loading goals/mission:', e)
            }
        },

        goalStatusLabel(status) {
            const map = {
                working_on_it: 'Working on it',
                almost_done: 'Almost done',
                finished: 'Finished ✓',
            }
            return map[status] || status
        },

        goSimulatorHistory() {
            this.$router.push('/simulator-history')
        },

        goGoals() {
            this.$router.push('/goals')
        },

        editMission() {
            this.$router.push('/mission')
        },

        goJourney() {
            this.$router.push('/journey')
        },

        goPowerCheck() {
            this.$router.push('/power-check')
        },

        goToolkit() {
            this.$router.push('/toolkit')
        },

        openScripts() {
            this.$router.push('/scripts')
        },

        openModels() {
            this.$router.push('/models')
        },

        openStories() {
            this.$router.push('/stories')
        },

        openBookmarks() {
            this.$router.push('/bookmarks')
        },

        openJournal() {
            this.$router.push('/journal')
        },

        goBadges() {
            this.$router.push('/badges')
        },

        openFeedback() {
            this.$router.push('/feedback')
        },

        openEULA() {
            this.openUrl('https://elevather.eu/terms-of-service-end-user-license-agreement-eula/')
        },

        openPrivacy() {
            this.openUrl('https://elevather.eu/privacy-policy-for-elevather-application/')
        },

        openSupport() {
            this.openUrl('https://elevather.eu/support-for-elevather-application/')
        },

        openNotifications() {
            this.$router.push('/notifications')
        },

        logout() {
            this.$router.push('/login')
        }
    }
}
