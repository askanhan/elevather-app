<!-- src/views/PowerCheck.vue -->
<template>
    <div class="pc">
        <!-- Header -->
        <header class="head">
            <div>
                <h1 class="h1">Power Check</h1>
                <p class="sub">A 30-second check-in. Know your state, then take one small leverage move.</p>
            </div>

            <button class="ghost" @click="resetToday">Reset</button>
        </header>

        <!-- Today status -->
        <section class="hero">
            <div class="heroCenter">
                <div class="badge" :class="stateClass">
                    <span class="emoji">{{ stateEmoji }}</span>
                    <span class="label">Today your power is</span>
                    <span class="value">{{ stateLabel }}</span>
                </div>

                <div class="miniNote">
                    Based on 3 quick taps. You can change it anytime.
                </div>
            </div>

            <div class="heroRight">
                <div class="scoreBox">
                    <div class="scoreTop">
                        <span class="scoreLabel">Power score</span>
                        <span class="scoreValue">{{ powerScore }}/100</span>
                    </div>
                    <div class="bar">
                        <div class="fill" :style="{ width: powerScore + '%' }"></div>
                    </div>
                    <div class="scoreHint">Goal: small consistent moves, not perfection.</div>
                </div>
            </div>
        </section>

        <!-- 3 quick taps -->
        <section class="checkin">
            <h2 class="h2">Quick check-in</h2>

            <div class="qgrid">
                <div class="qcard">
                    <div class="qtitle">I expressed myself</div>
                    <div class="qsub">Voice in meetings / conversations</div>
                    <div class="scale">
                        <button class="sbtn" :class="{ on: check.voice === 0 }"
                            @click="setCheck('voice', 0)">No</button>
                        <button class="sbtn" :class="{ on: check.voice === 50 }"
                            @click="setCheck('voice', 50)">Some</button>
                        <button class="sbtn" :class="{ on: check.voice === 100 }"
                            @click="setCheck('voice', 100)">Yes</button>
                    </div>
                </div>

                <div class="qcard">
                    <div class="qtitle">I set a boundary</div>
                    <div class="qsub">Said no / protected time</div>
                    <div class="scale">
                        <button class="sbtn" :class="{ on: check.boundary === 0 }"
                            @click="setCheck('boundary', 0)">No</button>
                        <button class="sbtn" :class="{ on: check.boundary === 50 }"
                            @click="setCheck('boundary', 50)">Some</button>
                        <button class="sbtn" :class="{ on: check.boundary === 100 }"
                            @click="setCheck('boundary', 100)">Yes</button>
                    </div>
                </div>

                <div class="qcard">
                    <div class="qtitle">My energy level</div>
                    <div class="qsub">Body & mind availability</div>
                    <div class="scale">
                        <button class="sbtn" :class="{ on: check.energy === 0 }"
                            @click="setCheck('energy', 0)">Low</button>
                        <button class="sbtn" :class="{ on: check.energy === 50 }"
                            @click="setCheck('energy', 50)">Mid</button>
                        <button class="sbtn" :class="{ on: check.energy === 100 }"
                            @click="setCheck('energy', 100)">High</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Track bars -->
        <section class="tracks">
            <div class="tracksHead">
                <h2 class="h2">Your tracks (snapshot)</h2>
                <button class="link" @click="goJourney">Open Tracks →</button>
            </div>

            <div class="tgrid">
                <div v-for="t in trackBars" :key="t.id" class="tcard">
                    <div class="ttop">
                        <span class="tname">{{ t.label }}</span>
                        <span class="tval">{{ t.value }}%</span>
                    </div>
                    <div class="tbar">
                        <div class="tfill" :style="{ width: t.value + '%', background: t.color }"></div>
                    </div>
                    <div class="thint">{{ t.hint }}</div>
                </div>
            </div>
        </section>

        <!-- Blockers -->
        <section class="blockers">
            <div class="blockHead">
                <h2 class="h2">What is blocking your power right now?</h2>
                <div class="hint">Pick one. We’ll recommend the fastest next step.</div>
            </div>

            <div class="bgrid">
                <button v-for="b in blockers" :key="b.id" class="bcard" :class="{ on: selectedBlocker === b.id }"
                    @click="selectBlocker(b.id)">
                    <div class="bicon">{{ b.icon }}</div>
                    <div class="btxt">
                        <div class="btitle">{{ b.title }}</div>
                        <div class="bsub">{{ b.sub }}</div>
                    </div>
                </button>
            </div>
        </section>

        <!-- One leverage move -->
        <section class="move">
            <h2 class="h2">Your next leverage move</h2>

            <div class="moveCard">
                <div class="moveTop">
                    <div class="moveTitle">{{ leverage.title }}</div>
                    <div class="moveMeta">
                        <span class="chip">{{ leverage.time }}</span>
                        <span class="chip">{{ leverage.track }}</span>
                    </div>
                </div>

                <p class="p">{{ leverage.desc }}</p>

                <div class="moveActions">
                    <button class="primary" @click="goSimulatorFast">Run 3-min simulator →</button>
                    <button class="ghost" @click="openModel">Open model</button>
                    <button class="ghost" @click="openCourse">Open course</button>
                </div>
            </div>
        </section>

        <!-- Recommendations -->
        <section class="reco">
            <h2 class="h2">Because you are here</h2>

            <div class="rgrid">
                <article class="rcard" @click="goStories">
                    <div class="rTop">
                        <div class="ricon">📖</div>
                        <div class="rtext">
                            <div class="rtitle">Story</div>
                            <div class="rname">{{ rec.story.title }}</div>
                            <div class="rsub">{{ rec.story.sub }}</div>
                        </div>
                    </div>
                    <div class="rcta">Open story →</div>
                </article>

                <article class="rcard" @click="openModel">
                    <div class="rTop">
                        <div class="ricon">🧩</div>
                        <div class="rtext">
                            <div class="rtitle">Model</div>
                            <div class="rname">{{ rec.model.title }}</div>
                            <div class="rsub">{{ rec.model.sub }}</div>
                        </div>
                    </div>
                    <div class="rcta">Open model →</div>
                </article>

                <article class="rcard" @click="openCourse">
                    <div class="rTop">
                        <div class="ricon">🎓</div>
                        <div class="rtext">
                            <div class="rtitle">Course</div>
                            <div class="rname">{{ rec.course.title }}</div>
                            <div class="rsub">{{ rec.course.sub }}</div>
                        </div>
                    </div>
                    <div class="rcta">Open course →</div>
                </article>
            </div>
        </section>

        <!-- 7-day timeline -->
        <section class="timeline">
            <div class="timeHead">
                <h2 class="h2">Last 7 days</h2>
                <div class="hint">Tap a day to see a short note (mock).</div>
            </div>

            <div class="dotsRow">
                <button v-for="d in last7" :key="d.date" class="dayDot" :class="d.state" @click="selectedDay = d">
                    <span class="dayLbl">{{ d.short }}</span>
                </button>
            </div>

            <div v-if="selectedDay" class="dayCard">
                <div class="dayTop">
                    <span class="chip">{{ selectedDay.date }}</span>
                    <span class="chip">{{ dayStateLabel(selectedDay.state) }}</span>
                    <span class="chip">{{ selectedDay.score }}/100</span>
                </div>
                <div class="p">{{ selectedDay.note }}</div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    name: 'PowerCheck',

    data() {
        return {
            check: {
                voice: 50,
                boundary: 50,
                energy: 50
            },

            selectedBlocker: 'fear',

            selectedDay: null,

            blockers: [
                { id: 'fear', icon: '😬', title: 'Fear', sub: 'Hesitation, self-doubt, overthinking' },
                { id: 'overload', icon: '🧠', title: 'Overload', sub: 'Too much, too fast, no space' },
                { id: 'conflict', icon: '⚡', title: 'Conflict', sub: 'Tension, pushback, hard conversations' },
                { id: 'unclear', icon: '🌫️', title: 'Unclear goals', sub: 'No direction, no next step' }
            ],

            rec: {
                story: { title: 'The 3-sentence boundary moment', sub: 'A quick story about reclaiming space calmly.' },
                model: { title: 'Boundary Script Builder', sub: 'Situation → Limit → Alternative → Pushback responses.' },
                course: { title: 'Boundaries & Saying No', sub: 'Short, calm, repeatable boundaries without guilt.' }
            },

            last7: [
                { date: 'Mon', short: 'M', state: 'stable', score: 62, note: 'Used one clear ask. Energy okay.' },
                { date: 'Tue', short: 'T', state: 'rising', score: 74, note: 'Spoke up in a meeting. Felt strong after.' },
                { date: 'Wed', short: 'W', state: 'drained', score: 41, note: 'Overcommitted. Needed rest.' },
                { date: 'Thu', short: 'T', state: 'stable', score: 58, note: 'Kept boundaries in small ways.' },
                { date: 'Fri', short: 'F', state: 'rising', score: 70, note: 'Negotiated a timeline. Felt respected.' },
                { date: 'Sat', short: 'S', state: 'drained', score: 45, note: 'Heavy week. Recovery day.' },
                { date: 'Sun', short: 'S', state: 'stable', score: 60, note: 'Reset and planned one priority.' }
            ]
        }
    },

    computed: {
        powerScore() {
            // simple mock: average of 3 taps
            const v = this.check.voice || 0
            const b = this.check.boundary || 0
            const e = this.check.energy || 0
            return Math.round((v + b + e) / 3)
        },

        stateLabel() {
            const s = this.powerScore
            if (s >= 70) return 'Rising'
            if (s <= 45) return 'Drained'
            return 'Stable'
        },

        stateEmoji() {
            const s = this.powerScore
            if (s >= 70) return '🔥'
            if (s <= 45) return '🫧'
            return '⚡'
        },

        stateClass() {
            const s = this.powerScore
            if (s >= 70) return 'rising'
            if (s <= 45) return 'drained'
            return 'stable'
        },

        trackBars() {
            // mock: mix today score + a little personality so it looks real
            const base = this.powerScore
            return [
                { id: 'dare', label: 'I Dare', value: this.clamp(base + (this.check.boundary - 50) / 4), color: '#2D6CDF', hint: 'Courage, boundaries, visibility.' },
                { id: 'speak', label: 'I Speak', value: this.clamp(base + (this.check.voice - 50) / 3), color: '#F59E0B', hint: 'Communication and influence.' },
                { id: 'earn', label: 'I Earn', value: this.clamp(base - 6), color: '#1F9D63', hint: 'Money clarity & leverage.' },
                { id: 'lead', label: 'I Lead', value: this.clamp(base - 3), color: '#8B5CF6', hint: 'Ethical power & decisions.' },
                { id: 'impact', label: 'I Impact', value: this.clamp(base - 8), color: '#06B6D4', hint: 'Society, systems, civic action.' }
            ]
        },

        leverage() {
            // mock rules: blocker + score -> one best move
            const b = this.selectedBlocker
            const s = this.powerScore

            if (b === 'fear') {
                return {
                    title: 'Do one micro-courage ask today',
                    time: '2–4 min',
                    track: 'I Dare',
                    desc: 'Pick one small moment: ask a question, state a preference, or request clarity. Short sentence. No explaining.'
                }
            }

            if (b === 'overload') {
                return {
                    title: 'Cancel or renegotiate one commitment',
                    time: '3–5 min',
                    track: 'I Lead',
                    desc: 'Choose one thing to delay or delegate. Use one calm line. Protect tomorrow’s energy.'
                }
            }

            if (b === 'conflict') {
                return {
                    title: 'Use a boundary + care sentence',
                    time: '3–5 min',
                    track: 'I Speak',
                    desc: 'Say: “I get it. And I’m not available for X. I can do Y.” Then stop. Let silence work for you.'
                }
            }

            // unclear goals
            if (s < 55) {
                return {
                    title: 'Write your one priority (and one “not now”)',
                    time: '2–3 min',
                    track: 'I Impact',
                    desc: 'Name the single outcome you want this week. Then pick one thing you are not doing.'
                }
            }

            return {
                title: 'Turn one idea into a tiny pilot',
                time: '5–8 min',
                track: 'I Build',
                desc: 'Define a mini experiment: what, who, when, success signal. Small is smarter.'
            }
        }
    },

    methods: {
        clamp(v) {
            const n = Math.round(v)
            return Math.max(0, Math.min(100, n))
        },

        setCheck(key, val) {
            this.check[key] = val
        },

        selectBlocker(id) {
            this.selectedBlocker = id
        },

        resetToday() {
            this.check.voice = 50
            this.check.boundary = 50
            this.check.energy = 50
            this.selectedBlocker = 'fear'
            this.selectedDay = null
        },

        dayStateLabel(s) {
            if (s === 'rising') return 'Rising'
            if (s === 'drained') return 'Drained'
            return 'Stable'
        },

        goJourney() {
            this.$router.push({ name: 'journey' })
        },

        goSimulatorFast() {
            // fast path: open simulator list or directly a scenario
            this.$router.push({ path: '/simulator' })
        },

        goStories() {
            this.$router.push({ name: 'stories' })
        },

        openModel() {
            this.$router.push('/model')
        },

        openCourse() {
            this.$router.push('/course')
        }
    }
}
</script>

