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
        this.fetchSimulators().then(() => this.fetchProgress())
    },

    computed: {
        simulators() {
            return this.$store.state.simulators || []
        },

        levels() {
            return this.$store.state.simulatorLevels || []
        },

        isGuest() {
            return this.$store.state.guestMode || false
        },

        userId() {
            return this.$store.state.user?.id
        },

        // Guests get exactly one simulator to try for free, picked deterministically
        // (lowest id) so it doesn't shuffle around when the list is searched/filtered.
        freeSimulator() {
            const list = this.simulators
            if (list.length === 0) return null
            return list.slice().sort((a, b) => a.id - b.id)[0]
        },

        q() {
            return (this.query || '').trim().toLowerCase()
        },

        filtered() {
            const q = this.q
            const lvl = this.level

            const matches = this.simulators.filter(s => {
                const hay = (s.title + ' ' + s.description + ' ' + s.domain + ' ' + s.tags.join(' ')).toLowerCase()
                const matchQ = q ? hay.includes(q) : true
                const matchL = (lvl === 'all') ? true : (s.level === lvl)
                return matchQ && matchL
            })

            // Stable partition: everything still to do keeps its order, completed
            // simulators sink to the bottom instead of cluttering the top of the list.
            const notDone = matches.filter(s => s.status !== 'Done')
            const done = matches.filter(s => s.status === 'Done')
            return notDone.concat(done)
        },

        progressCounts() {
            const all = this.simulators
            return {
                total: all.length,
                done: all.filter(s => s.status === 'Done').length
            }
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
                return Promise.resolve()
            }
            return this.$store.dispatch('fetchSimulators')
                .then(() => {
                    if (this.simulators.length === 0) {
                        this.error = this.$t('components.simulator.home.errors.noSimulatorsFound')
                    }
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching simulators:', err)
                    this.error = this.$t('components.simulator.home.errors.loadFailed')
                    this.loading = false
                })
        },

        // Simulators don't come back from the list endpoint with a per-user status
        // (same as journeys) - it only exists in /user/{id}/progress/, so it has to
        // be fetched and merged in separately, and only once the list itself exists.
        fetchProgress() {
            if (this.isGuest || !this.userId) return
            this.$store.dispatch('fetchUserProgress', this.userId)
                .catch(err => console.error('Error fetching simulator progress:', err))
        },

        labelLevel(l) {
            if (l === 'intro') return this.$t('components.simulator.levels.intro')
            if (l === 'core') return this.$t('components.simulator.levels.core')
            return this.$t('components.simulator.levels.advanced')
        },

        statusKey(s) {
            if (s.status === 'Done') return 'is-done'
            if (s.status === 'In progress') return 'is-progress'
            return 'is-todo'
        },

        statusLabel(s) {
            if (s.status === 'Done') return this.$t('components.simulator.status.done')
            if (s.status === 'In progress') return this.$t('components.simulator.status.inProgress')
            return this.$t('components.simulator.status.notStarted')
        },

        buttonLabel(s) {
            if (this.isLocked(s)) return this.$t('components.simulator.home.locked')
            if (s.status === 'Done') return this.$t('components.simulator.home.reviewSimulation')
            if (s.status === 'In progress') return this.$t('components.simulator.home.continueSimulation')
            return this.$t('components.simulator.home.startSimulation')
        },

        isLocked(s) {
            return this.isGuest && (!this.freeSimulator || s.id !== this.freeSimulator.id)
        },

        goPlay(s) {
            if (this.isLocked(s)) {
                this.$message.success(this.$t('components.simulator.home.loginRequired'))
                return
            } else if (this.isGuest) {
                // Guests have no user id to reset metrics against - the free
                // simulator just starts fresh every time.
                this.$router.push({ path: '/simulator/play', query: { id: s.id } })
            } else {
                // Reset all metrics to 50 before entering simulator
                this.$store.dispatch('resetSimulatorMetrics', s.id)
                    .then(() => {
                        // Navigate to simulator after metrics are reset
                        this.$router.push({ path: '/simulator/play', query: { id: s.id } })
                    })
                    .catch(err => {
                        console.error('Error resetting metrics:', err)
                        // Still navigate even if reset fails
                        this.$router.push({ path: '/simulator/play', query: { id: s.id } })
                    })
            }
        }
    }
}
