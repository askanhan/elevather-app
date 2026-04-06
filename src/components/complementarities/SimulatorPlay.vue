<!-- src/components/complementarities/SimulatorPlay.vue -->
<template>
    <div class="simPlay">
        <!-- Error message -->
        <div v-if="error" class="error-message">
            ⚠️ {{ error }}
        </div>

        <!-- Loading message -->
        <div v-if="loading" class="loading-message">
            Loading simulator...
        </div>

        <!-- Content -->
        <template v-if="!loading && !error">
        <header class="topbar">
            <button class="back" @click="goBack">←</button>

            <div class="titleWrap">
                <div class="title">{{ scenario.title }}</div>
                <div class="meta">
                    <span class="chip">{{ labelLevel(scenario.level) }}</span>
                    <span class="chip">{{ stepIndex + 1 }}/{{ steps.length }}</span>
                    <span class="chip">{{ modeLabel }}</span>
                </div>
            </div>

            <button class="ghost" @click="restart">Restart</button>
        </header>

        <section class="meters">
            <div class="meter" v-for="m in meterKeys" :key="m">
                <div class="meterTop">
                    <span class="meterName">{{ m }}</span>
                    <span class="meterVal">{{ meters[m] }}/100</span>
                </div>
                <div class="bar">
                    <div class="fill" :style="{ width: meters[m] + '%' }"></div>
                </div>
            </div>

            <div class="mode">
                <button class="modeBtn" :class="{ on: mode === 'calm' }" @click="mode = 'calm'">Calm</button>
                <button class="modeBtn" :class="{ on: mode === 'timed' }" @click="mode = 'timed'">Challenge</button>
            </div>
        </section>

        <section class="stage">
            <div class="card">
                <div v-if="current.kicker" class="kicker">{{ current.kicker }}</div>
                <h2 class="h2">{{ current.title }}</h2>
                <p class="p">{{ current.text }}</p>

                <!-- Render card components -->
                <div v-for="comp in current.components" :key="comp.order" class="component">
                    <!-- Text -->
                    <div v-if="comp.type === 'text'" class="comp-text">{{ comp.content }}</div>

                    <!-- Image -->
                    <div v-if="comp.type === 'image'" class="media">
                        <img :src="comp.url" :alt="comp.alt || 'Image'" />
                    </div>

                    <!-- Video -->
                    <div v-if="comp.type === 'video'" class="media">
                        <div class="ph">🎬 {{ comp.url }}</div>
                    </div>

                    <!-- MCQ as choices -->
                    <div v-if="comp.type === 'mcq'" class="choices">
                        <button v-for="opt in comp.options" :key="opt.id" class="choice" :disabled="locked"
                            @click="choose(opt, comp)">
                            <div class="choiceTop">
                                <span class="dot"></span>
                                <span class="choiceText">{{ opt.text }}</span>
                            </div>
                        </button>
                    </div>

                    <!-- Quote -->
                    <div v-if="comp.type === 'quote'" class="comp-quote">
                        <div class="quote-text">"{{ comp.content }}"</div>
                        <div class="quote-author">— {{ comp.author }}</div>
                    </div>
                </div>

                <div v-if="current.why" class="reveal">
                    <div class="revealTitle">Why it matters</div>
                    <p class="p">{{ current.why }}</p>
                </div>

                <div v-if="feedback" class="reveal">
                    <div class="revealTitle">Feedback</div>
                    <p class="p">{{ feedback }}</p>

                    <button class="nextBtn" @click="next">
                        {{ stepIndex === steps.length - 1 ? 'See debrief →' : 'Continue →' }}
                    </button>
                </div>

                <details v-if="current.lens" class="lens">
                    <summary>Power lens</summary>
                    <div class="whyBody">{{ current.lens }}</div>
                </details>
            </div>
        </section>

        <section class="debrief" v-if="done">
            <div class="card">
                <h2 class="h2">Debrief</h2>
                <p class="p">You completed the simulator!</p>

                <div class="panel">
                    <div class="row">
                        <span class="label">Your score</span>
                        <span class="value">{{ totalScore }}/{{ steps.length * 10 }}</span>
                    </div>
                </div>

                <div class="actions">
                    <button class="ghost" @click="restart">Retry</button>
                    <button class="primary" @click="goToCourse">Back to course →</button>
                </div>
            </div>
        </section>

        <div class="fixedNav">
            <button class="navBtn" :disabled="stepIndex === 0 || done" @click="prev">Prev</button>
            <button class="navBtn primary" :disabled="done || (needsChoice && !feedback)" @click="next">
                {{ stepIndex === steps.length - 1 ? 'Finish' : 'Next' }}
            </button>
        </div>
        </template>
    </div>
</template>

<script>
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
</script>

