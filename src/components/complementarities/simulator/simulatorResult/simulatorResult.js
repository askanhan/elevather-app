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
            level: this.$t('components.simulator.result.defaultLevel'),
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
            if (this.scorePercentage >= 80) return this.$t('components.simulator.result.feedback.excellent')
            if (this.scorePercentage >= 60) return this.$t('components.simulator.result.feedback.great')
            return this.$t('components.simulator.result.feedback.good')
        },

        adviceText() {
            return this.advice || this.$t('components.simulator.result.defaultAdvice')
        },

        userId() {
            return this.$store.state.user?.id
        }
    },

    mounted() {
        // Get simulator ID from props or route query
        this.simulatorId = this.simulatorIdProp || this.$route.query.id
        
        if (!this.simulatorId) {
            this.error = this.$t('components.simulator.errors.noSimulatorId')
            this.loading = false
            return
        }

        if (!this.userId) {
            this.error = this.$t('components.simulator.result.errors.notAuthenticated')
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
                    this.error = this.$t('components.simulator.result.errors.invalidResponse')
                }
            } catch (err) {
                console.error('Error fetching results:', err)
                this.error = this.$t('components.simulator.result.errors.loadFailed')
            } finally {
                this.loading = false
            }
        },

        // Process API response and populate component data
        processResultsData(response) {
            this.apiResponse = response
            
            if (!response.feedbacks || response.feedbacks.length === 0) {
                this.error = this.$t('components.simulator.result.errors.noFeedbackData')
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
            this.simulatorTitle = this.$route.query.title || this.$t('components.simulator.result.defaultTitle')
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
                this.error = this.$t('components.simulator.result.errors.saveFailed')
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
