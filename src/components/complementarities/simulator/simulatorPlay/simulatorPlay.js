export default {
    name: 'SimulatorPlay',

    data() {
        return {
            loading: true,
            error: null,
            mode: 'calm',
            stepIndex: 0,
            locked: false,
            feedback: '',
            done: false,
            totalScore: 0,

            meters: {
                Clarity: 50,
                Care: 50,
                Impact: 50,
                Boundaries: 50
            },

            scenario: {
                title: 'Loading...',
                level: 'intro'
            }
        }
    },

    computed: {
        simulatorCards() {
            return this.$store.state.simulatorCards || []
        },

        steps() {
            return this.transformCardsToSteps(this.simulatorCards)
        },

        meterKeys() {
            return Object.keys(this.meters)
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
        // Fetch simulator cards from store with cache check
        fetchSimulator() {
            // Get simulator ID from route query
            const simulatorId = this.$route.query.id

            if (!simulatorId) {
                this.error = 'No simulator ID provided.'
                this.loading = false
                return
            }

            // Check cache first
            const cachedCards = this.$store.state.simulatorCardsCache[simulatorId]
            if (cachedCards && cachedCards.length > 0) {
                // Cache hit - display immediately
                this.loading = false
                this.error = null
                if (cachedCards.length > 0) {
                    this.scenario.title = cachedCards[0].title || 'Simulator'
                }
                return
            }

            // Cache miss - dispatch action to fetch from API
            this.loading = true
            this.error = null

            this.$store.dispatch('fetchSimulatorCards', simulatorId)
                .then(success => {
                    if (success && this.simulatorCards.length > 0) {
                        this.scenario.title = this.simulatorCards[0].title || 'Simulator'
                    } else if (!success) {
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

        labelLevel(l) {
            if (l === 'intro') return 'Intro'
            if (l === 'core') return 'Core'
            return 'Advanced'
        },

        goBack() {
            this.$router.push('/simulator')
        },

        restart() {
            this.stepIndex = 0
            this.feedback = ''
            this.done = false
            this.locked = false
            this.meters = { Clarity: 50, Care: 50, Impact: 50, Boundaries: 50 }
            this.totalScore = 0
        },

        choose(option, component) {
            if (!component || !component.options) return
            this.locked = true
            this.feedback = option.feedback || 'Good choice.'
            
            // Simple scoring
            this.totalScore += 10
            
            setTimeout(() => { this.locked = false }, 250)
        },

        next() {
            if (this.done) return
            if (this.needsChoice && !this.feedback) return

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

        goToCourse() {
            this.$router.push('/course')
        },

        finishContent() {
            this.$router.push('/simulator')
        }
    }
}
