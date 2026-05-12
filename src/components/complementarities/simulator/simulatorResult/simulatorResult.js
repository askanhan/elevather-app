export default {
    name: 'SimulatorResult',

    props: {
        simulatorIdProp: {
            type: [String, Number],
            default: null
        },
        isModal: {
            type: Boolean,
            default: false
        },
        debriefDataProp: {
            type: Object,
            default: null
        }
    },

    data() {
        return {
            simulatorId: null,
            simulatorTitle: '',
            score: 0,
            maxScore: 100,
            level: 'Intermediate',
            completedAt: new Date(),
            feedback: '',
            advice: '',
            metricsResults: [],
            loading: true,
            error: null,
            saveInProgress: false,
            apiResponse: null
        }
    },

    computed: {
        scorePercentage() {
            return Math.round((this.score / this.maxScore) * 100)
        },

        feedbackMessage() {
            if (this.scorePercentage >= 80) return 'Excellent! You mastered this challenge.'
            if (this.scorePercentage >= 60) return 'Great job! Keep improving.'
            return 'Good attempt. Try again to improve.'
        },

        adviceText() {
            return this.advice || 'Complete the recommended practice to strengthen your skills.'
        },

        userId() {
            return this.$store.state.user?.id
        }
    },

    mounted() {
        // Get simulator ID from props or route query
        this.simulatorId = this.simulatorIdProp || this.$route.query.id
        
        if (!this.simulatorId) {
            this.error = 'No simulator ID provided.'
            this.loading = false
            return
        }

        if (!this.userId) {
            this.error = 'User not authenticated.'
            this.loading = false
            return
        }

        // If debriefData passed as prop, use it directly; otherwise fetch from API
        if (this.debriefDataProp) {
            this.processResultsData(this.debriefDataProp)
            this.loading = false
        } else {
            this.fetchResults()
        }
    },

    methods: {
        // Fetch results from API
        async fetchResults() {
            this.loading = true
            this.error = null
            
            try {
                const response = await this.$store.dispatch('fetchSimulatorResults', {
                    userId: this.userId,
                    simulatorId: this.simulatorId
                })

                if (response && response.feedbacks) {
                    this.processResultsData(response)
                } else {
                    this.error = 'Invalid response format from server.'
                }
            } catch (err) {
                console.error('Error fetching results:', err)
                this.error = 'Failed to load results. Please try again.'
            } finally {
                this.loading = false
            }
        },

        // Process API response and populate component data
        processResultsData(response) {
            this.apiResponse = response
            
            if (!response.feedbacks || response.feedbacks.length === 0) {
                this.error = 'No feedback data available.'
                return
            }

            // Calculate overall score from metric scores
            const scores = response.feedbacks.map(f => f.score)
            this.score = Math.round(scores.reduce((a, b) => a + b, 0) / scores.length)

            // Build metrics results for display
            this.metricsResults = response.feedbacks.map(feedback => ({
                name: feedback.metric_name,
                value: feedback.score,
                strength: feedback.strength,
                risk: feedback.risk,
                practice: feedback.practice,
                recommendation: feedback.recommendation
            }))

            // Generate advice from risks or practices
            const risks = response.feedbacks.filter(f => f.risk).map(f => f.risk)
            if (risks.length > 0) {
                this.advice = risks[0] // Use first risk as advice
            }

            // Get simulator title from route or default
            this.simulatorTitle = this.$route.query.title || 'Simulator Challenge'
            this.completedAt = new Date()
        },

        // Save result to store and navigate
        async saveResult() {
            this.saveInProgress = true
            
            console.log('🔵 saveResult() called')
            console.log('isModal:', this.isModal)
            
            try {
                this.saveInProgress = false
                
                // If used as modal, emit event; otherwise navigate
                if (this.isModal) {
                    console.log('📤 Emitting close event')
                    this.$emit('close')
                } else {
                    this.$router.push('/simulators')
                }
            } catch (err) {
                console.error('Error saving result:', err)
                this.error = 'Failed to save results. Please try again.'
                this.saveInProgress = false
            }
        },

        // Go back to simulators list or close modal
        goBack() {
            if (this.isModal) {
                this.$emit('close')
            } else {
                this.$router.push('/simulators')
            }
        },

        // Retry simulator
        retrySimulator() {
            this.$router.push(`/simulator-play?id=${this.simulatorId}`)
        },

        // Format date
        formatDate(date) {
            return new Date(date).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            })
        }
    }
}
