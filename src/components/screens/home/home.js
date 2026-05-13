import confetti from 'canvas-confetti'
import { api } from '@/store/actions.js'

export default {
    name: 'PowerCheck',

    data() {
        return {
            selectedAnswers: {},
            selectedScores: {},
            isCompleted: false,
            recommendations: [],
            historyDays: [],
            streak: 0,
        }
    },

    mounted() {
        this.fetchQuestions()
        this.fetchHistory()
    },

    computed: {
        questions() {
            return this.$store.state.dailyCheckinQuestions || []
        },

        userId() {
            return this.$store.state.user?.id
        },

        powerScore() {
            const scores = Object.values(this.selectedScores)
            if (scores.length === 0) return 0
            return Math.round(Math.min(100, scores.reduce((a, b) => a + b, 0)))
        },

        stateLabel() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return 'Find your power'
            const s = this.powerScore
            if (s >= 70) return 'Rising'
            if (s <= 45) return 'Drained'
            return 'Stable'
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
                this.triggerConfetti()
                // Fetch recommendations after submission
                setTimeout(() => {
                    this.fetchRecommendations()
                    this.fetchHistory()
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

        triggerConfetti() {
            const scalar = 7
            const emoji = confetti.shapeFromText({ text: this.stateEmoji, scalar })
            const duration = 1000
            const animationEnd = Date.now() + duration

            const frame = () => {
                confetti({
                    particleCount: 3, angle: 60, spread: 55,
                    origin: { x: 0 }, shapes: [emoji],
                    ticks: 200, gravity: 1.2, scalar
                })
                confetti({
                    particleCount: 3, angle: 120, spread: 55,
                    origin: { x: 1 }, shapes: [emoji],
                    ticks: 200, gravity: 1.2, scalar
                })
                if (Date.now() < animationEnd) requestAnimationFrame(frame)
            }
            frame()
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