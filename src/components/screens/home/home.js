import { api } from '@/store/actions.js'
import GuestLockCard from '@/components/complementarities/guest-lock/guest-lock-card.vue'

export default {
    name: 'PowerCheck',

    components: {
        GuestLockCard
    },

    data() {
        return {
            selectedAnswers: {},
            selectedScores: {},
            isCompleted: false,
            celebrate: false,
            recommendations: [],
            historyDays: [],
            streak: 0,
            checkinMetrics: [],
        }
    },

    mounted() {
        this.fetchQuestions()
        this.fetchHistory()
        this.fetchCheckinMetrics()
    },

    computed: {
        questions() {
            const questions = this.$store.state.dailyCheckinQuestions || []
            return questions.sort(() => Math.random() - 0.5).slice(0, 3)
        },

        userId() {
            return this.$store.state.user?.id
        },

        isGuest() {
            return this.$store.state.guestMode || false
        },

        powerScore() {
            const scores = Object.values(this.selectedScores)
            if (scores.length === 0) return 0
            return Math.round(Math.min(100, scores.reduce((a, b) => a + b, 0)))
        },

        stateLabel() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return this.$t('pages.home.powerCheck.states.findYourPower')
            const s = this.powerScore
            if (s >= 70) return this.$t('pages.home.powerCheck.states.rising')
            if (s <= 45) return this.$t('pages.home.powerCheck.states.drained')
            return this.$t('pages.home.powerCheck.states.stable')
        },

        stateEmoji() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return '✨'
            const s = this.powerScore
            if (s >= 70) return '🔥'
            if (s <= 45) return '🔋'
            return '⚡'
        },

        stateClass() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return 'empty'
            const s = this.powerScore
            if (s >= 70) return 'rising'
            if (s <= 45) return 'drained'
            return 'stable'
        },
    },

    methods: {
        fetchQuestions() {
            if (this.isGuest || !this.userId) return
            this.$store.dispatch('fetchDailyCheckinQuestions', this.userId)
                .then((response) => {
                    console.log('Daily checkin questions fetched:', response)
                })
                .catch(err => {
                    console.error('Error fetching questions:', err)
                })
        },

        async fetchHistory() {
            if (!this.userId) return
            try {
                const { data } = await api.get(`/user/${this.userId}/power-history/`)
                this.historyDays = data.days || []
                this.streak = data.current_streak || 0
            } catch (e) {
                console.error('Error fetching history:', e)
            }
        },

        async fetchRecommendations() {
            if (!this.userId) return
            try {
                const { data } = await api.get(`/user/${this.userId}/power-recommendations/`)
                this.recommendations = data.recommendations || []
            } catch (e) {
                console.error('Error fetching recommendations:', e)
            }
        },

        async fetchCheckinMetrics() {
            if (!this.userId) return
            try {
                const { data } = await api.get(`/user/${this.userId}/checkin-metrics/`)
                this.checkinMetrics = data.metrics || []
            } catch (e) {
                console.error('Error fetching checkin metrics:', e)
            }
        },

        // Same rising/stable/drained/empty tiers as the daily power score, so the
        // color language stays consistent across the whole screen.
        metricTier(score) {
            if (score === null || score === undefined) return 'empty'
            if (score >= 70) return 'rising'
            if (score <= 45) return 'drained'
            return 'stable'
        },

        clamp(v) {
            const n = Math.round(v)
            return Math.max(0, Math.min(100, n))
        },

        setCheck(questionId, optionId, scoreValue) {
            this.selectedAnswers[questionId] = optionId
            this.selectedScores[questionId] = scoreValue

            if (Object.keys(this.selectedAnswers).length === 3) {
                this.submitCheckin()
                this.isCompleted = true
                this.triggerCelebration()
                // Fetch recommendations after submission
                setTimeout(() => {
                    this.fetchRecommendations()
                    this.fetchHistory()
                    this.fetchCheckinMetrics()
                }, 500)
            }
        },

        submitCheckin() {
            const optionIds = Object.values(this.selectedAnswers)
            if (optionIds.length !== 3) return

            this.$store.dispatch('submitDailyCheckin', {
                userId: this.userId,
                optionIds: optionIds
            }).catch((error) => {
                console.error('Error submitting daily checkin:', error)
            })
        },

        triggerCelebration() {
            // Single CSS pulse+glow instead of canvas-confetti's per-frame
            // physics simulation, which was janky on lower-end phones.
            // Resets itself via the badge's @animationend handler.
            this.celebrate = false
            this.$nextTick(() => {
                this.celebrate = true
            })
        },

        resetToday() {
            this.selectedAnswers = {}
            this.selectedScores = {}
            this.isCompleted = false
            this.recommendations = []
        },

        goToAction(action) {
            const routes = {
                course: 'journey',
                journey: 'journey',
                reflection: 'reflections',
                goals: 'goals',
                simulator: 'simulator',
                stories: 'stories',
            }
            const name = routes[action] || 'home'
            this.$router.push({ name })
        },
    }
}