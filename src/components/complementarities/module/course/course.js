export default {
    name: 'CourseMock',

    data() {
        return {
            course: {
                title: 'Loading course...',
                track: 'Module'
            },

            currentIndex: 0,

            // fake "reading" playbar
            reading: false,
            readingProgress: 0,
            readingTimer: null,

            // touch/swipe
            touchStartX: 0,
            touchCurrentX: 0,
            dragging: false,

            // answers
            answers: {},
            openAnswers: {},

            // Loading state
            loading: true,
            error: null,
        }
    },

    mounted() {
        this.fetchCards()
    },

    computed: {

        courseCards() {
            return this.$store.state.courseCards || []
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
            // Check if there's an open question that needs answering
            const hasOpenQ = (slide.components || []).some(c => c.type === 'open question')
            if (hasOpenQ && !this.openAnswers[slide.id]) return false
            return true
        }
    },

    methods: {
        // Fetch cards from module API
        fetchCards() {
            this.loading = true
            this.error = null
            
            // Get module ID from URL query params
            const moduleId = this.$route.query.id
            
            if (!moduleId) {
                this.error = 'No module ID provided.'
                this.loading = false
                return
            }
            
            // Fetch the cards for this module
            this.$store.dispatch('fetchCourseCards', moduleId)
                .then(() => {

                    if (this.courseCards.length === 0) {
                        this.error = 'No cards found for this module.'
                        this.loading = false
                        return
                    }

                    // Transform cards into slides
                    this.slides = this.transformCardsToSlides(this.courseCards)

                    // Set course title
                    if (this.courseCards.length > 0) {
                        this.course.title = this.courseCards[0].title || 'Module'
                    }

                    this.loading = false
                })
                .catch(err => {
                    console.error('Error while fetching module cards:', err)
                    this.error = 'Impossible to load module. Please try again later.'
                    this.loading = false
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
                    type: 'card',
                    title: card.title || 'Card',
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
                    title: 'Completed',
                    text: 'Great! You have completed this module. Your progress has been saved.'
                })
            }

            return slides
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

        next() {
            if (this.currentIndex < this.slides.length - 1) {
                this.currentIndex += 1
                this.syncReadingToSlide()
            } else {
                this.reading = false
                this.stopReadingTimer()
                this.finishContent()
            }
        },

        prev() {
            if (this.currentIndex > 0) {
                this.currentIndex -= 1
                this.syncReadingToSlide()
            }
        },

        goTo(idx) {
            this.currentIndex = idx
            this.syncReadingToSlide()
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
            console.log('answers after select:', this.answers)
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
        }
    },

    beforeDestroy() {
        this.stopReadingTimer()
    }
}
