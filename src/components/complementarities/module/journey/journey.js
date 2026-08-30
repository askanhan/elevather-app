const colors = ['#2D6CDF', '#1F9D63', '#8B5CF6', '#F59E0B', '#EF4444', '#06B6D4']

const RING_R = 30
const RING_C = 2 * Math.PI * RING_R

export default {
    name: 'JourneyHome',

    data() {
        return {
            query: '',
            statusFilter: 'all',
            categoryFilter: 'all',
            openIds: [],
            loading: true,
            error: null,
            ringCircumference: RING_C.toFixed(2)
        }
    },

    mounted() {
        this.fetchJourneyData()
    },

    computed: {
        userId() {
            return this.$store.state.user?.id
        },

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
                .filter(t => (c === 'all' ? true : t.id === `category_${c}`))
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
                        const matchesStatus = s === 'all' ? true : m.status === s
                        return matchesQuery && matchesStatus
                    })

                    return { ...t, modules }
                })
                .filter(t => (t.modules || []).length > 0)
        },

        // Flat list with track context attached — used for counts and the resume card.
        allModules() {
            const out = []
            this.tracks.forEach(t => {
                (t.modules || []).forEach(m => {
                    out.push({ ...m, trackTitle: t.title, trackColor: t.color, trackId: t.id })
                })
            })
            return out
        },

        counts() {
            const all = this.allModules
            return {
                total: all.length,
                done: all.filter(m => m.status === 'Done').length,
                inProgress: all.filter(m => m.status === 'In progress').length,
                notStarted: all.filter(m => m.status === 'Not started').length
            }
        },

        progressPercentage() {
            const { done, total } = this.counts
            return total > 0 ? Math.round((done / total) * 100) : 0
        },

        ringOffset() {
            return (RING_C * (1 - this.progressPercentage / 100)).toFixed(2)
        },

        // First module still running; otherwise the next one to start.
        resumeModule() {
            const all = this.allModules
            return all.find(m => m.status === 'In progress') ||
                all.find(m => m.status === 'Not started') ||
                null
        },

        isGuest() {
            return this.$store.state.guestMode || false
        },

        // Guests don't have real progress, so instead of guessing a "resume"
        // module we always offer the same single free preview: the earliest
        // day across all tracks.
        freeModule() {
            const all = this.allModules
            if (all.length === 0) return null
            return all.slice().sort((a, b) => {
                if (a.dayNumber !== b.dayNumber) return a.dayNumber - b.dayNumber
                return a.id - b.id
            })[0]
        },

        allOpen() {
            return this.tracks.length > 0 && this.openIds.length === this.tracks.length
        }
    },

    methods: {
        fetchJourneyData(force) {
            const hasCategories = this.categories.length > 0
            const hasModules = this.modules.length > 0

            if (!force && hasCategories && hasModules) {
                this.loading = false
                this.error = null
                this.initializeOpenIds()
                return
            }

            this.loading = true
            this.error = null

            // fetchUserProgress merges into journeyModules by id (UPDATE_MODULE_STATUS), so it
            // must not run until journeyModules is populated - otherwise the merge silently
            // no-ops and every module falls back to "Not started". Awaiting fetchJourneyData
            // first removes that ordering race regardless of relative network timing.
            // Guests have no user id, so this step is skipped entirely for them instead of
            // hitting /user/undefined/progress/ and surfacing a false "connection" error.
            Promise.all([
                this.$store.dispatch('fetchJourneyProgressStatuses'),
                this.$store.dispatch('fetchJourneyData')
            ])
                .then(() => {
                    if (!this.isGuest && this.userId) {
                        return this.$store.dispatch('fetchUserProgress', this.userId)
                    }
                })
                .then(() => {
                    if (this.categories.length === 0 || this.modules.length === 0) {
                        this.error = this.$t('components.journey.errors.empty')
                    } else {
                        this.initializeOpenIds()
                    }
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching journey data:', err)
                    this.error = this.$t('components.journey.errors.connection')
                    this.loading = false
                })
        },

        // Open the track that holds the active module; keep the rest collapsed
        // so the page opens as an overview instead of a wall of cards.
        initializeOpenIds() {
            const active = this.tracks.find(t =>
                (t.modules || []).some(m => m.status === 'In progress')
            )
            const first = this.tracks[0]
            const target = active || first
            this.openIds = target ? [target.id] : []
        },

        transformToTracks(categories, modules) {
            if (!categories || categories.length === 0) return []

            const modulesByCategory = {}
            modules.forEach(mod => {
                const catId = mod.module_category_id
                if (!modulesByCategory[catId]) modulesByCategory[catId] = []
                modulesByCategory[catId].push(mod)
            })

            return categories.map((cat, idx) => {
                let catModules = modulesByCategory[cat.id] || []
                catModules = catModules.slice().sort((a, b) => (a.day_number || 0) - (b.day_number || 0))

                return {
                    id: `category_${cat.id}`,
                    categoryId: cat.id,
                    title: cat.title,
                    description: cat.description || this.$t('components.journey.defaultTrackDescription'),
                    color: colors[idx % colors.length],
                    modules: catModules.map(mod => ({
                        id: mod.id,
                        title: mod.title,
                        status: mod.status || 'Not started',
                        summary: mod.description || this.$t('components.journey.defaultModuleSummary'),
                        outcomes: mod.target_audience ? [mod.target_audience] : [this.$t('components.journey.defaultOutcome')],
                        dayNumber: mod.day_number || 0
                    }))
                }
            })
        },

        toggle(id) {
            this.openIds = this.isOpen(id)
                ? this.openIds.filter(x => x !== id)
                : this.openIds.concat(id)
        },

        isOpen(id) {
            return this.openIds.indexOf(id) !== -1
        },

        expandAll() {
            this.openIds = this.tracks.map(t => t.id)
        },

        collapseAll() {
            this.openIds = []
        },

        setStatus(status) {
            this.statusFilter = this.statusFilter === status ? 'all' : status
            if (this.statusFilter !== 'all') this.expandAll()
        },

        clearFilters() {
            this.query = ''
            this.statusFilter = 'all'
            this.categoryFilter = 'all'
            this.initializeOpenIds()
        },

        trackStats(track) {
            const mods = (track && track.modules) ? track.modules : []
            const total = mods.length
            const done = mods.filter(m => m.status === 'Done').length
            return { done, total, percent: total ? Math.round((done / total) * 100) : 0 }
        },

        statusLabel(status) {
            if (status === 'Done') return this.$t('components.journey.status.done')
            if (status === 'In progress') return this.$t('components.journey.status.inProgress')
            return this.$t('components.journey.status.notStarted')
        },

        // One key drives the pill, the card tint and the rail node.
        statusKey(status) {
            if (status === 'Done') return 'is-done'
            if (status === 'In progress') return 'is-progress'
            return 'is-todo'
        },

        isLocked(module) {
            return this.isGuest && (!this.freeModule || module.id !== this.freeModule.id)
        },

        goToCourse(module) {
            if (this.isLocked(module)) {
                this.$message.success(this.$t('components.journey.loginToOpenCourse'))
                return
            }
            this.$router.push({ path: '/course', query: { id: module.id, done: module.status === 'Done' ? '1' : '0' } })
        }
    }
}