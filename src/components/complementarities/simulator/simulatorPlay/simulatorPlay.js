import SimulatorResult from '@/components/complementarities/simulator/simulatorResult/simulatorResult.vue'
import AudioButton from '@/components/complementarities/audioPlayer/audioButton.vue'
import VideoPlayer from '@/components/complementarities/video-player/video-player.vue'
import imageOperations from '@/mixins/image-operations.js'
import videoOperations from '@/mixins/video-operations.js'

export default {
    name: 'SimulatorPlay',

    components: {
        SimulatorResult,
        AudioButton,
        VideoPlayer
    },

    mixins: [imageOperations, videoOperations],

    data() {
        return {
            simulatorId: null,
            error: null,
            mode: 'calm',
            stepIndex: 0,
            locked: false,
            feedback: '',
            done: false,
            totalScore: 0,
            loading: true,
            scenario: {},
            selectedAnswers: {},
            showResults: false,
            showDebrief: false,
            debriefData: null,
            debriefLoading: false,
            stageHeight: 'auto'
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
                    // Initialize with value, initial_value, or default 50
                    const score = m.value !== undefined ? m.value : (m.initial_value || 50)
                    meters[m.name || m.label] = score
                })
            }
            return meters
        },

        current() {
            return this.steps[this.stepIndex] || {}
        },

        needsChoice() {
            return this.current && this.current.components &&
                   this.current.components.some(c => c.type === 'mcq')
        },

        progressPercent() {
            if (!this.steps.length) return 0
            return Math.round(((this.stepIndex + 1) / this.steps.length) * 100)
        }
    },

    methods: {
        meterTone(value) {
            if (value >= 70) return 'high'
            if (value >= 40) return 'mid'
            return 'low'
        },

        fetchSimulator() {
            if (!this.simulatorId) {
                this.error = this.$t('components.simulator.errors.noSimulatorId')
                this.loading = false
                return
            }

            this.error = null
            
            // Update progress to "In progress" when starting simulator
            const userId = this.$store.state.user.id
            this.$store.dispatch('updateUserProgress', {
                userId: userId,
                ownerType: 'simulator',
                ownerId: this.simulatorId,
                status: 'In progress'
            })
                .catch(err => console.error('Error marking simulator as in progress:', err))

            // If cards are already cached, display immediately
            const hasCache = this.simulatorCards.length > 0
            if (hasCache) {
                this.loading = false
                this.scenario.title = this.simulatorCards[0].title || this.$t('components.simulator.play.defaultScenarioTitle')
                this.scenario.level = this.simulatorCards[0].level || 'intro'
            } else {
                this.loading = true
            }

            // Fetch fresh data in background (always refresh tags/metrics, fetch cards only if not cached)
            const cardsPromise = hasCache 
                ? Promise.resolve(true)
                : this.$store.dispatch('fetchSimulatorCards', this.simulatorId)

            Promise.all([
                cardsPromise,
                this.$store.dispatch('fetchSimulatorTags', this.simulatorId),
                this.$store.dispatch('fetchSimulatorMetrics', this.simulatorId)
            ])
                .then(([cardsSuccess]) => {
                    if (cardsSuccess && this.simulatorCards.length > 0) {
                        this.scenario.title = this.simulatorCards[0].title || this.$t('components.simulator.play.defaultScenarioTitle')
                        this.scenario.level = this.simulatorCards[0].level || 'intro'
                    } else if (!cardsSuccess) {
                        this.error = this.$t('components.simulator.play.errors.noCards')
                    }
                    
                    // Initialize metrics with default values if empty
                    if ((!this.simulatorMetrics || this.simulatorMetrics.length === 0)) {
                        console.log('⚠️ No metrics from backend, initializing with defaults...')
                        // Default metrics initialization - adjust names based on your simulator
                        const defaultMetrics = [
                            { name: 'Authority', value: 50, initial_value: 50 },
                            { name: 'Clarity', value: 50, initial_value: 50 },
                            { name: 'Empathy', value: 50, initial_value: 50 }
                        ]
                        this.$store.commit('SET_SIMULATOR_METRICS', defaultMetrics)
                        console.log('✅ Default metrics initialized')
                    }
                    
                    this.loading = false
                })
                .catch(err => {
                    console.error('Error fetching simulator:', err)
                    this.error = this.$t('components.simulator.play.errors.loadFailed')
                    this.loading = false
                })
        },

        // Transform cards into simulator steps
        transformCardsToSteps(cards) {
            return cards.map((card) => {
                return {
                    id: `card_${card.id}`,
                    cardId: card.id,  // Store numeric ID separately for audio
                    kicker: card.subtitle || '',
                    title: card.title || this.$t('components.simulator.play.defaultCardTitle'),
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
            const previousAnswer = this.selectedAnswers[this.current.id]
            this.selectedAnswers[this.current.id] = option.id
            
            try {
                const userId = this.$store.state.user?.id

                if (!userId || !this.simulatorId) {
                    console.error('Missing userId or simulatorId')
                    this.feedback = this.$t('components.simulator.play.errors.saveFailed')
                    this.locked = false
                    return
                }
                
                // ========== DEBUG: LOG THE EXACT OPTION BEING SENT ==========
                console.log('========== OPTION SELECTION DEBUG ==========')
                console.log('Question ID:', this.current.id)
                console.log('Option object:', option)
                console.log('Option.id being sent:', option.id)
                console.log('Option.text:', option.text)
                console.log('Full option object:', JSON.stringify(option, null, 2))
                
                // Check if this is a new answer or changing a previous answer
                const isChangingAnswer = previousAnswer && previousAnswer !== option.id
                if (isChangingAnswer) {
                    console.log(`⚠️ User changed answer from option ${previousAnswer} to option ${option.id}`)
                }
                
                // Log current metrics before update
                console.log('📊 Metrics BEFORE update:')
                this.$store.state.simulatorMetrics.forEach(m => {
                    console.log(`  ${m.name}: ${m.value}`)
                })
                
                // Call the action to save MCQ response and update metrics
                console.log(
                    `📤 SENDING TO BACKEND: userId=${userId}, selectedOptionId=${option.id}, simulatorId=${this.simulatorId}`
                )
                
                const response = await this.$store.dispatch('saveSimulatorMCQResponse', {
                    userId: userId,
                    selectedOptionId: option.id,
                    simulatorId: this.simulatorId
                })
                
                // Log current metrics after update
                console.log('📊 Metrics AFTER update:')
                this.$store.state.simulatorMetrics.forEach(m => {
                    console.log(`  ${m.name}: ${m.value}`)
                })
                
                // Use feedback from backend
                this.feedback = response.feedback || option.feedback || this.$t('components.simulator.play.defaultFeedback')

                this.$nextTick(() => {
                    this.updateStageHeight();
                });
                
                // ========== VERIFICATION & COMPARISON ==========
                console.log('████████████████████████████████████████')
                console.log('📋 BACKEND RESPONSE:')
                console.log('Backend returned updated metrics:', response.updatedMetrics)
                
                // Verify metrics were actually updated
                if (response.updatedMetrics && Array.isArray(response.updatedMetrics)) {
                    console.log('\n✅ VERIFICATION RESULTS:')
                    
                    // Double-check that state reflects the updates
                    const metersAfter = this.meters
                    response.updatedMetrics.forEach(metric => {
                        // Backend format: {metric: 'Authority', new_score: 35}
                        const metricName = metric.metric_name || metric.name || metric.metric
                        const expectedScore = metric.new_score || metric.score
                        const actualScore = metersAfter[metricName]
                        
                        if (actualScore !== expectedScore) {
                            console.warn(
                                `❌ MISMATCH for ${metricName}: expected ${expectedScore}, got ${actualScore}`
                            )
                        } else {
                            console.log(
                                `✅ ${metricName}: ${actualScore} (correct)`
                            )
                        }
                    })
                }
                
                // Update total score based on actual metric changes
                if (response.updatedMetrics && Array.isArray(response.updatedMetrics)) {
                    const metersAfter = this.meters
                    const score = Object.values(metersAfter).reduce((sum, val) => sum + val, 0) / Object.keys(metersAfter).length
                    this.totalScore = Math.round(score)
                }
                
                console.log('████████████████████████████████████████\n')
                
            } catch (error) {
                console.error('Error saving MCQ response:', error)
                this.feedback = this.$t('components.simulator.play.errors.saveResponseError')
                // Revert the answer on error
                this.selectedAnswers[this.current.id] = previousAnswer
            } finally {
                // Allow moving forward after a short delay
                setTimeout(() => { this.locked = false }, 250)
            }
        },
        updateStageHeight() {
            this.$nextTick(() => {
                // Check if we're showing debrief or regular card to adjust height accordingly
                const debriefElement = this.$el.querySelector('.debriefSection .card');
                const cardElement = this.$el.querySelector('.stage .card');
                
                // if showing debrief, set height based on debrief content; otherwise, use current card height
                if (this.showDebrief && debriefElement) {
                    this.stageHeight = (debriefElement.scrollHeight + 40) + 'px';
                } else if (cardElement) {
                    this.stageHeight = (cardElement.offsetHeight + 32) + 'px';
                }
            });
        },

        next() {
            if (this.done) return
            if (this.needsChoice && !this.selectedAnswers[this.current.id]) return

            if (this.stepIndex < this.steps.length - 1) {
                this.stepIndex += 1
                this.feedback = ''
                this.updateStageHeight()
            } else {
                this.done = true
                this.finishContent()
            }
            this.goToTopOfThePage()
        },
        goToTopOfThePage() {
            this.$nextTick(() => {
                document.querySelector('.app-scroller').scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            })
        },

        prev() {
            if (this.done) return
            if (this.stepIndex > 0) {
                this.stepIndex -= 1
                this.feedback = ''
                this.updateStageHeight()
            }
            
            this.goToTopOfThePage()
        },

        goTo(idx) {
            this.stepIndex = idx
            this.feedback = ''
            this.updateStageHeight()
        },

        goToCourse() {
            this.$router.push('/course')
        },

        labelLevel(level) {
            if (level === 'intro') return this.$t('components.simulator.levels.intro')
            if (level === 'core') return this.$t('components.simulator.levels.core')
            return this.$t('components.simulator.levels.advanced')
        },

        finishContent() {
            // Show results modal instead of redirecting immediately
            this.showResults = true
        },

        handleResultsClose() {
            // Just close the modal - status update happens in finishAndNavigate()
            console.log('🔵 Closing results modal (status NOT updated here)')
            this.showResults = false
        },

        // Show debrief with feedbacks
        async showResultsDebrief() {
            this.debriefLoading = true
            
            try {
                // Get user ID from store (or use default for testing)
                const userId = this.$store.state.user?.id
                
                // Fetch results from API
                const response = await this.$store.dispatch('fetchSimulatorResults', {
                    userId: userId,
                    simulatorId: this.simulatorId
                })
                
                if (response && response.feedbacks) {
                    this.debriefData = response.feedbacks
                    this.showDebrief = true
                    this.showResults = true  // ← SHOW THE RESULTS MODAL
                    
                    // Scroll to debrief section after DOM update
                    this.$nextTick(() => {
                        const debriefSection = document.querySelector('.debriefSection')
                        if (debriefSection) {
                            debriefSection.scrollIntoView({ behavior: 'smooth', block: 'start' })
                        }
                    })
                } else {
                    this.feedback = this.$t('components.simulator.play.errors.loadResultsFailed')
                }
            } catch (err) {
                console.error('Error loading debrief:', err)
                this.feedback = this.$t('components.simulator.play.errors.loadResultsError')
            } finally {
                this.debriefLoading = false
            }
        },

        // Finish and redirect to simulators
        finishAndNavigate() {
            // Update progress to "Done" before navigating
            const userId = this.$store.state.user?.id

            console.log('🟢 finishAndNavigate called')
            console.log('userId:', userId)
            console.log('simulatorId:', this.simulatorId)

            if (!userId) {
                console.error('❌ Missing userId, skipping progress update')
                this.$router.push('/simulator')
                return
            }

            this.$store.dispatch('updateUserProgress', {
                userId: userId,
                ownerType: 'simulator',
                ownerId: this.simulatorId,
                status: 'Done'
            })
                .then(() => {
                    console.log('✅ Simulator marked as DONE in DB')
                    this.$router.push('/simulator')
                })
                .catch(err => {
                    console.error('❌ Error updating simulator progress:', err)
                    // Still navigate even if update fails
                    this.$router.push('/simulator')
                })
        },
        
    },

    

    mounted() {
        // Get simulator ID from route query
        const simulatorId = this.$route.query.id
        if (simulatorId) {
            this.simulatorId = simulatorId
            this.fetchSimulator()
        } else {
            this.error = this.$t('components.simulator.errors.noSimulatorId')
            this.loading = false
        }
    },

    beforeDestroy() {
        // Stop audio when navigating away
        const audioService = require('@/components/complementarities/audioPlayer/audioService.js').default
        audioService.stop()
    }
}