<style scoped>
/* ===== Brand tokens (adjust if your logo hex differs) ===== */
.pc {
  --brand-pink: #ff2d7a;
  --brand-blue: #2d6cdf;
  --ink: #0f172a;
  --muted: #64748b;

  --bg: #f7fbff;            /* light background (no gray) */
  --card: #ffffff;
  --line: #e6eef7;

  --shadow: 0 10px 28px rgba(15, 23, 42, 0.08);

  max-width: 1100px;
  margin: 0 auto;
  padding: 16px 14px 16em;
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
  color: var(--ink);

  background: var(--bg);
  min-height: 100vh;
}

/* If your app wrapper is gray, this forces a clean light background */
.pc :deep(body),
.pc :deep(#app),
.pc :deep(.page-content),
.pc :deep(.content) {
  background: var(--bg) !important;
}

/* ===== Header ===== */
.head {
  position: sticky;
  top: 0;
  z-index: 30;
  background: rgba(247, 251, 255, 0.92);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);

  padding: 10px 2px 10px;
  margin: 0 0 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  border-bottom: 1px solid rgba(230, 238, 247, 0.7);
}

.h1 {
  margin: 0;
  font-size: 20px;
  font-weight: 900;
  letter-spacing: -0.02em;
}

.sub {
  margin: 2px 0 0;
  color: var(--muted);
  font-size: 12px;
  line-height: 1.25;
  max-width: 520px;
}

