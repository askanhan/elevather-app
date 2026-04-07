import { api } from '@/store/actions.js'

export default {
    name: 'SimulatorHome',

    data() {
        return {
            query: '',
            level: 'all',
            loading: true,
            error: null
        }
    },

    mounted() {
        this.fetchSimulatorLevels()
        this.fetchSimulators()
    },

    computed: {
        simulators() {
            return this.$store.state.simulators || []
        },

        levels() {
            return this.$store.state.simulatorLevels || []
        },

        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filtered() {
            const q = this.q
            const lvl = this.level

            return this.simulators.filter(s => {
                const hay = (s.title + ' ' + s.description + ' ' + s.domain + ' ' + s.tags.join(' ')).toLowerCase()
                const matchQ = q ? hay.includes(q) : true
                const matchL = (lvl === 'all') ? true : (s.level === lvl)
                return matchQ && matchL
            })
        }
    },

    methods: {
        fetchSimulatorLevels() {
            if (this.levels.length > 0) return
            this.$store.dispatch('fetchSimulatorLevels')
                .catch(err => console.error('Error fetching simulator levels:', err))
        },

        fetchSimulators() {
            if (this.simulators.length > 0) {
                this.loading = false
                this.error = null
                return
            }
            this.$store.dispatch('fetchSimulators')
                .then(() => {
                    if (this.simulators.length === 0) {
                        this.error = 'No simulators found.'
                    }
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching simulators:', err)
                    this.error = 'Failed to load simulators.'
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
