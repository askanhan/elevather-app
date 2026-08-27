import AudioButton from '@/components/complementarities/audioPlayer/audioButton.vue'
import VideoPlayer from '@/components/complementarities/video-player/video-player.vue'
import imageOperations from '@/mixins/image-operations.js'
import videoOperations from '@/mixins/video-operations.js'
import audioService from '@/components/complementarities/audioPlayer/audioService.js'

export default {
    name: 'CourseMock',

    components: {
        AudioButton,
        VideoPlayer
    },

    mixins: [imageOperations, videoOperations],

    data() {
        return {
            course: {
                title: this.$t('components.course.defaultTitle'),
                track: 'Module'
            },
            currentIndex: 0,
            reading: false,
            readingProgress: 0,
            readingTimer: null,
            touchStartX: 0,
            touchCurrentX: 0,
            dragging: false,
            answers: {},
            openAnswers: {},
            error: null,
            moduleId: null,
            userId: 1,
            progressStarted: false,
            loading: false,
            stageHeight: 'auto',
            resizeObserver: null,
            stageHeightReleaseTimer: null
        }
    },

    mounted() {
        this.fetchCards()
        window.addEventListener('keydown', this.handleKeydown)
    },

    computed: {

        courseCards() {
            return this.$store.state.courseCards || []
        },

        courseModule() {
            return (this.$store.state.journeyModules || []).find(m => m.id === this.moduleId)
        },

        module() {
            return this.courseModule || { title: this.course.title }
        },

        dayNumber() {
            return this.courseModule ? this.courseModule.day_number : null
        },

        slides() {
            return this.transformCardsToSlides(this.courseCards)
        },

        slidesStyle() {
            const pct = this.currentIndex * 100
            return {
                transform: 'translateX(-' + pct + '%)'
            }
        },

        progressPercent() {
            if (!this.slides.length) return 0
            return ((this.currentIndex + 1) / this.slides.length) * 100
        },

        needsChoice() {
            const slide = this.slides[this.currentIndex]
            if (!slide || slide.type !== 'card') return false
            return (slide.components || []).some(c => c.type === 'mcq' || c.type === 'open question')
        },

        hasAnsweredMCQ() {
            const slide = this.slides[this.currentIndex]
            if (!slide) return true
            // Check if there's an MCQ that needs answering
            const hasMCQ = (slide.components || []).some(c => c.type === 'mcq')
            if (hasMCQ && this.answers[slide.id] === undefined) return false
            // Check if there are open questions that need answering
            const openQuestions = (slide.components || []).filter(c => c.type === 'open question')
            if (openQuestions.some(c => !this.openAnswers[c.id])) return false
            return true
        }
    },

    methods: {
        // Fetch cards from module API
        fetchCards() {
            // Get module ID from URL query params
            const moduleId = parseInt(this.$route.query.id, 10)

            if (!moduleId || isNaN(moduleId)) {
                this.error = this.$t('components.course.errors.noModuleId')
                return
            }

            this.moduleId = moduleId
            this.loading = true
            this.error = null

            // Fetch the cards for this module
            this.$store.dispatch('fetchCourseCards', moduleId)
                .then(() => {
                    if (this.courseCards.length === 0) {
                        this.error = this.$t('components.course.errors.noCards')
                        this.loading = false
                        return
                    }

                    // Fallback title if the module wasn't preloaded (e.g. direct navigation)
                    if (this.courseCards.length > 0) {
                        this.course.title = this.courseCards[0].title || this.$t('components.course.defaultTitle')
                    }

                    this.loading = false
                    if (this.$route.query.done != '1') {
                        this.updateProgressToInProgress(moduleId)
                    }
                })
                .then(() => {
                    this.progressStarted = true
                    this.observeActiveSlide()
                })
                .catch(err => {
                    console.error('Error while fetching module cards:', err)
                    // Only show error if cards weren't loaded
                    if (this.courseCards.length === 0) {
                        this.error = this.$t('components.course.errors.loadFailed')
                    } else {
                        // Cards loaded but progress update failed - log it but don't block
                        console.warn('Progress update failed but cards loaded:', err)
                    }
                    this.loading = false
                })
        },

        updateProgressToInProgress(moduleId) {

            // Update progress to "In progress" - don't block if it fails
            return this.$store.dispatch('updateUserProgress', {
                userId: this.userId,
                ownerType: 'module',
                ownerId: moduleId,
                status: 'In progress'
            })
        },

        // Transform cards data into slides format
        transformCardsToSlides(cards) {
            const slides = []

            if (!cards || cards.length === 0) return slides

            // Process each card and its components
            cards.forEach((card) => {
                const cardSlide = {
                    id: `card_${card.id}`,
                    cardId: card.id,  // Store numeric ID separately for audio
                    type: 'card',
                    title: card.title || this.$t('components.course.defaultCardTitle'),
                    subtitle: card.subtitle || '',
                    components: (card.components || []).sort((a, b) => (a.order || 0) - (b.order || 0)),
                    endText: card.end_text,
                    whyThisQuestion: card.why_this_question
                }
                slides.push(cardSlide)
            })

            // Add completion slide at the end
            if (slides.length > 0) {
                slides.push({
                    id: 'done',
                    type: 'done',
                    title: this.$t('components.course.completedTitle'),
                    text: this.$t('components.course.completedText')
                })
            }

            return slides
        },
        shouldShowComponent(comp, slide) {
            const content = comp.content ? comp.content.trim() : '';

            if (content === '-' || content === '-') {
                return false;
            }

            if (comp.type === 'title' && content === slide.title) {
                return false;
            }

            if ((comp.type === 'subtitle' && content === slide.subtitle)) {
                return false;
            }
            return true;
        },

        goBack() {
            this.$router.go(-1)
        },

        restart() {
            this.currentIndex = 0
            this.reading = false
            this.readingProgress = 0
            this.stopReadingTimer()
        },
        updateStageHeight() {
            this.$nextTick(() => {
                const slides = this.$el.querySelectorAll('.slide');
                const activeSlide = slides[this.currentIndex];

                if (activeSlide) {
                    const inner = activeSlide.querySelector('.slideInner');
                    this.stageHeight = inner ? (inner.offsetHeight + 'px') : 'auto';
                }

                // The pinned pixel height above only exists so `.stage` can animate
                // between slide heights. Content that finishes loading afterwards
                // (video metadata, images) would otherwise stay clipped by
                // overflow:hidden forever, since nothing re-measures it. Once the
                // transition has had time to run, release back to 'auto' so the box
                // naturally follows its content from then on, with no clipping possible.
                clearTimeout(this.stageHeightReleaseTimer)
                this.stageHeightReleaseTimer = setTimeout(() => {
                    this.stageHeight = 'auto'
                }, 350)
            });
        },
        // Extra safety net: while the height is pinned (or if a browser doesn't
        // fire the release in time), keep it in sync with the active slide's real
        // content size as it changes (e.g. video metadata arriving late).
        observeActiveSlide() {
            this.$nextTick(() => {
                if (!this.resizeObserver) {
                    this.resizeObserver = new ResizeObserver(() => this.updateStageHeight())
                } else {
                    this.resizeObserver.disconnect()
                }

                const slides = this.$el.querySelectorAll('.slide');
                const activeSlide = slides[this.currentIndex];
                const inner = activeSlide && activeSlide.querySelector('.slideInner');
                if (inner) {
                    this.resizeObserver.observe(inner)
                }

                this.updateStageHeight();
            });
        },
        goToTopOfThePage() {
            this.$nextTick(() => {
                document.querySelector('.app-scroller').scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            })
        },
        next() {
            audioService.stop()
            // Save open question response before moving to next slide
            const currentSlide = this.slides[this.currentIndex]
            if (currentSlide && currentSlide.type === 'card') {
                const openQuestionComponents = (currentSlide.components || []).filter(c => c.type === 'open question')
                openQuestionComponents.forEach(openQuestionComponent => {
                    const answerText = this.openAnswers[openQuestionComponent.id]
                    if (answerText && answerText.trim()) {
                        // Save the open question response
                        this.$store.dispatch('saveOpenQuestionResponse', {
                            userId: this.userId,
                            openQuestionId: openQuestionComponent.id,
                            answerText: answerText.trim()
                        }).catch((error) => {
                            console.error('Error saving open question:', error)
                        })
                    }
                })
            }

            if (this.currentIndex < this.slides.length - 1) {
                this.currentIndex += 1
                this.syncReadingToSlide()
                this.observeActiveSlide();
            } else {
                // Last slide - finish the course
                this.reading = false
                this.stopReadingTimer()
                this.finishCourse()
            }
            this.goToTopOfThePage()

        },

        prev() {
            audioService.stop()
            if (this.currentIndex > 0) {
                this.currentIndex -= 1
                this.syncReadingToSlide()
                this.observeActiveSlide();
            }
            this.goToTopOfThePage()
        },

        handleKeydown(e) {
            // Spacebar to toggle play/pause (ignore if typing in an input/textarea)
            if (e.code === 'Space' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
                e.preventDefault() // prevent page scroll
                if (audioService.isPlaying()) {
                    audioService.pause()
                } else {
                    audioService.play()
                }
            }
        },

        goTo(idx) {
            audioService.stop()
            this.currentIndex = idx
            this.syncReadingToSlide()
            this.observeActiveSlide();
        },

        toggleReading() {
            this.reading = !this.reading
            if (this.reading) this.startReadingTimer()
            else this.stopReadingTimer()
        },

        startReadingTimer() {
            this.stopReadingTimer()
            this.readingTimer = setInterval(() => {
                if (!this.reading) return

                const step = this.slideIsInteractive() ? 1 : 2

                this.readingProgress = Math.min(100, this.readingProgress + step)

                if (this.readingProgress >= 100) {
                    if (this.currentIndex < this.slides.length - 1) {
                        this.currentIndex += 1
                        this.readingProgress = 0
                    } else {
                        this.reading = false
                        this.stopReadingTimer()
                        this.finishContent()
                    }
                }
            }, 120)
        },

        stopReadingTimer() {
            if (this.readingTimer) {
                clearInterval(this.readingTimer)
                this.readingTimer = null
            }
        },

        syncReadingToSlide() {
            this.readingProgress = 0
        },

        slideIsInteractive() {
            const slide = this.slides[this.currentIndex]
            if (!slide) return false
            if (slide.type === 'card') {
                return (slide.components || []).some(c => c.type === 'mcq' || c.type === 'open question')
            }
            return false
        },

        skipToInteractive() {
            const idx = this.slides.findIndex(s => {
                if (s.type === 'card') {
                    return (s.components || []).some(c => c.type === 'mcq' || c.type === 'open question')
                }
                return false
            })
            if (idx !== -1) this.goTo(idx)
        },

        selectOption(slideId, optionId) {
            console.log('selectOption called:', { slideId, optionId, answers: this.answers })
            this.answers[slideId] = optionId

            // Save the MCQ response to the backend
            this.$store.dispatch('saveMCQResponse', {
                userId: this.userId,
                selectedOptionId: optionId
            })
                .catch((error) => {
                    console.error('Error saving MCQ response:', error)
                    // Show error message but keep the answer selected
                    this.$store.commit('SHOW_MESSAGE', [this.$t('components.course.errors.saveResponseFailed'), 'error'])
                })
        },

        getFeedback(component, optionId) {
            if (!component || !component.options) return ''
            const option = component.options.find(o => o.id == optionId)
            return option ? option.feedback : ''
        },

        onTouchStart(e) {
            if (!e.touches || !e.touches.length) return
            this.dragging = true
            this.touchStartX = e.touches[0].clientX
            this.touchCurrentX = this.touchStartX
        },

        onTouchMove(e) {
            if (!this.dragging || !e.touches || !e.touches.length) return
            this.touchCurrentX = e.touches[0].clientX
        },

        onTouchEnd() {
            if (!this.dragging) return
            this.dragging = false

            const delta = this.touchStartX - this.touchCurrentX

            if (delta > 55) this.next()
            if (delta < -55) this.prev()
        },

        finishContent() {
            this.$router.push('/journey')
        },

        finishCourse() {
            // Update progress to "Done"
            this.$store.dispatch('updateUserProgress', {
                userId: this.userId,
                ownerType: 'module',
                ownerId: this.moduleId,
                status: 'Done'
            })
                .then(() => {
                    this.$router.push('/journey')
                })
                .catch(err => {
                    console.error('Error finishing course:', err)
                    // Still redirect even if update fails
                    this.$router.push('/journey')
                })
        }
    },

    beforeDestroy() {
        this.stopReadingTimer()
        // ---> ADD THIS LINE <---
        window.removeEventListener('keydown', this.handleKeydown)

        // MODIFIED: Since we imported it at the top, we can just call it directly now
        audioService.stop()

        if (this.resizeObserver) {
            this.resizeObserver.disconnect()
        }
        clearTimeout(this.stageHeightReleaseTimer)
    }
}