.ghost {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 14px;
  padding: 10px 12px;
  font-weight: 900;
  cursor: pointer;
  box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
}

/* ===== Hero ===== */
.hero {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
  margin-bottom: 10px;
}

.heroCenter {
  text-align: center;
}

/* Badge looks like logo palette */
.badge {
  border: 1px solid var(--line);
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.08), rgba(255, 45, 122, 0.08));
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.badge .emoji {
  font-size: 26px;
  line-height: 1;
  display: inline-block;
  margin-bottom: 6px;
}

.badge .label {
  color: var(--muted);
  font-weight: 900;
  font-size: 12px;
  display: block;
}

.badge .value {
  font-weight: 900;
  font-size: 18px;
  margin-top: 4px;
  display: block;
}

/* State accents using brand colors */
.badge.rising {
  border-color: rgba(255, 45, 122, 0.22);
}
.badge.stable {
  border-color: rgba(45, 108, 223, 0.22);
}
.badge.drained {
  border-color: rgba(230, 238, 247, 1);
  background: #ffffff;
}

.miniNote {
  margin-top: 8px;
  color: var(--muted);
  font-size: 12px;
}

/* Power score card */
.scoreBox {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.scoreTop {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 10px;
  margin-bottom: 8px;
}

.scoreLabel {
  font-size: 12px;
  font-weight: 900;
  color: var(--muted);
}

.scoreValue {
  font-size: 12px;
  font-weight: 900;
}

.bar {
  height: 10px;
  border-radius: 999px;
  background: rgba(230, 238, 247, 0.9);
  border: 1px solid rgba(230, 238, 247, 1);
  overflow: hidden;
}

.fill {
  height: 100%;
  width: 0%;
  background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
}

.scoreHint {
  margin-top: 8px;
  color: var(--muted);
  font-size: 12px;
}

/* ===== Section spacing / titles ===== */
.checkin,
.tracks,
.blockers,
.move,
.reco,
.timeline {
  margin-top: 12px;
}

.h2 {
  margin: 0 0 8px;
  font-size: 16px;
  font-weight: 900;
  letter-spacing: -0.01em;
}

/* ===== Check-in cards ===== */
.qgrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
}

