<template>
    <div class="simPlay">
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
                <div class="kicker">{{ current.kicker }}</div>
                <h2 class="h2">{{ current.title }}</h2>
                <p class="p">{{ current.text }}</p>

                <div v-if="current.media === 'image'" class="media">
                    <div class="ph">🖼 Image placeholder</div>
                </div>

                <div v-if="current.media === 'video'" class="media">
                    <div class="ph">🎬 Video placeholder</div>
                </div>

                <div class="choices" v-if="current.choices && current.choices.length">
                    <button v-for="c in current.choices" :key="c.id" class="choice" :disabled="locked"
                        @click="choose(c)">
                        <div class="choiceTop">
                            <span class="dot"></span>
                            <span class="choiceText">{{ c.label }}</span>
                        </div>
                        <div class="choiceTags">
                            <span v-for="t in c.tags" :key="t" class="tag">{{ t }}</span>
                        </div>
                    </button>
                </div>

                <div class="reveal" v-if="feedback">
                    <div class="revealTitle">Instant feedback</div>
                    <p class="p">{{ feedback }}</p>

                    <button class="nextBtn" @click="next">
                        {{ stepIndex === steps.length - 1 ? 'See debrief →' : 'Continue →' }}
                    </button>
                </div>

                <details class="why">
                    <summary>Why it matters</summary>
                    <div class="whyBody">{{ current.why }}</div>
                </details>

                <details class="lens">
                    <summary>Power lens</summary>
                    <div class="whyBody">{{ current.lens }}</div>
                </details>
            </div>
        </section>

        <section class="debrief" v-if="done">
            <div class="card">
                <h2 class="h2">Debrief</h2>
                <p class="p">This summary is generated from your choices (mock logic).</p>

                <div class="panel">
                    <div class="row">
                        <span class="label">Your style today</span>
                        <span class="value">{{ styleLabel }}</span>
                    </div>
                    <div class="row">
                        <span class="label">Strength</span>
                        <span class="value">{{ strength }}</span>
                    </div>
                    <div class="row">
                        <span class="label">Risk</span>
                        <span class="value">{{ risk }}</span>
                    </div>
                </div>

                <div class="panel">
                    <div class="panelTitle">Suggested micro-practice</div>
                    <div class="quote">{{ microPractice }}</div>
                </div>

                <div class="actions">
                    <button class="ghost" @click="restart">Retry</button>
                    <button class="primary" @click="goToCourse">Recommended course →</button>
                </div>
            </div>
        </section>

        <div class="fixedNav">
            <button class="navBtn" :disabled="stepIndex === 0 || done" @click="prev">Prev</button>
            <button class="navBtn primary" :disabled="done || (current.choices && !feedback)" @click="next">
                {{ stepIndex === steps.length - 1 ? 'Finish' : 'Next' }}
            </button>
        </div>
    </div>
</template>

