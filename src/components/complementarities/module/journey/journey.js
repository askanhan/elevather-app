import { api } from '@/store/actions.js'

const colors = ['#2D6CDF', '#1F9D63', '#8B5CF6', '#F59E0B', '#EF4444', '#06B6D4']

export default {
    name: 'JourneyHome',

    data() {
        return {
            query: '',
            statusFilter: 'all',

            // collapsed by default
            openIds: new Set(),

            // API data
            loading: true,
            error: null,
            categories: [],
            modules: [],
            tracks: [],
            statuses: []
        }
    },

    mounted() {
        this.fetchProgressStatuses()
        this.fetchData()
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
        // Fetch progress statuses from API
        fetchProgressStatuses() {
            api.get('/progress-statuses/')
                .then(response => {
                    this.statuses = response.data || []
                })
                .catch(err => {
                    console.error('Error fetching progress statuses:', err)
                    // Fallback to default statuses
                    this.statuses = [
                        { value: 'Not started', label: 'Not started' },
                        { value: 'In progress', label: 'In progress' },
                        { value: 'Done', label: 'Done' }
                    ]
                })
        },

        // Fetch categories and modules from API
        fetchData() {
            this.loading = true
            this.error = null

            Promise.all([
                api.get('/categories/'),
                api.get('/all-modules/')
            ])
                .then(([categoriesRes, modulesRes]) => {
                    this.categories = categoriesRes.data || []
                    this.modules = modulesRes.data || []

                    // Transform categories and modules into tracks
                    this.tracks = this.transformToTracks(this.categories, this.modules)
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching data:', err)
                    this.error = 'Failed to load categories and modules.'
                    this.loading = false
                })
        },

        // Transform API data into tracks structure
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
                const catModules = modulesByCategory[cat.id] || []

                // Generate short name from title (first 2 words)
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
                    modules: catModules.map(mod => ({
                        id: mod.id,
                        title: mod.title,
                        level: this.determineLevelFromDay(mod.day_number),
                        status: 'not_started',
                        summary: mod.description || 'Module content',
                        outcomes: mod.target_audience ? [mod.target_audience] : ['Learn and practice']
                    }))
                }
            })
        },

        // Determine level based on day number
        determineLevelFromDay(dayNum) {
            if (dayNum <= 3) return 'intro'
            if (dayNum <= 7) return 'core'
            return 'advanced'
        },

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

        goToCourse(module) {
            this.$router.push({ path: '/course', query: { id: module.id } })
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
