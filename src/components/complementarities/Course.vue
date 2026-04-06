<!-- src/components/complementarities/Course.vue -->
<template>
    <div class="course">
        <!-- Error message -->
        <div v-if="error" class="error-message">
            ⚠️ {{ error }}
        </div>

        <!-- Loading message -->
        <div v-if="loading" class="loading-message">
            Loading course content...
        </div>

        <!-- Course content -->
        <template v-if="!loading && !error">
        <!-- Top bar -->
        <header class="topbar">
            <button class="back" @click="goBack">←</button>

            <div class="titleWrap">
                <div class="courseTitle">{{ course.title }}</div>
                <div class="courseMeta">
                    <span class="chip">{{ course.track }}</span>
                    <span class="chip">{{ currentIndex + 1 }}/{{ slides.length }}</span>
                </div>
            </div>

            <button class="ghost" @click="restart">Restart</button>
        </header>

        <!-- Playbar -->
        <section class="playbar">
            <button class="playBtn" @click="toggleReading">
                <span v-if="!reading">▶</span>
                <span v-else>⏸</span>
            </button>

            <div class="playInfo">
                <div class="playTop">
                    <span class="playState">{{ reading ? 'Reading…' : 'Ready' }}</span>
                    <span class="playPct">{{ readingProgress }}%</span>
                </div>
                <div class="progress">
                    <div class="fill" :style="{ width: readingProgress + '%' }"></div>
                </div>
            </div>

            <button class="ghost" @click="skipToInteractive">
                Skip to question
            </button>
        </section>

        <!-- Swipeable stage -->
        <section class="stage" @touchstart="onTouchStart" @touchmove="onTouchMove" @touchend="onTouchEnd">
            <div class="slides" :style="slidesStyle">
                <article v-for="(slide, i) in slides" :key="slide.id" class="slide">
                    <div class="slideInner">

                        <!-- Card with components -->
                        <template v-if="slide.type === 'card'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p v-if="slide.subtitle" class="subtitle">{{ slide.subtitle }}</p>

                            <!-- Render components -->
                            <div v-for="comp in slide.components" :key="comp.order" class="component">
                                <!-- Title -->
                                <div v-if="comp.type === 'title'" class="comp-title">{{ comp.content }}</div>

                                <!-- Subtitle -->
                                <div v-if="comp.type === 'subtitle'" class="comp-subtitle">{{ comp.content }}</div>

                                <!-- Text -->
                                <div v-if="comp.type === 'text'" class="comp-text">{{ comp.content }}</div>

                                <!-- Quote -->
                                <div v-if="comp.type === 'quote'" class="comp-quote">
                                    <div class="quote-text">"{{ comp.content }}"</div>
                                    <div class="quote-author">— {{ comp.author }}</div>
                                </div>

                                <!-- Image -->
                                <div v-if="comp.type === 'image'" class="comp-image">
                                    <img :src="comp.url" :alt="comp.alt || 'Image'" />
                                    <p v-if="comp.description" class="image-desc">{{ comp.description }}</p>
                                </div>

                                <!-- Video -->
                                <div v-if="comp.type === 'video'" class="comp-video">
                                    <div class="video-placeholder">
                                        <div class="video-icon">🎬</div>
                                        <div class="video-url">{{ comp.url }}</div>
                                        <div v-if="comp.duration" class="video-duration">Duration: {{ comp.duration }} min</div>
                                    </div>
                                    <p v-if="comp.description" class="video-desc">{{ comp.description }}</p>
                                </div>

                                <!-- MCQ -->
                                <div v-if="comp.type === 'mcq'" class="comp-mcq">
                                    <div class="mcq-question">{{ comp.question }}</div>
                                    <button v-for="opt in comp.options" :key="opt.id" class="option"
                                        :class="{ selected: answers[slide.id] === opt.id }"
                                        @click="selectOption(slide.id, opt.id)">
                                        <span class="radio" :class="{ on: answers[slide.id] === opt.id }"></span>
                                        <span class="optText">{{ opt.text }}</span>
                                    </button>
                                    <div v-if="answers[slide.id]" class="feedback">
                                        <div class="feedbackTitle">Feedback</div>
                                        <div class="p">{{ getFeedback(comp, answers[slide.id]) }}</div>
                                    </div>
                                </div>

                                <!-- Open Question -->
                                <div v-if="comp.type === 'open question'" class="comp-open-question">
                                    <div class="question-label">{{ comp.question }}</div>
                                    <textarea class="textarea" :placeholder="comp.placeholder || 'Your answer...'"
                                        v-model="openAnswers[slide.id]"></textarea>
                                </div>

                                <!-- List -->
                                <div v-if="comp.type === 'list'" class="comp-list">
                                    <ul class="ul">
                                        <li v-for="(item, idx) in comp.content.split('\n').filter(i => i.trim())" :key="idx">
                                            {{ item.trim() }}
                                        </li>
                                    </ul>
                                </div>

                                <!-- Last Message -->
                                <div v-if="comp.type === 'last message'" class="comp-last-message">
                                    <div class="message-box">{{ comp.content }}</div>
                                </div>
                            </div>

                            <!-- End text -->
                            <div v-if="slide.endText" class="end-text">
                                <p>{{ slide.endText }}</p>
                            </div>

                            <!-- Why this question -->
                            <details v-if="slide.whyThisQuestion" class="why">
                                <summary>Why this question</summary>
                                <div class="whyBody">{{ slide.whyThisQuestion }}</div>
                            </details>
                        </template>

                        <!-- Completed -->
                        <template v-else-if="slide.type === 'done'">
                            <div class="doneIcon">✅</div>
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Course status</div>
                                <div class="statusRow">
                                    <span class="statusPill done">Done</span>
                                    <span class="p">This would update the Journey page UI.</span>
                                </div>
                            </div>
                        </template>

                    </div>
                </article>
            </div>
        </section>

        <!-- Bottom navigation -->
        <div class="nav">
            <button class="navBtn" :disabled="currentIndex === 0" @click="prev">
                Prev
            </button>

            <div class="dots">
                <span v-for="(s, idx) in slides" :key="s.id" class="dot"
                    :class="{ active: idx === currentIndex }" @click="goTo(idx)"></span>
            </div>

            <button class="navBtn primary" @click="next">
                {{ currentIndex === slides.length - 1 ? 'Finish' : 'Next' }}
            </button>
        </div>

        <footer class="footerHint">
            Swipe left/right or use Next/Prev. Content loaded from database.
        </footer>
        </template>
    </div>
