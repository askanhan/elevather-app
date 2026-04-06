import { api } from '@/store/actions.js'

export default {
    name: 'SimulatorHome',

    data() {
        return {
            query: '',
            level: 'all',
            scenarios: [],
            levels: [],
            loading: true,
            error: null
        }
    },

    mounted() {
        this.fetchSimulatorLevels()
        this.fetchSimulators()
    },

    computed: {
        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filtered() {
            const q = this.q
            const lvl = this.level

            return this.scenarios.filter(s => {
                const hay = (s.title + ' ' + s.description + ' ' + s.domain + ' ' + s.tags.join(' ')).toLowerCase()
                const matchQ = q ? hay.includes(q) : true
                const matchL = (lvl === 'all') ? true : (s.level === lvl)
                return matchQ && matchL
            })
        }
    },

    methods: {
        // Fetch simulator levels from API
        fetchSimulatorLevels() {
            api.get('/sim-levels/')
                .then(response => {
                    this.levels = response.data || []
                })
                .catch(err => {
                    console.error('Error fetching simulator levels:', err)
                    // Fallback to default levels
                    this.levels = [
                        { value: 'intro', label: 'Intro' },
                        { value: 'core', label: 'Core' },
                        { value: 'advanced', label: 'Advanced' }
                    ]
                })
        },

        fetchSimulators() {
            this.loading = true
            this.error = null
            api.get('/all-simulators/')
                .then(response => {
                    const data = response.data

                    this.scenarios = data.map(sim => {
                        const tagNames = (sim.tags || []).map(tag => 
                            typeof tag === 'object' ? tag.name : tag
                        )

                        return {
                            id: sim.id,
                            icon: '🎯', 
                            title: sim.title,
                            description: sim.description || '',
                            level: sim.level || 'intro',
                            duration: sim.estimated_duration ? `${sim.estimated_duration} min` : 'N/A',
                            domain: sim.localisation || 'General',
                            tags: tagNames
                        }
                    })

                    this.loading = false
                })
                .catch(err => {
                    console.error('Error while fetching simulators:', err)
                    this.error = 'Impossible to load simulators. Please try again later.'
                    this.loading = false
                })
        },

        labelLevel(l) {
            if (l === 'intro') return 'Intro'
            if (l === 'core') return 'Core'
            return 'Advanced'
        },

        goPlay(s) {
            this.$router.push({ path: '/simulator/play', query: { id: s.id } })
        }
    }
}