.qcard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.qtitle {
  font-weight: 900;
  margin-bottom: 4px;
}

.qsub {
  color: var(--muted);
  font-size: 12px;
  font-weight: 900;
  margin-bottom: 10px;
}

.scale {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

.sbtn {
  border: 1px solid var(--line);
  background: #ffffff;
  border-radius: 14px;
  padding: 12px 10px;
  font-weight: 900;
  cursor: pointer;
  min-height: 44px;
}

.sbtn.on {
  border-color: rgba(45, 108if, 223, 0.32); /* fallback removed below */
  border-color: rgba(45, 108, 223, 0.32);
  box-shadow: 0 10px 20px rgba(45, 108, 223, 0.10);
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.06));
}

/* ===== Tracks ===== */
.tracksHead {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

.link {
  border: 0;
  background: transparent;
  font-weight: 900;
  cursor: pointer;
  color: var(--brand-blue);
  text-decoration: underline;
}

.tgrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
}

.tcard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.ttop {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  margin-bottom: 8px;
}

.tname {
  font-weight: 900;
}

.tval {
  font-weight: 900;
  color: var(--muted);
}

.tbar {
  height: 10px;
  border-radius: 999px;
  background: rgba(230, 238, 247, 0.9);
  border: 1px solid rgba(230, 238, 247, 1);
  overflow: hidden;
}