</template>

<script>
import { api } from '@/store/actions.js'

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
            slides: []
        }
    },

    mounted() {
        this.fetchCards()
    },

    computed: {
        slidesStyle() {
            const pct = this.currentIndex * 100
            return {
                transform: 'translateX(-' + pct + '%)'
            }
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
            api.get(`/module/${moduleId}/cards-full/`)
                .then(response => {
                    const cardsData = response.data
                    
                    if (!cardsData || !cardsData.cards || cardsData.cards.length === 0) {
                        this.error = 'No cards found for this module.'
                        this.loading = false
                        return
                    }

                    // Transform cards into slides
                    this.slides = this.transformCardsToSlides(cardsData.cards)

                    // Set course title
                    if (cardsData.cards.length > 0) {
                        this.course.title = cardsData.cards[0].title || 'Module'
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
            this.$set(this.answers, slideId, optionId)
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
</script>

<style scoped>
.course {
    max-width: 980px;
    margin: 0 auto;
    padding: 18px 14px 0;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
}

.error-message,
.loading-message {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 200px;
    font-size: 16px;
    font-weight: 900;
    color: #475569;
    text-align: center;
    padding: 20px;
}

.error-message {
    color: #dc2626;
    background: #fee2e2;
    border: 1px solid #fecaca;
    border-radius: 12px;
    margin: 12px 0;
}

.topbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 12px;
}

.back,
.ghost {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
}

.titleWrap {
    flex: 1;
    min-width: 0;
    text-align: center;
}

.courseTitle {
    font-weight: 900;
    font-size: 16px;
}

.courseMeta {
    margin-top: 6px;
    display: inline-flex;
    gap: 8px;
    flex-wrap: wrap;
    justify-content: center;
}

.chip {
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
}

.playbar {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    padding: 12px;
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    margin-bottom: 12px;
}

.playBtn {
    width: 44px;
    height: 44px;
    border-radius: 14px;
    border: 1px solid #e2e8f0;
    background: #fff;
    font-size: 18px;
    cursor: pointer;
}

.playInfo {
    flex: 1;
    min-width: 0;
}

.playTop {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 6px;
}

.playState,
.playPct {
    font-size: 12px;
    font-weight: 900;
    color: #0f172a;
}

.progress {
    height: 10px;
    border-radius: 999px;
    background: #f1f5f9;
    overflow: hidden;
    border: 1px solid #e2e8f0;
}

.fill {
    height: 100%;
    width: 0%;
    background: #0f172a;
}

.stage {
    flex: 1 1 auto;
    overflow-y: auto;
    overflow-x: hidden;
    -webkit-overflow-scrolling: touch;
    padding-bottom: 130px;
    box-sizing: border-box;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
}

.slides {
    display: flex;
    width: 100%;
    transition: transform 0.18s ease;
}

.slide {
    min-width: 100%;
}

.slideInner {
    padding: 16px;
}

.h2 {
    margin: 12px 0 8px;
    font-size: 20px;
    font-weight: 900;
}

.subtitle {
    margin: 0 0 12px;
    color: #475569;
}

.p {
    margin: 0;
    color: #475569;
    line-height: 1.45;
}

.component {
    margin-bottom: 16px;
    padding: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    background: #fbfdff;
}

.comp-title {
    font-weight: 900;
    font-size: 18px;
    margin: 0;
}

.comp-subtitle {
    font-weight: 900;
    font-size: 16px;
    margin: 0;
    color: #334155;
}

.comp-text,
.comp-list {
    color: #475569;
    line-height: 1.45;
}

.comp-quote {
    border-left: 4px solid #2D6CDF;
    padding-left: 12px;
    margin: 12px 0;
}

.quote-text {
    font-style: italic;
    color: #0f172a;
    font-weight: 900;
}

.quote-author {
    font-size: 12px;
    color: #64748b;
    margin-top: 6px;
}

.comp-image img {
    max-width: 100%;
    border-radius: 12px;
    margin: 12px 0;
}

.image-desc {
    font-size: 12px;
    color: #64748b;
}

.comp-video {
    margin: 12px 0;
}

.video-placeholder {
    border: 1px dashed #cbd5e1;
    border-radius: 12px;
    padding: 24px;
    text-align: center;
}

.video-icon {
    font-size: 32px;
    margin-bottom: 8px;
}

.video-url,
.video-duration {
    font-size: 12px;
    color: #64748b;
}

.video-desc {
    font-size: 12px;
    color: #64748b;
    margin-top: 8px;
}

.comp-mcq,
.comp-open-question {
    margin: 12px 0;
}

.mcq-question,
.question-label {
    font-weight: 900;
    margin-bottom: 12px;
    color: #0f172a;
}

.option {
    width: 100%;
    text-align: left;
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 12px;
    cursor: pointer;
    display: flex;
    gap: 10px;
    align-items: center;
    margin-bottom: 8px;
}

.option.selected {
    border-color: #94a3b8;
    box-shadow: 0 4px 12px rgba(15, 23, 42, 0.06);
}

.radio {
    width: 18px;
    height: 18px;
    border-radius: 999px;
    border: 2px solid #cbd5e1;
    position: relative;
    flex: 0 0 auto;
}

.radio.on {
    border-color: #0f172a;
}

.radio.on::after {
    content: '';
    width: 10px;
    height: 10px;
    border-radius: 999px;
    background: #0f172a;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.optText {
    font-weight: 900;
    color: #0f172a;
}

.feedback {
    border-top: 1px solid #e2e8f0;
    padding-top: 10px;
    margin-top: 10px;
}

.feedbackTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 6px;
}

.textarea {
    width: 100%;
    min-height: 100px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 12px;
    outline: none;
    resize: vertical;
    font-family: inherit;
}

.ul {
    margin: 0;
    padding-left: 20px;
    color: #334155;
}

.ul li {
    margin-bottom: 6px;
}

.comp-last-message {
    margin: 12px 0;
}

.message-box {
    background: #eff6ff;
    border: 1px solid #bfdbfe;
    border-radius: 12px;
    padding: 12px;
    color: #0f172a;
    font-weight: 900;
}

.end-text {
    margin-top: 16px;
    padding: 12px;
    background: #f8fafc;
    border-left: 4px solid #e2e8f0;
    border-radius: 8px;
}

.why {
    margin-top: 12px;
    padding: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    background: #fbfdff;
}

.why summary {
    font-weight: 900;
    cursor: pointer;
}

.whyBody {
    margin-top: 8px;
    color: #475569;
    line-height: 1.45;
}

.doneIcon {
    font-size: 42px;
    line-height: 1;
    margin-top: 10px;
}

.statusRow {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.statusPill {
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
}

.statusPill.done {
    background: #f0fdf4;
    border-color: #bbf7d0;
}

.nav {
    position: fixed;
    left: 50%;
    transform: translateX(-50%);
    bottom: 12px;
    width: min(980px, calc(100% - 28px));
    z-index: 9999;
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 10px;
    align-items: center;
    padding: 12px;
    border-radius: 16px;
    background: rgba(255, 255, 255, 0.92);
    border: 1px solid #e2e8f0;
    box-shadow: 0 10px 28px rgba(15, 23, 42, 0.10);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
}

.navBtn {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
}

.navBtn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.navBtn.primary {
    border-color: #0f172a;
}

.dots {
    display: inline-flex;
    gap: 6px;
    justify-content: center;
}

.dot {
    width: 8px;
    height: 8px;
    border-radius: 999px;
    background: #e2e8f0;
    cursor: pointer;
}

.dot.active {
    background: #0f172a;
}

.footerHint {
    margin-top: 10px;
    font-size: 12px;
    color: #64748b;
    text-align: center;
}

@supports (padding: max(0px)) {
    .nav {
        bottom: max(12px, env(safe-area-inset-bottom));
    }

    .stage {
        padding-bottom: calc(130px + env(safe-area-inset-bottom));
    }
}
</style>
