<!-- src/views/CourseMock.vue -->
<template>
    <div class="course">
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

                        <!-- Intro -->
                        <template v-if="slide.type === 'intro'">
                            <div class="heroIcon">{{ slide.icon }}</div>
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">You will learn</div>
                                <ul class="ul">
                                    <li v-for="(b, idx) in slide.bullets" :key="idx">{{ b }}</li>
                                </ul>
                            </div>
                        </template>

                        <!-- Text -->
                        <template v-else-if="slide.type === 'text'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Quick practice</div>
                                <div class="miniTask">
                                    <div class="miniLabel">Try this line:</div>
                                    <div class="quote">“{{ slide.practiceLine }}”</div>
                                </div>
                            </div>
                        </template>

                        <!-- Image Placeholder -->
                        <template v-else-if="slide.type === 'image'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="mediaPlaceholder">
                                <div class="phTop">
                                    <span class="phNote">visuals here</span>
                                </div>
                                <div class="phBox">
                                    <div class="phIcon">🖼</div>
                                    <div class="phText">Drop image / infographic</div>
                                </div>
                            </div>

                            <div class="panel">
                                <div class="panelTitle">Reflection</div>
                                <div class="p">{{ slide.prompt }}</div>
                            </div>
                        </template>

                        <!-- Video Placeholder -->
                        <template v-else-if="slide.type === 'video'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="mediaPlaceholder">
                                <div class="phTop">
                                    <span class="phTag">VIDEO PLACEHOLDER</span>
                                    <span class="phNote">Embed or link a short video</span>
                                </div>
                                <div class="phBox">
                                    <div class="phIcon">🎬</div>
                                    <div class="phText">Video player goes here</div>
                                </div>
                            </div>

                            <div class="panel">
                                <div class="panelTitle">Key idea</div>
                                <div class="p">{{ slide.keyIdea }}</div>
                            </div>
                        </template>

                        <!-- Question (MCQ) -->
                        <template v-else-if="slide.type === 'mcq'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Choose one</div>

                                <button v-for="opt in slide.options" :key="opt.id" class="option"
                                    :class="{ selected: answers[slide.id] === opt.id }"
                                    @click="selectOption(slide.id, opt.id)">
                                    <span class="radio" :class="{ on: answers[slide.id] === opt.id }"></span>
                                    <span class="optText">{{ opt.label }}</span>
                                </button>

                                <div v-if="answers[slide.id]" class="feedback">
                                    <div class="feedbackTitle">Feedback</div>
                                    <div class="p">{{ getFeedback(slide, answers[slide.id]) }}</div>
                                </div>
                            </div>
                        </template>

                        <!-- Open question -->
                        <template v-else-if="slide.type === 'open'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Write your answer</div>
                                <textarea class="textarea" :placeholder="slide.placeholder"
                                    v-model="openAnswers[slide.id]"></textarea>

                                <div class="smallHint">
                                    Saved locally (mock). In real app, we’d sync it to the user profile.
                                </div>
                            </div>
                        </template>

                        <!-- Summary -->
                        <template v-else-if="slide.type === 'summary'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">What you practiced</div>
                                <ul class="ul">
                                    <li v-for="(b, idx) in slide.bullets" :key="idx">{{ b }}</li>
                                </ul>
                            </div>

                            <div class="panel">
                                <div class="panelTitle">Next action</div>
                                <div class="quote">{{ slide.nextAction }}</div>
                            </div>
                        </template>

                        <!-- Completed -->
                        <template v-else-if="slide.type === 'done'">
                            <div class="doneIcon">✅</div>
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Course status</div>
                                <div class="statusRow">
                                    <span class="statusPill done">
                                        Done
                                    </span>
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
            Swipe left/right or use Next/Prev. This is a presentation mockup.
        </footer>
    </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: 'CourseMock',

    data() {
        return {
            course: {
                title: 'Boundaries & Saying No',
                track: 'I Dare Track'
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

            slides: [
                {
                    id: 's1',
                    type: 'intro',
                    icon: '🛡️',
                    title: 'You’re starting: Boundaries & Saying No',
                    text: 'In this course, you’ll practice simple boundaries that protect your time and energy without guilt.',
                    bullets: [
                        'A 3-sentence boundary script',
                        'How to handle pushback calmly',
                        'How to stop over-explaining'
                    ]
                },
                {
                    id: 's2',
                    type: 'text',
                    title: 'The boundary formula',
                    text: 'A boundary is not a debate. It is a clear statement + a limit + what happens next. Short is powerful.',
                    practiceLine: 'I can’t take this on. I can do X instead. If that doesn’t work, I’ll need to pass.'
                },
                {
                    id: 's3',
                    type: 'image',
                    title: 'See the pattern',
                    text: 'Many women are trained to “soften” boundaries. This creates confusion and invites negotiation.',
                    prompt: 'Where do you soften your boundaries: work, family, or community?'
                },
                {
                    id: 's4',
                    type: 'video',
                    title: 'Watch: calm delivery',
                    text: 'Tone matters. Calm delivery can feel “rude” at first, because you’re used to cushioning.',
                    keyIdea: 'Calm + short + steady eye contact = clarity.'
                },
                {
                    id: 's5',
                    type: 'mcq',
                    title: 'Quick decision',
                    text: 'Someone asks you to do extra work “just this once” again. What is the best response?',
                    options: [
                        { id: 'a', label: '“Okay… I guess I can try, but I’m really busy.”' },
                        { id: 'b', label: '“No. I’m not available for that. I can support with X.”' },
                        { id: 'c', label: 'Ignore the message and hope it goes away.' }
                    ],
                    feedback: {
                        a: 'This sounds polite, but it leaves the door open and invites negotiation.',
                        b: 'Clear boundary + alternative. Short, calm, and respectful.',
                        c: 'Avoidance often increases stress and weakens your position over time.'
                    }
                },
                {
                    id: 's6',
                    type: 'open',
                    title: 'Your script',
                    text: 'Write one boundary you need this week. Keep it under 3 sentences.',
                    placeholder: 'Example: “I can’t attend the meeting. Please send the notes. If decisions are needed, I’ll respond by Friday.”'
                },
                {
                    id: 's7',
                    type: 'summary',
                    title: 'Summary',
                    text: 'You practiced short boundaries, calm tone, and a clear alternative.',
                    bullets: [
                        'Boundaries are not negotiations',
                        'Short is stronger than long',
                        'Alternatives keep collaboration alive'
                    ],
                    nextAction: 'This week, use your script once in real life. Then come back and mark it as practiced.'
                },
                {
                    id: 's8',
                    type: 'done',
                    title: 'Completed',
                    text: 'Nice. In the real app, this completion updates your Journey progress and unlocks the next module.'
                }
            ]
        }
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
                // finish pressed on last slide
                this.reading = false
                this.stopReadingTimer()
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

        // --- reading playbar (fake) ---
        toggleReading() {
            this.reading = !this.reading
            if (this.reading) this.startReadingTimer()
            else this.stopReadingTimer()
        },

        startReadingTimer() {
            this.stopReadingTimer()
            this.readingTimer = setInterval(() => {
                if (!this.reading) return

                // progress speeds up a bit on shorter slides
                const step = this.slideIsInteractive() ? 1 : 2

                this.readingProgress = Math.min(100, this.readingProgress + step)

                if (this.readingProgress >= 100) {
                    // auto-advance when "reading" is done
                    if (this.currentIndex < this.slides.length - 1) {
                        this.currentIndex += 1
                        this.readingProgress = 0
                    } else {
                        this.reading = false
                        this.stopReadingTimer()
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
            // reset bar on slide change to keep the mock feeling consistent
            this.readingProgress = 0
        },

        slideIsInteractive() {
            const t = this.slides[this.currentIndex]
            return t && (t.type === 'mcq' || t.type === 'open')
        },

        skipToInteractive() {
            const idx = this.slides.findIndex(s => s.type === 'mcq' || s.type === 'open')
            if (idx !== -1) this.goTo(idx)
        },

        // --- questions ---
        selectOption(slideId, optionId) {
            Vue.set(this.answers, slideId, optionId)
        },

        getFeedback(slide, optionId) {
            if (!slide || !slide.feedback) return ''
            return slide.feedback[optionId] || ''
        },

        // --- swipe ---
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

            // threshold
            if (delta > 55) this.next()
            if (delta < -55) this.prev()
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
    padding: 18px 14px 26px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
    color: #0f172a;
}

.topbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 12px;
}

.back {
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

.ghost {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
    white-space: nowrap;
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

.playState {
    font-size: 12px;
    font-weight: 900;
    color: #334155;
}

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

.playHint {
    margin-top: 6px;
    font-size: 12px;
    color: #64748b;
}

.stage {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    overflow: hidden;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
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

.heroIcon {
    font-size: 46px;
    line-height: 1;
    margin-top: 6px;
}

.doneIcon {
    font-size: 42px;
    line-height: 1;
    margin-top: 10px;
}

.h2 {
    margin: 12px 0 8px;
    font-size: 20px;
    font-weight: 900;
}

.p {
    margin: 0;
    color: #475569;
    line-height: 1.45;
}

.panel {
    margin-top: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #fbfdff;
    padding: 12px;
}

.panelTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 8px;
}

.ul {
    margin: 0;
    padding-left: 18px;
    color: #334155;
}

.miniTask {
    display: grid;
    gap: 6px;
}

.miniLabel {
    font-size: 12px;
    font-weight: 900;
    color: #64748b;
}

.quote {
    border-left: 4px solid #e2e8f0;
    padding-left: 10px;
    font-weight: 900;
    color: #0f172a;
}

.mediaPlaceholder {
    margin-top: 12px;
    border: 1px dashed #cbd5e1;
    border-radius: 14px;
    background: #fbfdff;
    padding: 12px;
}

.phTop {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 10px;
}

.phTag {
    font-size: 12px;
    font-weight: 900;
    color: #0f172a;
    border: 1px solid #e2e8f0;
    background: #fff;
    padding: 6px 10px;
    border-radius: 999px;
}

.phNote {
    font-size: 12px;
    color: #64748b;
}

.phBox {
    border-radius: 12px;
    border: 1px solid #e2e8f0;
    background: #fff;
    padding: 18px;
    display: grid;
    place-items: center;
    gap: 6px;
}

.phIcon {
    font-size: 28px;
}

.phText {
    color: #475569;
    font-weight: 900;
}

.option {
    width: 100%;
    text-align: left;
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 14px;
    padding: 12px;
    cursor: pointer;
    display: flex;
    gap: 10px;
    align-items: center;
    margin-bottom: 10px;
}

.option.selected {
    border-color: #94a3b8;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.06);
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
    margin-top: 6px;
}

.feedbackTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 6px;
}

.textarea {
    width: 100%;
    min-height: 120px;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 12px;
    outline: none;
    resize: vertical;
    font-family: inherit;
}

.textarea:focus {
    border-color: #94a3b8;
}

.smallHint {
    margin-top: 8px;
    font-size: 12px;
    color: #64748b;
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
    background: #fff;
}

.statusPill.done {
    background: #f0fdf4;
    border-color: #bbf7d0;
}

.nav {
    margin-top: 14px;
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 10px;
    align-items: center;
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

/* Make the course container fill the viewport */
.course {
  height: 100vh;
  max-width: 980px;
  margin: 0 auto;
  padding: 18px 14px 0; /* bottom handled by safe padding below */
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
}

/* Let the main content scroll, while keeping the bottom nav fixed */
.stage {
  flex: 1 1 auto;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  padding-bottom: 96px; /* reserve space for fixed nav */
  box-sizing: border-box;
}

/* Optional: keep slides area from shrinking weirdly */
.slides {
  min-height: 100%;
}

/* Make each slide content flow naturally and allow scrolling */
.slideInner {
  padding: 16px;
  padding-bottom: 24px;
}

/* Fixed bottom navigation */
.nav {
  position: fixed;
  left: 50%;
  transform: translateX(-50%);
  bottom: 12px;

  width: min(980px, calc(100% - 28px));
  z-index: 50;

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

/* Ensure footer text doesn't sit under the fixed nav */
.footerHint {
  padding-bottom: 92px; /* same-ish as nav height */
}

/* On iOS with home indicator, add safe-area padding */
@supports (padding: max(0px)) {
  .nav {
    bottom: max(12px, env(safe-area-inset-bottom));
  }

  .stage {
    padding-bottom: calc(96px + env(safe-area-inset-bottom));
  }

  .footerHint {
    padding-bottom: calc(92px + env(safe-area-inset-bottom));
  }
}

/* ---- FIXED NAV + SCROLL STAGE (override) ---- */

/* course fills viewport */
.course {
  height: 100vh;
  display: flex;
  flex-direction: column;
  padding-bottom: 0;
}

/* stage must be the scroll container */
.stage {
  flex: 1 1 auto;
  overflow-y: auto !important;   /* override earlier overflow:hidden */
  overflow-x: hidden !important;
  -webkit-overflow-scrolling: touch;
  padding-bottom: 120px;         /* room for fixed nav */
}

/* keep slides normal; only translate horizontally */
.slides {
  width: 100%;
  display: flex;
  transition: transform 0.18s ease;
  will-change: transform;
}

/* IMPORTANT: nav fixed and above everything */
.nav {
  position: fixed !important;
  left: 50%;
  transform: translateX(-50%);
  bottom: 12px;

  width: min(980px, calc(100% - 28px));
  z-index: 9999;                 /* make sure it stays above slides */
  pointer-events: auto;          /* ensure clickable */
}

/* iOS / Android safe-area */
@supports (padding: max(0px)) {
  .nav {
    bottom: max(12px, env(safe-area-inset-bottom));
  }

  .stage {
    padding-bottom: calc(120px + env(safe-area-inset-bottom));
  }
}

/* footer shouldn't push layout; it can be hidden or padded */
.footerHint {
  display: none;                 /* optional: remove to avoid extra space */
}

/* Optional: prevent any parent creating weird clipping */
.course,
.stage,
.slide,
.slideInner {
  overflow: visible;
}

/* If your webview is aggressive with fixed elements, this helps */
.nav {
  transform: translate3d(-50%, 0, 0);
}

.course {
  height: 100vh;
  max-width: 980px;
  margin: 0 auto;
  padding: 18px 14px 0;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
}

/* Stage scrolls; content never hides behind fixed nav */
.stage {
  flex: 1 1 auto;
  overflow-y: auto;
  overflow-x: hidden;
  -webkit-overflow-scrolling: touch;
  padding-bottom: 130px; /* space for nav */
  box-sizing: border-box;
}

/* Keep slide animation */
.slides {
  display: flex;
  width: 100%;
  transition: transform 0.18s ease;
  will-change: transform;
}

.slide { min-width: 100%; }

/* Nav is now outside the transformed slides, so fixed works everywhere */
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

/* Safe area for iOS home bar */
@supports (padding: max(0px)) {
  .nav { bottom: max(12px, env(safe-area-inset-bottom)); }
  .stage { padding-bottom: calc(130px + env(safe-area-inset-bottom)); }
}
</style>