.tfill {
  height: 100%;
  width: 0%;
}

.thint {
  margin-top: 8px;
  color: var(--muted);
  font-size: 12px;
}

/* ===== Blockers ===== */
.blockHead .hint {
  color: var(--muted);
  font-size: 12px;
  font-weight: 900;
  margin-top: -2px;
}

.bgrid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.bcard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 12px;
  cursor: pointer;
  text-align: left;
  display: flex;
  gap: 10px;
  align-items: center;
  box-shadow: var(--shadow);
  min-height: 64px;
}

.bcard.on {
  border-color: rgba(255, 45, 122, 0.35);
  box-shadow: 0 14px 28px rgba(255, 45, 122, 0.10);
}

.bicon {
  width: 44px;
  height: 44px;
  border-radius: 16px;
  border: 1px solid var(--line);
  background: linear-gradient(135deg, rgba(255, 45, 122, 0.10), rgba(45, 108, 223, 0.08));
  display: grid;
  place-items: center;
  font-size: 18px;
}

.btitle {
  font-weight: 900;
}

.bsub {
  color: var(--muted);
  font-size: 12px;
  font-weight: 900;
  margin-top: 2px;
}

/* ===== Leverage move ===== */
.moveCard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.moveTop {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

.moveTitle {
  font-weight: 900;
  font-size: 15px;
}

.moveMeta {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.chip {
  font-size: 12px;
  font-weight: 900;
  padding: 6px 10px;
  border-radius: 999px;
  border: 1px solid var(--line);
  background: rgba(230, 238, 247, 0.55);
}

.p {
  margin: 0;
  color: #475569;
  line-height: 1.45;
}

.moveActions {
  margin-top: 12px;
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

.primary {
  border: 0;
  background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
  color: #fff;
  border-radius: 14px;
  padding: 12px 12px;
  font-weight: 900;
  cursor: pointer;
  box-shadow: 0 14px 28px rgba(45, 108, 223, 0.18);
}

.moveActions .ghost {
  width: 100%;
}

/* ===== Recommendations ===== */
.rgrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
}

.rcard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  cursor: pointer;
  box-shadow: var(--shadow);
  transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.rcard:hover {
  transform: translateY(-1px);
  box-shadow: 0 16px 32px rgba(15, 23, 42, 0.10);
  border-color: rgba(45, 108, 223, 0.22);
}

.rTop {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.ricon {
  width: 48px;
  height: 48px;
  border: 1px solid var(--line);
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.08));
  display: grid;
  place-items: center;
  font-size: 22px;
}

.rtitle {
  font-size: 12px;
  font-weight: 900;
  color: var(--muted);
  margin-bottom: 6px;
}

.rname {
  font-weight: 900;
  margin-bottom: 6px;
}

.rsub {
  color: #475569;
  line-height: 1.35;
}

.rcta {
  margin-top: 12px;
  font-weight: 900;
  color: var(--brand-blue);
}

/* ===== 7-day ===== */
.timeHead .hint {
  color: var(--muted);
  font-size: 12px;
  font-weight: 900;
  margin-top: -2px;
}

.dotsRow {
  margin-top: 8px;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.dayDot {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 16px;
  width: 12%;
  height: 54px;
  cursor: pointer;
  display: grid;
  place-items: center;
  box-shadow: 0 10px 22px rgba(15, 23, 42, 0.08);
}

.dayLbl {
  font-weight: 900;
  color: var(--ink);
}

.dayDot.rising {
  background: rgba(255, 45, 122, 0.08);
  border-color: rgba(255, 45, 122, 0.25);
}

.dayDot.stable {
  background: rgba(45, 108, 223, 0.08);
  border-color: rgba(45, 108, 223, 0.25);
}

.dayDot.drained {
  background: rgba(230, 238, 247, 0.65);
  border-color: rgba(230, 238, 247, 1);
}

.dayCard {
  margin-top: 10px;
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.dayTop {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

/* ===== Responsive upgrades (tablet/desktop) ===== */
@media (min-width: 860px) {
  .hero {
    grid-template-columns: 1.2fr 0.8fr;
    align-items: stretch;
  }

  .qgrid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .tgrid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .bgrid {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }

  .rgrid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .moveActions {
    grid-template-columns: 1.2fr 1fr 1fr;
    justify-items: stretch;
  }
}

/* Small screens: keep everything airy */
@media (max-width: 420px) {
  .pc { padding: 14px 12px 40px; }
  .sub { display: none; } /* optional: cleaner mobile */
}
</style>