<!-- src/components/complementarities/Story.vue -->
<template>
    <div class="story">
        <!-- Top bar -->
        <header class="topbar">
            <button class="back" @click="goBack">←</button>

            <div class="titleWrap">
                <div class="storyTitle">{{ story.title }}</div>
                <div class="storyMeta">
                    <span class="chip">{{ story.type }}</span>
                    <span class="chip">{{ currentIndex + 1 }}/{{ slides.length }}</span>
                </div>
            </div>

            <button class="ghost" @click="restart">Reset</button>
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

                        <!-- Intro / Header -->
                        <template v-if="slide.type === 'intro'">
                            <div class="heroIcon">{{ slide.icon }}</div>
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">About this content</div>
                                <ul class="ul">
                                    <li v-for="(b, idx) in slide.bullets" :key="idx">{{ b }}</li>
                                </ul>
                            </div>
                        </template>

                        <!-- Text Content -->
                        <template v-else-if="slide.type === 'text'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Key Points</div>
                                <ul class="ul">
                                    <li v-for="(point, idx) in slide.points" :key="idx">{{ point }}</li>
                                </ul>
                            </div>
                        </template>

                        <!-- Image -->
                        <template v-else-if="slide.type === 'image'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="mediaPlaceholder">
                                <div class="phTop">
                                    <span class="phNote">{{ slide.mediaType || 'Image here' }}</span>
                                </div>
                                <div class="phBox">
                                    <div class="phIcon">{{ slide.icon || '🖼' }}</div>
                                    <div class="phText">{{ slide.mediaText || 'Visual content' }}</div>
                                </div>
                            </div>

                            <div v-if="slide.description" class="panel">
                                <div class="panelTitle">Description</div>
                                <div class="p">{{ slide.description }}</div>
                            </div>
                        </template>

                        <!-- Video -->
                        <template v-else-if="slide.type === 'video'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="mediaPlaceholder">
                                <div class="phTop">
                                    <span class="phTag">VIDEO</span>
                                    <span class="phNote">{{ slide.duration || '8 min video' }}</span>
                                </div>
                                <div class="phBox">
                                    <div class="phIcon">🎬</div>
                                    <div class="phText">{{ slide.mediaText || 'Video player' }}</div>
                                </div>
                            </div>

                            <div v-if="slide.summary" class="panel">
                                <div class="panelTitle">Video Summary</div>
                                <div class="p">{{ slide.summary }}</div>
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

                        <!-- Open Question -->
                        <template v-else-if="slide.type === 'open'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">{{ slide.label || 'Write your response' }}</div>
                                <textarea class="textarea" :placeholder="slide.placeholder"
                                    v-model="openAnswers[slide.id]"></textarea>

                                <div class="smallHint">
                                    Your response is saved locally in this story.
                                </div>
                            </div>
                        </template>

                        <!-- Summary -->
                        <template v-else-if="slide.type === 'summary'">
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">What you learned</div>
                                <ul class="ul">
                                    <li v-for="(b, idx) in slide.bullets" :key="idx">{{ b }}</li>
                                </ul>
                            </div>

                            <div class="panel">
                                <div class="panelTitle">Next Step</div>
                                <div class="quote">{{ slide.nextAction }}</div>
                            </div>
                        </template>

                        <!-- Completed -->
                        <template v-else-if="slide.type === 'done'">
                            <div class="doneIcon">✅</div>
                            <h2 class="h2">{{ slide.title }}</h2>
                            <p class="p">{{ slide.text }}</p>

                            <div class="panel">
                                <div class="panelTitle">Content Completed</div>
                                <div class="statusRow">
                                    <span class="statusPill done">
                                        Done
                                    </span>
                                    <span class="p">You've completed this content. Great job!</span>
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
            Swipe left/right or use Next/Prev to navigate through this content.
        </footer>
    </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: 'Story',

    data() {
        return {
            // Default story - will be overridden by store data
            story: {
                title: 'Nora\'s Journey',
                type: 'Bio',
                author: 'Nora'
            },

            currentIndex: 0,

            // Reading playbar
            reading: false,
            readingProgress: 0,
            readingTimer: null,

            // Touch/swipe
            touchStartX: 0,
            touchCurrentX: 0,
            dragging: false,

            // Answers
            answers: {},
            openAnswers: {},

            slides: [
                {
                    id: 'intro1',
                    type: 'intro',
                    icon: '👩‍💼',
                    title: 'Nora\'s Journey',
                    text: 'Meet Nora. From a quiet contributor in her NGO, she became the community organizer who changed how her team works together.',
                    bullets: [
                        'How small "brave asks" transformed her confidence',
                        'The power of setting healthy boundaries',
                        'Leading through collaboration, not control'
                    ]
                },
                {
                    id: 'text1',
                    type: 'text',
                    title: 'The Turning Point',
                    text: 'Nora spent five years as a quiet contributor at a nonprofit in Belgium. She attended meetings, completed her tasks, and went home. But she watched the team struggle with unclear roles and burned-out colleagues. One day, she made a small brave ask: "Can we have a team discussion about how we work?"',
                    points: [
                        'Quiet doesn\'t mean powerless',
                        'Asking questions is an act of leadership',
                        'Sometimes the best change starts with one person speaking up'
                    ]
                },
                {
                    id: 'image1',
                    type: 'image',
                    title: 'Nora\'s Workspace',
                    text: 'This is where Nora runs the community coordination—a modest desk surrounded by notes from team members who now trust her to listen.',
                    icon: '📸',
                    mediaType: 'Office photo',
                    mediaText: 'Nora\'s coordination hub',
                    description: 'Her walls are covered with sticky notes from community feedback sessions. Each one reminds her why clear communication matters.'
                },
                {
                    id: 'video1',
                    type: 'video',
                    title: 'Watch: Nora on Building Community Trust',
                    text: 'In this 10-minute video, Nora shares how she used boundaries to actually strengthen relationships instead of breaking them.',
                    duration: '10 min',
                    mediaText: 'Nora speaking at NGO Leaders Summit 2023',
                    summary: 'Key insight: "Boundaries aren\'t walls. They\'re invitations to real collaboration." Setting clear expectations made her team stronger, not weaker.'
                },
                {
                    id: 'mcq1',
                    type: 'mcq',
                    title: 'Reflection',
                    text: 'What was Nora\'s biggest breakthrough?',
                    options: [
                        { id: 'a', label: 'She got promoted to a higher position' },
                        { id: 'b', label: 'She asked for what the team needed and listened for the answers' },
                        { id: 'c', label: 'She changed her personality to be more outgoing' }
                    ],
                    feedback: {
                        a: 'The promotion came later—after she proved her leadership through community organizing.',
                        b: 'Exactly. Her breakthrough was curiosity and honest communication about what everyone needed.',
                        c: 'Nora stayed true to herself. She didn\'t become louder; she became clearer.'
                    }
                },
                {
                    id: 'summary1',
                    type: 'summary',
                    title: 'What You Discovered',
                    text: 'Nora\'s journey shows that communities thrive when someone dares to ask honest questions and set clear boundaries.',
                    bullets: [
                        'Quiet strength can move mountains',
                        'A single brave ask can start a movement',
                        'Boundaries protect trust, not break it',
                        'Community organizing is leadership'
                    ],
                    nextAction: 'Practice your own brave ask in a situation where it matters to you.'
                },
                {
                    id: 'done1',
                    type: 'done',
                    title: 'Excellent Work!',
                    text: 'You\'ve learned from Nora\'s journey. Now go dare to ask what your community needs.'
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

        // --- reading playbar (mock) ---
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

            if (delta > 55) this.next()
            if (delta < -55) this.prev()
        },

        finishContent() {
            // Redirect based on content type - Stories always go back to /stories
            this.$router.push('/stories')
        }
    },

    mounted() {
        // Load story data from store if available
        if (this.$store && this.$store.state && this.$store.state.selectedStory) {
            const storyData = this.$store.state.selectedStory
            // Merge store data with component data
            Object.assign(this.story, storyData)
            
            // Load slides from store if provided, otherwise use default slides
            if (storyData.slides && Array.isArray(storyData.slides)) {
                this.slides = storyData.slides
            }
        }
    },

    beforeDestroy() {
        this.stopReadingTimer()
    }
}
</script>

<style scoped>
.story {
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

.storyTitle {
    font-weight: 900;
    font-size: 16px;
}

.storyMeta {
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

.stage {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    overflow: hidden;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.slides {
    display: flex;
    transition: transform 0.3s ease;
}

.slide {
    flex: 0 0 100%;
    min-width: 0;
}

.slideInner {
    padding: 26px;
    min-height: 400px;
    display: flex;
    flex-direction: column;
}

.heroIcon {
    font-size: 64px;
    margin-bottom: 12px;
}

.h2 {
    font-size: 24px;
    font-weight: 900;
    margin-bottom: 12px;
    line-height: 1.2;
}

.p {
    color: #475569;
    line-height: 1.6;
    margin-bottom: 12px;
}

.panel {
    margin-top: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
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

.ul li {
    margin-bottom: 6px;
    line-height: 1.4;
}

.mediaPlaceholder {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fbfdff;
    overflow: hidden;
    margin: 12px 0;
}

.phTop {
    background: linear-gradient(90deg, rgba(45, 108, 223, 0.06), rgba(255, 45, 122, 0.06));
    border-bottom: 1px solid #e2e8f0;
    padding: 10px 12px;
    display: flex;
    align-items: center;
    gap: 10px;
    justify-content: center;
    text-align: center;
}

.phTag {
    font-weight: 900;
    font-size: 11px;
    background: rgba(45, 108, 223, 0.1);
    padding: 4px 8px;
    border-radius: 6px;
    color: #2d6cdf;
}

.phNote {
    font-size: 12px;
    color: #64748b;
    font-weight: 900;
}

.phBox {
    padding: 60px 20px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
}

.phIcon {
    font-size: 48px;
}

.phText {
    color: #64748b;
    font-weight: 900;
    font-size: 13px;
}

.option {
    width: 100%;
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    transition: all 0.12s ease;
    text-align: left;
}

.option:hover {
    border-color: #cbd5e1;
    background: #f8fafc;
}

.option.selected {
    border-color: #2d6cdf;
    background: rgba(45, 108, 223, 0.05);
}

.radio {
    width: 20px;
    height: 20px;
    border: 2px solid #e2e8f0;
    border-radius: 50%;
    flex: 0 0 auto;
    display: grid;
    place-items: center;
}

.radio.on {
    border-color: #2d6cdf;
    background: #2d6cdf;
}

.radio.on::after {
    content: '';
    width: 6px;
    height: 6px;
    background: #fff;
    border-radius: 50%;
}

.optText {
    font-weight: 900;
    color: #0f172a;
}

.feedback {
    margin-top: 12px;
    border: 1px solid rgba(34, 197, 94, 0.2);
    background: rgba(34, 197, 94, 0.08);
    border-radius: 12px;
    padding: 12px;
}

.feedbackTitle {
    font-weight: 900;
    font-size: 12px;
    color: #166534;
    margin-bottom: 6px;
}

.textarea {
    width: 100%;
    min-height: 120px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 12px;
    outline: none;
    resize: vertical;
    font-family: inherit;
    font-weight: 900;
    color: #0f172a;
    line-height: 1.35;
}

.textarea:focus {
    border-color: rgba(45, 108, 223, 0.35);
    background: #fff;
}

.smallHint {
    margin-top: 6px;
    font-size: 12px;
    color: #64748b;
    font-weight: 900;
}

.nav {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    padding: 12px 14px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    margin-top: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.navBtn {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 10px 14px;
    font-weight: 900;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.12s ease;
    color: #0f172a;
}

.navBtn:hover:not(:disabled) {
    border-color: #cbd5e1;
    background: #f8fafc;
}

.navBtn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.navBtn.primary {
    background: linear-gradient(90deg, #2d6cdf, #ff2d7a);
    color: #fff;
    border: 0;
    box-shadow: 0 6px 18px rgba(45, 108, 223, 0.18);
}

.navBtn.primary:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 10px 28px rgba(45, 108, 223, 0.3);
    background: linear-gradient(90deg, #1e5dd1, #ff1a6d);
}

.dots {
    display: flex;
    gap: 6px;
    justify-content: center;
    flex: 1;
}

.dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #cbd5e1;
    cursor: pointer;
    transition: all 0.12s ease;
}

.dot.active {
    background: #0f172a;
    width: 24px;
    border-radius: 999px;
}

.quote {
    border-left: 3px solid #2d6cdf;
    padding-left: 12px;
    font-style: italic;
    color: #334155;
    line-height: 1.6;
}

.statusRow {
    display: flex;
    align-items: center;
    gap: 12px;
}

.statusPill {
    display: inline-block;
    padding: 8px 12px;
    border-radius: 999px;
    font-weight: 900;
    font-size: 12px;
}

.statusPill.done {
    background: rgba(34, 197, 94, 0.1);
    color: #166534;
    border: 1px solid rgba(34, 197, 94, 0.2);
}

.doneIcon {
    font-size: 64px;
    margin-bottom: 12px;
}

.footerHint {
    text-align: center;
    margin-top: 12px;
    font-size: 12px;
    color: #94a3b8;
    font-weight: 900;
}

@media (max-width: 640px) {
    .story {
        padding: 12px 10px 20px;
    }

    .slideInner {
        padding: 20px;
        min-height: 300px;
    }

    .h2 {
        font-size: 18px;
    }

    .nav {
        gap: 8px;
    }

    .navBtn {
        padding: 8px 10px;
        font-size: 12px;
    }
}
</style>