<script>
export default {
    name: 'SimulatorPlay',

    data() {
        return {
            mode: 'calm',
            stepIndex: 0,
            locked: false,
            feedback: '',
            done: false,

            meters: {
                Clarity: 50,
                Care: 50,
                Impact: 50,
                Boundaries: 50
            },

            scenariosById: {
                meeting_interrupt: {
                    id: 'meeting_interrupt',
                    title: 'The Meeting Interruption',
                    level: 'intro'
                },
                community_conflict: {
                    id: 'community_conflict',
                    title: 'Community Initiative Conflict',
                    level: 'core'
                },
                invisible_labor: {
                    id: 'invisible_labor',
                    title: 'Invisible Labor Negotiation',
                    level: 'intro'
                },
                ai_bias: {
                    id: 'ai_bias',
                    title: 'AI Tool Bias in Hiring',
                    level: 'advanced'
                }
            },

            steps: [
                {
                    id: 'a',
                    kicker: 'Context',
                    title: 'You are in a team meeting',
                    text: 'You propose an idea. A colleague interrupts and repeats your point as if it’s theirs.',
                    media: 'image',
                    why: 'Interruptions can erase contribution and reduce confidence over time.',
                    lens: 'Ethical power: reclaim space without humiliation. Visibility: claim credit without aggression.',
                    choices: [
                        {
                            id: 'a1',
                            label: 'Calmly reclaim: “I want to finish my point, then I’m happy to hear yours.”',
                            tags: ['Boundaries', 'Clarity'],
                            delta: { Boundaries: +12, Clarity: +10, Care: +2, Impact: +6 },
                            fb: 'Strong. Clear boundary + calm tone. You reclaim space without escalation.'
                        },
                        {
                            id: 'a2',
                            label: 'Stay quiet and let it go to keep the peace.',
                            tags: ['Care'],
                            delta: { Care: +6, Boundaries: -10, Impact: -6, Clarity: -4 },
                            fb: 'Peaceful short-term, costly long-term. Your contribution becomes invisible.'
                        },
                        {
                            id: 'a3',
                            label: 'Call them out sharply in front of everyone.',
                            tags: ['Impact'],
                            delta: { Impact: +10, Clarity: +6, Care: -12, Boundaries: +6 },
                            fb: 'You may stop the behavior, but the sharp tone can trigger defensiveness.'
                        }
                    ]
                },
                {
                    id: 'b',
                    kicker: 'Escalation',
                    title: 'The interruption continues',
                    text: 'They interrupt again. The room looks uncomfortable. You feel your pulse rise.',
                    media: 'none',
                    why: 'Repeated behavior tests your self-regulation and leadership presence.',
                    lens: 'Power + care: keep your nervous system steady while staying firm.',
                    choices: [
                        {
                            id: 'b1',
                            label: 'Name it neutrally: “I’ve been interrupted twice. I’m going to finish, then I’ll pass.”',
                            tags: ['Clarity', 'Boundaries'],
                            delta: { Boundaries: +10, Clarity: +10, Care: +4, Impact: +6 },
                            fb: 'Excellent. You name the pattern, set a limit, and keep dignity in the room.'
                        },
                        {
                            id: 'b2',
                            label: 'Ask the facilitator: “Can we have a speaking order?”',
                            tags: ['Care', 'Process'],
                            delta: { Care: +8, Boundaries: +4, Clarity: +6, Impact: +4 },
                            fb: 'Good move. You shift to process, which reduces personal conflict.'
                        }
                    ]
                },
                {
                    id: 'c',
                    kicker: 'Decision',
                    title: 'After the meeting',
                    text: 'They message you: “No hard feelings. You’re just too sensitive.”',
                    media: 'video',
                    why: 'This is a classic minimization move. How you respond shapes future dynamics.',
                    lens: 'Boundaries without drama. Accountability without revenge.',
                    choices: [
                        {
                            id: 'c1',
                            label: 'Short boundary: “I’m not okay with interruptions. In future, let me finish.”',
                            tags: ['Boundaries'],
                            delta: { Boundaries: +12, Clarity: +8, Care: +2, Impact: +6 },
                            fb: 'Clean and direct. You set expectations for the future.'
                        },
                        {
                            id: 'c2',
                            label: 'Explain everything in a long message so they “understand”.',
                            tags: ['Care'],
                            delta: { Care: +4, Boundaries: -8, Clarity: -6, Impact: -2 },
                            fb: 'Over-explaining often weakens the boundary and invites debate.'
                        }
                    ]
                }
            ]
        }
    },

    computed: {
        scenario() {
            const id = this.$route.query.id || 'meeting_interrupt'
            return this.scenariosById[id] || this.scenariosById.meeting_interrupt
        },

        current() {
            return this.steps[this.stepIndex] || {}
        },

        meterKeys() {
            return Object.keys(this.meters)
        },

        modeLabel() {
            return this.mode === 'timed' ? 'Challenge mode' : 'Calm mode'
        },

        styleLabel() {
            const b = this.meters.Boundaries
            const c = this.meters.Care
            const cl = this.meters.Clarity
            const i = this.meters.Impact

            if (b >= 60 && c >= 55) return 'Direct & Caring'
            if (i >= 60 && cl >= 55) return 'Bold & Clear'
            if (c >= 62 && b < 50) return 'Supportive (risk: self-silencing)'
            return 'Balanced'
        },

        strength() {
            const top = this.topMeter()
            if (top === 'Boundaries') return 'You set limits without losing respect.'
            if (top === 'Clarity') return 'You communicate in a way people can follow.'
            if (top === 'Care') return 'You protect relationships while navigating tension.'
            return 'You create momentum and move decisions forward.'
        },

        risk() {
            const low = this.lowMeter()
            if (low === 'Boundaries') return 'You may tolerate too much to keep harmony.'
            if (low === 'Clarity') return 'You may soften your message and lose impact.'
            if (low === 'Care') return 'You may sound harsh when you are under pressure.'
            return 'You may act fast without building enough buy-in.'
        },

        microPractice() {
            const low = this.lowMeter()
            if (low === 'Boundaries') return 'Practice one 2-sentence “No + alternative” this week.'
            if (low === 'Clarity') return 'Use a “headline first” sentence before details.'
            if (low === 'Care') return 'Add one empathy line before your limit: “I get it… and…”'
            return 'Before decisions, ask: “Who is impacted and who needs to be in the room?”'
        }
    },

    methods: {
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
        },

        choose(choice) {
            if (!choice || !choice.delta) return
            this.locked = true
            this.applyDelta(choice.delta)
            this.feedback = choice.fb || 'Noted.'
            setTimeout(() => { this.locked = false }, 250)
        },

        applyDelta(delta) {
            Object.keys(delta).forEach(k => {
                const next = (this.meters[k] || 0) + delta[k]
                this.meters[k] = Math.max(0, Math.min(100, next))
            })
        },

        next() {
            if (this.done) return
            if (this.current.choices && this.current.choices.length && !this.feedback) return

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

        topMeter() {
            let best = { k: '', v: -1 }
            Object.keys(this.meters).forEach(k => {
                if (this.meters[k] > best.v) best = { k, v: this.meters[k] }
            })
            return best.k
        },

        lowMeter() {
            let worst = { k: '', v: 999 }
            Object.keys(this.meters).forEach(k => {
                if (this.meters[k] < worst.v) worst = { k, v: this.meters[k] }
            })
            return worst.k
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
    text-align: center;
}

.title {
    font-weight: 900;
}

.meta {
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

.meters {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    padding: 12px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 10px;
    margin-bottom: 12px;
}

.meterTop {
    display: flex;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 6px;
}

.meterName {
    font-size: 12px;
    font-weight: 900;
    color: #334155;
}

.meterVal {
    font-size: 12px;
    font-weight: 900;
}

.bar {
    height: 10px;
    border-radius: 999px;
    background: #f1f5f9;
    border: 1px solid #e2e8f0;
    overflow: hidden;
}

.fill {
    height: 100%;
    width: 0%;
    background: #0f172a;
}

.mode {
    grid-column: 1 / -1;
    display: flex;
    gap: 8px;
    justify-content: flex-end;
}

.modeBtn {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 12px;
    padding: 8px 10px;
    font-weight: 900;
    cursor: pointer;
}

.modeBtn.on {
    border-color: #0f172a;
}

.stage {}

.card {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    padding: 14px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

.kicker {
    font-size: 12px;
    font-weight: 900;
    color: #64748b;
}

.h2 {
    margin: 8px 0;
    font-size: 20px;
    font-weight: 900;
}

.p {
    margin: 0;
    color: #475569;
    line-height: 1.45;
}

.media {
    margin-top: 12px;
    border: 1px dashed #cbd5e1;
    border-radius: 14px;
    background: #fbfdff;
    padding: 12px;
}

.ph {
    font-weight: 900;
    color: #475569;
    display: grid;
    place-items: center;
    height: 120px;
}

.choices {
    margin-top: 12px;
    display: grid;
    gap: 10px;
}

.choice {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 14px;
    padding: 12px;
    cursor: pointer;
    text-align: left;
}

.choice:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.choiceTop {
    display: flex;
    gap: 10px;
    align-items: center;
}

.dot {
    width: 10px;
    height: 10px;
    border-radius: 999px;
    background: #0f172a;
}

.choiceText {
    font-weight: 900;
}

.choiceTags {
    margin-top: 8px;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.tag {
    font-size: 12px;
    font-weight: 900;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
    padding: 6px 10px;
    border-radius: 999px;
}

.reveal {
    margin-top: 12px;
    border-top: 1px solid #e2e8f0;
    padding-top: 12px;
}

.revealTitle {
    font-weight: 900;
    margin-bottom: 6px;
}

.nextBtn {
    margin-top: 10px;
    border: 1px solid #0f172a;
    background: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
}

.why,
.lens {
    margin-top: 10px;
}

.why summary,
.lens summary {
    font-weight: 900;
    cursor: pointer;
}

.whyBody {
    margin-top: 8px;
    color: #475569;
    line-height: 1.45;
}

.debrief {
    margin-top: 12px;
}

.panel {
    margin-top: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #fbfdff;
    padding: 12px;
}

.row {
    display: flex;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.label {
    font-size: 12px;
    font-weight: 900;
    color: #64748b;
}

.value {
    font-weight: 900;
    color: #0f172a;
}

.panelTitle {
    font-weight: 900;
    margin-bottom: 8px;
}

.quote {
    border-left: 4px solid #e2e8f0;
    padding-left: 10px;
    font-weight: 900;
}

.actions {
    margin-top: 12px;
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    flex-wrap: wrap;
}

.primary {
    border: 1px solid #0f172a;
    background: #0f172a;
    color: #fff;
    border-radius: 12px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
}

/* fixed bottom nav */
.fixedNav {
    position: fixed;
    left: 50%;
    transform: translateX(-50%);
    bottom: 12px;
    width: min(980px, calc(100% - 28px));
    z-index: 9999;

    display: flex;
    justify-content: space-between;
    gap: 10px;

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
    min-width: 120px;
}

.navBtn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.navBtn.primary {
    border-color: #0f172a;
    background: #0f172a;
    color: #fff;
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