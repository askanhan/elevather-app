import { api } from '@/store/actions.js'

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
            },

            steps: []
        }
    },

    computed: {
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
        // Fetch simulator cards from API
        fetchSimulator() {
            this.loading = true
            this.error = null

            // Get simulator ID from route query
            const simulatorId = this.$route.query.id

            if (!simulatorId) {
                this.error = 'No simulator ID provided.'
                this.loading = false
                return
            }

            // Fetch the cards for this simulator
            api.get(`/simulator/${simulatorId}/cards-full/`)
                .then(response => {
                    const cardsData = response.data

                    if (!cardsData || !cardsData.cards || cardsData.cards.length === 0) {
                        this.error = 'No cards found for this simulator.'
                        this.loading = false
                        return
                    }

                    // Transform cards into steps
                    this.steps = this.transformCardsToSteps(cardsData.cards)

                    // Set scenario title
                    if (cardsData.cards.length > 0) {
                        this.scenario.title = cardsData.cards[0].title || 'Simulator'
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
