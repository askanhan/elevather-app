const colors = ['#2D6CDF', '#1F9D63', '#8B5CF6', '#F59E0B', '#EF4444', '#06B6D4']

export default {
    name: 'JourneyHome',

    data() {
        return {
            query: '',
            statusFilter: 'all',
            categoryFilter: 'all',
            openIds: new Set(),
            loading: true,
            error: null
        }
    },

    mounted() {
        this.fetchJourneyData()
    },

    computed: {
        statuses() {
            return this.$store.state.journeyStatuses || []
        },

        categories() {
            return this.$store.state.journeyCategories || []
        },

        modules() {
            return this.$store.state.journeyModules || []
        },

        tracks() {
            return this.transformToTracks(this.categories, this.modules)
        },

        normalizedQuery() {
            return (this.query || '').trim().toLowerCase()
        },

        filteredTracks() {
            const q = this.normalizedQuery
            const s = this.statusFilter
            const c = this.categoryFilter

            return this.tracks
                .filter(t => c === 'all' ? true : (t.id === `category_${c}`))
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
        },

        totalProgression() {
            const allModules = this.modules || []
            const completed = allModules.filter(m => m.status === 'Done').length
            const total = allModules.length
            return { completed, total }
        },

        progressPercentage() {
            const prog = this.totalProgression
            return prog.total > 0 ? Math.round((prog.completed / prog.total) * 100) : 0
        }
    },

    methods: {
        fetchJourneyData() {
            const hasCategories = this.categories.length > 0
            const hasModules = this.modules.length > 0

            if (hasCategories && hasModules) {
                this.loading = false
                this.error = null
                this.initializeOpenIds()
                return
            }

            this.loading = true
            this.error = null

            Promise.all([
                this.$store.dispatch('fetchJourneyProgressStatuses'),
                this.$store.dispatch('fetchJourneyData'),
                this.$store.dispatch('fetchUserProgress', 1) // userId: 1 for now
            ])
                .then(() => {
                    if (this.categories.length === 0 || this.modules.length === 0) {
                        this.error = 'Failed to load journey data.'
                    } else {
                        this.initializeOpenIds()
                    }
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching journey data:', err)
                    this.error = 'Failed to load categories and modules.'
                    this.loading = false
                })
        },

        initializeOpenIds() {
            const openIdSet = new Set()
            this.tracks.forEach(track => {
                openIdSet.add(track.id)
            })
            this.openIds = openIdSet
        },

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
                let catModules = modulesByCategory[cat.id] || []
                // Sort modules by day_number in ascending order
                catModules = catModules.sort((a, b) => (a.day_number || 0) - (b.day_number || 0))

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
                    modules: catModules.map((mod) => ({
                        id: mod.id,
                        title: mod.title,
                        status: mod.status || 'Not started',
                        summary: mod.description || 'Module content',
                        outcomes: mod.target_audience ? [mod.target_audience] : ['Learn and practice'],
                        dayNumber: mod.day_number || 0
                    }))
                }
            })
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

        goToCourse(module) {
            if (this.$store.state.guestMode) {
                // alert('Please log in to access the course content.')
                this.$message.success('Please log in to access the course content.')
                return
            } else {
                this.$router.push({ path: '/course', query: { id: module.id } })
            }
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

        filteredModules(track) {
            return (track && track.modules) ? track.modules : []
        },

        statusLabel(status) {
            if (status === 'Done') return 'Done'
            if (status === 'In progress') return 'In progress'
            return 'Not started'
        },

        statusClass(status) {
            return { done: status === 'Done', in_progress: status === 'In progress', not_started: status === 'Not started' }
        },

        getTrackStatusClass(track) {
            const modules = track.modules || []
            if (modules.length === 0) return ''

            // If any module is done, show as done (green)
            if (modules.some(m => m.status === 'Done')) {
                return 'track-done'
            }
            // If any module is in progress, show as in progress (orange)
            if (modules.some(m => m.status === 'In progress')) {
                return 'track-in-progress'
            }
            return 'track-not-started'
        },

        getModuleStatusClass(status) {
            if (status === 'Done') return 'module-done'
            if (status === 'In progress') return 'module-in-progress'
            return 'module-not-started'
        }
    }
}