<style scoped>
.simPlay {
    max-width: 980px;
    margin: 0 auto;
    padding: 16px 14px 120px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
    color: #0f172a;
    position: relative;
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
    margin-bottom: 14px;
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

.title {
    font-weight: 900;
    font-size: 16px;
    margin-bottom: 6px;
}

.meta {
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
}

.meters {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    padding: 12px;
    margin-bottom: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.meter {
    margin-bottom: 12px;
}

.meter:last-child {
    margin-bottom: 0;
}

.meterTop {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 6px;
}

.meterName {
    font-size: 12px;
    font-weight: 900;
    color: #0f172a;
}

.meterVal {
    font-size: 12px;
    font-weight: 900;
    color: #64748b;
}

.bar {
    height: 10px;
    border-radius: 999px;
    background: #f1f5f9;
    overflow: hidden;
    border: 1px solid #e2e8f0;
}

.fill {
    height: 100%;
    background: #0f172a;
}

.mode {
    display: flex;
    gap: 10px;
    margin-top: 12px;
}

.modeBtn {
    flex: 1;
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 8px;
    font-weight: 900;
    cursor: pointer;
}

.modeBtn.on {
    background: #0f172a;
    color: #fff;
    border-color: #0f172a;
}

.stage {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    padding: 16px;
    margin-bottom: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.card {
    max-width: 100%;
}

.kicker {
    font-size: 12px;
    font-weight: 900;
    color: #64748b;
    text-transform: uppercase;
    margin-bottom: 8px;
}

.h2 {
    margin: 0 0 8px;
    font-size: 20px;
    font-weight: 900;
    color: #0f172a;
}

.p {
    margin: 0 0 12px;
    color: #475569;
    line-height: 1.45;
}

.component {
    margin-bottom: 16px;
}

.comp-text {
    color: #475569;
    line-height: 1.45;
    margin: 12px 0;
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

.media {
    border: 1px dashed #cbd5e1;
    border-radius: 14px;
    background: #fbfdff;
    padding: 18px;
    text-align: center;
    margin: 12px 0;
}

.media img {
    max-width: 100%;
    border-radius: 12px;
}

.ph {
    color: #64748b;
    font-weight: 900;
}

.choices {
    margin: 12px 0;
}

.choice {
    width: 100%;
    text-align: left;
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 14px;
    padding: 12px;
    cursor: pointer;
    margin-bottom: 10px;
    transition: transform 0.06s ease, box-shadow 0.06s ease;
    display: flex;
    gap: 10px;
    align-items: center;
}

.choice:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 8px 18px rgba(15, 23, 42, 0.06);
}

.choice:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}

.choiceTop {
    display: flex;
    gap: 10px;
    align-items: center;
    flex: 1;
}

.dot {
    width: 8px;
    height: 8px;
    border-radius: 999px;
    background: #cbd5e1;
    flex: 0 0 auto;
}

.choiceText {
    font-weight: 900;
    color: #0f172a;
}

.choiceTags {
    display: flex;
    gap: 6px;
    flex-wrap: wrap;
}

.tag {
    font-size: 11px;
    font-weight: 900;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 4px 8px;
    border-radius: 999px;
    color: #0f172a;
}

.reveal {
    border-top: 1px solid #e2e8f0;
    padding-top: 12px;
    margin-top: 12px;
}

.revealTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 8px;
}

.nextBtn {
    border: 1px solid #0f172a;
    background: #fff;
    color: #0f172a;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
    margin-top: 12px;
}

.lens,
.why {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 12px;
    margin-top: 12px;
    background: #fbfdff;
}

.lens summary,
.why summary {
    font-weight: 900;
    cursor: pointer;
}

.whyBody {
    margin-top: 8px;
    color: #475569;
    line-height: 1.45;
}

.debrief {
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    background: #fff;
    padding: 24px;
    margin-bottom: 12px;
}

.panel {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 12px;
    margin: 12px 0;
    background: #fbfdff;
}

.row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 8px 0;
}

.label {
    font-weight: 900;
    color: #0f172a;
}

.value {
    color: #475569;
}

.panelTitle {
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 8px;
}

.actions {
    display: flex;
    gap: 10px;
    margin-top: 16px;
}

.primary {
    flex: 1;
    border: 1px solid #0f172a;
    background: #0f172a;
    color: #fff;
    border-radius: 12px;
    padding: 10px;
    font-weight: 900;
    cursor: pointer;
}

.fixedNav {
    position: fixed;
    left: 50%;
    bottom: 12px;
    transform: translateX(-50%);
    width: min(980px, calc(100% - 28px));
    z-index: 100;
    display: flex;
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
    flex: 1;
    border: 1px solid #e2e8f0;
    background: #fff;
    color: #0f172a;
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

@supports (padding: max(0px)) {
    .fixedNav {
        bottom: max(12px, env(safe-area-inset-bottom));
    }

    .simPlay {
        padding-bottom: calc(120px + env(safe-area-inset-bottom));
    }
}
</style>
