export default {
    name: 'SimulatorPlay',

    data() {
        return {
            error: null,
            mode: 'calm',
            stepIndex: 0,
            locked: false,
            feedback: '',
            done: false,
            totalScore: 0,
            loading: true,
            scenario: {},
            selectedAnswers: {}
        }
    },

    computed: {
        simulatorCards() {
            return this.$store.state.simulatorCards || []
        },

        simulatorTags() {
            return this.$store.state.simulatorTags || []
        },

        simulatorMetrics() {
            return this.$store.state.simulatorMetrics || []
        },

        steps() {
            return this.transformCardsToSteps(this.simulatorCards)
        },

        meterKeys() {
            if (!Array.isArray(this.simulatorMetrics)) {
                return []
            }
            const keys = this.simulatorMetrics.map(m => m.name || m.label) || []
            return keys
        },

        meters() {
            const meters = {}
            if (Array.isArray(this.simulatorMetrics)) {
                this.simulatorMetrics.forEach(m => {
                    meters[m.name || m.label] = m.value || m.initial_value || 50
                })
            }
            return meters
        },

        modeLabel() {
            return this.mode === 'timed' ? 'Challenge mode' : 'Calm mode'
        },

        current() {
            return this.steps[this.stepIndex] || {}
        },

        needsChoice() {
            if (!this.current.components) return false
            return this.current.components.some(c => c.type === 'mcq')
        }
    },

    mounted() {
        this.fetchSimulator()
    },

    methods: {
        // Fetch simulator cards, tags, and metrics from API
        fetchSimulator() {
            // Get simulator ID from route query
            const simulatorId = this.$route.query.id

            if (!simulatorId) {
                this.error = 'No simulator ID provided.'
                this.loading = false
                return
            }

            this.error = null

            // If cards are already cached, display immediately
            const hasCache = this.simulatorCards.length > 0
            if (hasCache) {
                this.loading = false
                this.scenario.title = this.simulatorCards[0].title || 'Simulator'
                this.scenario.level = this.simulatorCards[0].level || 'intro'
            } else {
                this.loading = true
            }

            // Fetch fresh data in background (always refresh tags/metrics, fetch cards only if not cached)
            const cardsPromise = hasCache 
                ? Promise.resolve(true)
                : this.$store.dispatch('fetchSimulatorCards', simulatorId)

            Promise.all([
                cardsPromise,
                this.$store.dispatch('fetchSimulatorTags', simulatorId),
                this.$store.dispatch('fetchSimulatorMetrics', simulatorId)
            ])
                .then(([cardsSuccess]) => {
                    if (cardsSuccess && this.simulatorCards.length > 0) {
                        this.scenario.title = this.simulatorCards[0].title || 'Simulator'
                        this.scenario.level = this.simulatorCards[0].level || 'intro'
                    } else if (!cardsSuccess) {
                        this.error = 'No cards found for this simulator.'
                    }
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching simulator:', err)
                    this.error = 'Failed to load simulator. Please try again.'
                    this.loading = false
                })
        },

        // Transform cards into simulator steps
        transformCardsToSteps(cards) {
            return cards.map((card) => {
                return {
                    id: `card_${card.id}`,
                    kicker: card.subtitle || '',
                    title: card.title || 'Card',
                    text: card.end_text || '',
                    components: card.components || [],
                    why: card.why_this_question,
                    lens: '',
                    choices: []
                }
            })
        },

        goBack() {
            this.$router.push('/simulator')
        },

        restart() {
            this.stepIndex = 0
            this.feedback = ''
            this.done = false
            this.locked = false
            this.totalScore = 0
            this.selectedAnswers = {}
        },

        async choose(option, component) {
            if (!component || !component.options) return
            
            this.locked = true
            this.selectedAnswers[this.current.id] = option.id
            
            try {
                // Get simulator ID from route
                const simulatorId = this.$route.query.id
                
                // TODO: Replace with actual auth when available
                // For now, use fixed userId for testing
                const userId = 1
                
                if (!userId || !simulatorId) {
                    console.error('Missing userId or simulatorId')
                    this.feedback = 'Error: Could not save response.'
                    this.locked = false
                    return
                }
                
                // Call the action to save MCQ response and update metrics
                const response = await this.$store.dispatch('saveSimulatorMCQResponse', {
                    userId: userId,
                    selectedOptionId: option.id,
                    simulatorId: simulatorId
                })
                
                // Use feedback from backend
                this.feedback = response.feedback || option.feedback || 'Good choice.'
                
                // Update total score (can be based on updatedMetrics if needed)
                if (response.updatedMetrics && Array.isArray(response.updatedMetrics)) {
                    // Feedback received, metrics already updated in state
                    console.log('Metrics updated:', response.updatedMetrics)
                }
                this.totalScore += 10
                
            } catch (error) {
                console.error('Error saving MCQ response:', error)
                this.feedback = 'Error saving response. Please try again.'
            } finally {
                // Allow moving forward after a short delay
                setTimeout(() => { this.locked = false }, 250)
            }
        },

        next() {
            if (this.done) return
            if (this.needsChoice && !this.selectedAnswers[this.current.id]) return

            if (this.stepIndex < this.steps.length - 1) {
                this.stepIndex += 1
                this.feedback = ''
            } else {
                this.done = true
                this.finishContent()
            }
        },

        prev() {
            if (this.done) return
            if (this.stepIndex > 0) {
                this.stepIndex -= 1
                this.feedback = ''
            }
        },

        goTo(idx) {
            this.stepIndex = idx
            this.feedback = ''
        },

        goToCourse() {
            this.$router.push('/course')
        },

        labelLevel(level) {
            if (level === 'intro') return 'Intro'
            if (level === 'core') return 'Core'
            return 'Advanced'
        },

        finishContent() {
            this.$router.push('/simulator')
        }
    }
}
