<!-- src/views/PowerCheck.vue -->
<template>
  <!-- 7-day timeline (TOP) -->
  <section class="card compact">
    <div class="cardHead">
      <h2 class="h2">Last 7 days</h2>
      <div class="hint">Tap a day.</div>
    </div>

    <div class="dotsRow">
      <button v-for="d in last7" :key="d.date" class="dayDot" :class="d.state" @click="selectedDay = d">
        <span class="dayLbl">{{ d.short }}</span>
      </button>
    </div>

    <div v-if="selectedDay" class="noteCard">
      <div class="noteTop">
        <span class="chip">{{ selectedDay.date }}</span>
        <span class="chip">{{ dayStateLabel(selectedDay.state) }}</span>
        <span class="chip">{{ selectedDay.score }}/100</span>
      </div>
      <div class="p">{{ selectedDay.note }}</div>
    </div>
  </section>

  <div class="pc">
    <!-- Header -->
    <header class="head">
      <div class="headLeft">
        <h1 class="h1">Power Check</h1>
        <p class="sub">30 seconds. Name your state → take one leverage move.</p>
      </div>

      <button class="ghost" @click="resetToday">Reset</button>
    </header>

    <!-- SUMMARY (single clean card) -->
    <section class="summaryCard">
      <div class="summaryTop">
        <div class="statePill" :class="stateClass">
          <span class="emoji">{{ stateEmoji }}</span>
          <span class="stateText">
            <span class="stateLabel">Today:</span>
            <span class="stateValue">{{ stateLabel }}</span>
          </span>
        </div>

        <div class="scoreWrap">
          <div class="scoreNum">{{ powerScore }}<span class="scoreDen">/100</span></div>
          <div class="scoreHint">Small consistent moves, not perfection.</div>
        </div>
      </div>

      <div class="scoreBar">
        <div class="scoreFill" :style="{ width: powerScore + '%' }"></div>
      </div>

      <div class="microNote">Based on 3 quick taps. You can change it anytime.</div>
    </section>

    <!-- QUICK CHECK-IN (single card, 3 rows) -->
    <section class="card">
      <div class="cardHead">
        <h2 class="h2">Quick check-in</h2>
        <div class="hint">Tap once per row.</div>
      </div>

      <div class="rows">
        <div class="row">
          <div class="rowText">
            <div class="rowTitle">I expressed myself</div>
            <div class="rowSub">Voice in meetings / conversations</div>
          </div>
          <div class="seg">
            <button class="segBtn" :class="{ on: check.voice === 0 }" @click="setCheck('voice', 0)">No</button>
            <button class="segBtn" :class="{ on: check.voice === 50 }" @click="setCheck('voice', 50)">Some</button>
            <button class="segBtn" :class="{ on: check.voice === 100 }" @click="setCheck('voice', 100)">Yes</button>
          </div>
        </div>

        <div class="row">
          <div class="rowText">
            <div class="rowTitle">I set a boundary</div>
            <div class="rowSub">Said no / protected time</div>
          </div>
          <div class="seg">
            <button class="segBtn" :class="{ on: check.boundary === 0 }" @click="setCheck('boundary', 0)">No</button>
            <button class="segBtn" :class="{ on: check.boundary === 50 }"
              @click="setCheck('boundary', 50)">Some</button>
            <button class="segBtn" :class="{ on: check.boundary === 100 }"
              @click="setCheck('boundary', 100)">Yes</button>
          </div>
        </div>

        <div class="row">
          <div class="rowText">
            <div class="rowTitle">My energy level</div>
            <div class="rowSub">Body & mind availability</div>
          </div>
          <div class="seg">
            <button class="segBtn" :class="{ on: check.energy === 0 }" @click="setCheck('energy', 0)">Low</button>
            <button class="segBtn" :class="{ on: check.energy === 50 }" @click="setCheck('energy', 50)">Mid</button>
            <button class="segBtn" :class="{ on: check.energy === 100 }" @click="setCheck('energy', 100)">High</button>
          </div>
        </div>
      </div>
    </section>

    <!-- BLOCKER + NEXT MOVE (one decision, one action) -->
    <section class="card">
      <div class="cardHead">
        <h2 class="h2">Your next move</h2>
        <div class="hint">Pick what’s blocking you, we’ll keep it simple.</div>
      </div>

      <div class="blockerGrid">
        <button v-for="b in blockers" :key="b.id" class="blocker" :class="{ on: selectedBlocker === b.id }"
          @click="selectBlocker(b.id)">
          <span class="bIcon">{{ b.icon }}</span>
          <span class="bInfo">
            <span class="bTitle">{{ b.title }}</span>
            <span class="bSub">{{ b.sub }}</span>
          </span>
        </button>
      </div>

      <div class="moveBox">
        <div class="moveTop">
          <div class="moveTitle">{{ leverage.title }}</div>
          <div class="chips">
            <span class="chip">{{ leverage.time }}</span>
            <span class="chip">{{ leverage.track }}</span>
          </div>
        </div>

        <p class="p">{{ leverage.desc }}</p>

        <div class="actions">
          <button class="primary" @click="goSimulatorFast">Run 3-min simulator</button>
          <button class="ghost2" @click="openCourse">Open course</button>
          <button class="ghost2" @click="openModel">Open model</button>
        </div>
      </div>
    </section>

    <section class="card">

      <!-- INSIGHTS (collapsed by default) -->
      <details class="details">
        <summary class="detailsSummary">
          <span>Insights</span>
          <span class="detailsHint">Tracks, recommendations, last 7 days</span>
        </summary>

        <!-- Track bars -->
        <section class="card compact">
          <div class="cardHead">
            <h2 class="h2">Tracks snapshot</h2>
            <button class="link" @click="goJourney">Open Tracks →</button>
          </div>

          <div class="tgrid">
            <div v-for="t in trackBars" :key="t.id" class="trow">
              <div class="tTop">
                <span class="tName">{{ t.label }}</span>
                <span class="tVal">{{ t.value }}%</span>
              </div>
              <div class="tBar">
                <div class="tFill" :style="{ width: t.value + '%', background: t.color }"></div>
              </div>
              <div class="tHint">{{ t.hint }}</div>
            </div>
          </div>
        </section>

        <!-- Recommendations -->
        <section class="card compact">
          <div class="cardHead">
            <h2 class="h2">Because you are here</h2>
            <div class="hint">One tap, one resource.</div>
          </div>

          <div class="recoGrid">
            <button class="reco" @click="goStories">
              <span class="rIcon">📖</span>
              <span class="rText">
                <span class="rTop">Story</span>
                <span class="rName">{{ rec.story.title }}</span>
                <span class="rSub">{{ rec.story.sub }}</span>
              </span>
            </button>

            <button class="reco" @click="openModel">
              <span class="rIcon">🧩</span>
              <span class="rText">
                <span class="rTop">Model</span>
                <span class="rName">{{ rec.model.title }}</span>
                <span class="rSub">{{ rec.model.sub }}</span>
              </span>
            </button>

            <button class="reco" @click="openCourse">
              <span class="rIcon">🎓</span>
              <span class="rText">
                <span class="rTop">Course</span>
                <span class="rName">{{ rec.course.title }}</span>
                <span class="rSub">{{ rec.course.sub }}</span>
              </span>
            </button>
          </div>
        </section>

        <!-- 7-day timeline -->
        <section class="card compact">
          <div class="cardHead">
            <h2 class="h2">Last 7 days</h2>
            <div class="hint">Tap a day.</div>
          </div>

          <div class="dotsRow">
            <button v-for="d in last7" :key="d.date" class="dayDot" :class="d.state" @click="selectedDay = d">
              <span class="dayLbl">{{ d.short }}</span>
            </button>
          </div>

          <div v-if="selectedDay" class="noteCard">
            <div class="noteTop">
              <span class="chip">{{ selectedDay.date }}</span>
              <span class="chip">{{ dayStateLabel(selectedDay.state) }}</span>
              <span class="chip">{{ selectedDay.score }}/100</span>
            </div>
            <div class="p">{{ selectedDay.note }}</div>
          </div>
        </section>
      </details>
    </section>

  <!-- Track suggestion (where you left off) -->
  <section class="card compact">
    <div class="cardHead">
      <h2 class="h2">Continue your tracks</h2>
      <div class="hint">We suggest the fastest next win.</div>
    </div>

    <div class="suggestCard" @click="goJourney" role="button" tabindex="0">
      <div class="suggestTop">
        <div class="suggestTitle">{{ suggestedTrack.label }}</div>
        <div class="suggestMeta">
          <span class="chip">{{ suggestedTrack.value }}%</span>
          <span class="chip">{{ suggestedTrack.hint }}</span>
        </div>
      </div>
      <div class="suggestCta">Open Tracks →</div>
    </div>
  </section>

  <!-- Random 3 stories -->
  <section class="card compact">
    <div class="cardHead">
      <h2 class="h2">Stories for you</h2>
      <div class="hint">Three quick reads.</div>
    </div>

    <div class="storyGrid">
      <button v-for="s in randomStories" :key="s.id" class="storyCard" @click="goStory(s.id)">
        <div class="storyTitle">{{ s.title }}</div>
        <div class="storySub">{{ s.sub }}</div>
        <div class="storyCta">Open story →</div>
      </button>
    </div>
  </section>
  </div>

</template>

<script>
export default {
  name: "PowerCheck",

  data() {
    return {
      check: { voice: 50, boundary: 50, energy: 50 },
      selectedBlocker: "fear",
      selectedDay: null,

      storiesPool: [
        { id: "s1", title: "The 3-sentence boundary moment", sub: "Reclaim space calmly, without over-explaining." },
        { id: "s2", title: "Micro-courage in public", sub: "How tiny visibility acts compound into confidence." },
        { id: "s3", title: "Negotiation without apology", sub: "One shift that makes your ask land stronger." },
        { id: "s4", title: "The calm ‘No’", sub: "A polite refusal that doesn’t invite debate." },
        { id: "s5", title: "When energy drops", sub: "A reset ritual that actually works on hard days." },
        { id: "s6", title: "Influence through story", sub: "Mobilize support without manipulation." }
      ],

      blockers: [
        { id: "fear", icon: "😬", title: "Fear", sub: "Hesitation, self-doubt, overthinking" },
        { id: "overload", icon: "🧠", title: "Overload", sub: "Too much, too fast, no space" },
        { id: "conflict", icon: "⚡", title: "Conflict", sub: "Tension, pushback, hard conversations" },
        { id: "unclear", icon: "🌫️", title: "Unclear goals", sub: "No direction, no next step" }
      ],

      rec: {
        story: { title: "The 3-sentence boundary moment", sub: "A quick story about reclaiming space calmly." },
        model: { title: "Boundary Script Builder", sub: "Situation → Limit → Alternative → Pushback responses." },
        course: { title: "Boundaries & Saying No", sub: "Short, calm, repeatable boundaries without guilt." }
      },

      last7: [
        { date: "Mon", short: "M", state: "stable", score: 62, note: "Used one clear ask. Energy okay." },
        { date: "Tue", short: "T", state: "rising", score: 74, note: "Spoke up in a meeting. Felt strong after." },
        { date: "Wed", short: "W", state: "drained", score: 41, note: "Overcommitted. Needed rest." },
        { date: "Thu", short: "T", state: "stable", score: 58, note: "Kept boundaries in small ways." },
        { date: "Fri", short: "F", state: "rising", score: 70, note: "Negotiated a timeline. Felt respected." },
        { date: "Sat", short: "S", state: "drained", score: 45, note: "Heavy week. Recovery day." },
        { date: "Sun", short: "S", state: "stable", score: 60, note: "Reset and planned one priority." }
      ]
    };
  },

  computed: {

    suggestedTrack() {
      // “kaldığı yer”: en düşük yüzde = en çok ihtiyaç
      const sorted = this.trackBars.slice().sort((a, b) => a.value - b.value);
      return sorted[0] || { label: "Tracks", value: 0, hint: "Keep going." };
    },

    randomStories() {
      // her render’da değişmesin diye istersen created()’da set ederiz
      // şimdilik basit: powerScore'a göre deterministik shuffle
      const seed = this.powerScore + (this.check.voice || 0) * 2 + (this.check.energy || 0);
      const arr = this.storiesPool.slice();

      let x = seed % 2147483647;
      const rand = () => (x = (x * 48271) % 2147483647) / 2147483647;

      for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(rand() * (i + 1));
        const tmp = arr[i]; arr[i] = arr[j]; arr[j] = tmp;
      }

      return arr.slice(0, 3);
    },
    powerScore() {
      const v = this.check.voice || 0;
      const b = this.check.boundary || 0;
      const e = this.check.energy || 0;
      return Math.round((v + b + e) / 3);
    },

    stateLabel() {
      const s = this.powerScore;
      if (s >= 70) return "Rising";
      if (s <= 45) return "Drained";
      return "Stable";
    },

    stateEmoji() {
      const s = this.powerScore;
      if (s >= 70) return "🔥";
      if (s <= 45) return "🫧";
      return "⚡";
    },

    stateClass() {
      const s = this.powerScore;
      if (s >= 70) return "rising";
      if (s <= 45) return "drained";
      return "stable";
    },

    trackBars() {
      const base = this.powerScore;
      return [
        { id: "dare", label: "I Dare", value: this.clamp(base + (this.check.boundary - 50) / 4), color: "#2D6CDF", hint: "Courage, boundaries, visibility." },
        { id: "speak", label: "I Speak", value: this.clamp(base + (this.check.voice - 50) / 3), color: "#F59E0B", hint: "Communication and influence." },
        { id: "earn", label: "I Earn", value: this.clamp(base - 6), color: "#1F9D63", hint: "Money clarity & leverage." },
        { id: "lead", label: "I Lead", value: this.clamp(base - 3), color: "#8B5CF6", hint: "Ethical power & decisions." },
        { id: "impact", label: "I Impact", value: this.clamp(base - 8), color: "#06B6D4", hint: "Society, systems, civic action." }
      ];
    },

    leverage() {
      const b = this.selectedBlocker;
      const s = this.powerScore;

      if (b === "fear") {
        return {
          title: "Do one micro-courage ask today",
          time: "2–4 min",
          track: "I Dare",
          desc: "Pick one small moment: ask a question, state a preference, or request clarity. One short sentence. No explaining."
        };
      }

      if (b === "overload") {
        return {
          title: "Renegotiate one commitment",
          time: "3–5 min",
          track: "I Lead",
          desc: "Choose one thing to delay or delegate. Send a calm one-liner. Protect tomorrow’s energy."
        };
      }

      if (b === "conflict") {
        return {
          title: "Use a boundary + care sentence",
          time: "3–5 min",
          track: "I Speak",
          desc: "Say: “I get it. And I’m not available for X. I can do Y.” Then stop. Let silence work for you."
        };
      }

      if (s < 55) {
        return {
          title: "Write your one priority (and one “not now”)",
          time: "2–3 min",
          track: "I Impact",
          desc: "Name the single outcome you want this week. Then name one thing you are not doing."
        };
      }

      return {
        title: "Turn one idea into a tiny pilot",
        time: "5–8 min",
        track: "I Build",
        desc: "Define a mini experiment: what, who, when, success signal. Small is smarter."
      };
    }
  },

  methods: {
    goStory(id) {
      // eğer story sayfan id ile çalışıyorsa:
      // this.$router.push({ name: "story", params: { id } })
      // şimdilik query ile:
      this.$router.push({ name: "stories", query: { id } });
    },
    clamp(v) {
      const n = Math.round(v);
      return Math.max(0, Math.min(100, n));
    },

    setCheck(key, val) {
      this.check[key] = val;
    },

    selectBlocker(id) {
      this.selectedBlocker = id;
    },

    resetToday() {
      this.check.voice = 50;
      this.check.boundary = 50;
      this.check.energy = 50;
      this.selectedBlocker = "fear";
      this.selectedDay = null;
    },

    dayStateLabel(s) {
      if (s === "rising") return "Rising";
      if (s === "drained") return "Drained";
      return "Stable";
    },

    goJourney() {
      this.$router.push({ name: "journey" });
    },

    goSimulatorFast() {
      this.$router.push({ path: "/simulator" });
    },

    goStories() {
      this.$router.push({ name: "stories" });
    },

    openModel() {
      this.$router.push("/model");
    },

    openCourse() {
      this.$router.push("/course");
    }
  }
};
</script>

<style scoped>
.pc {
  --brand-pink: #ff2d7a;
  --brand-blue: #2d6cdf;
  --ink: #0f172a;
  --muted: #64748b;

  --bg: #f7fbff;
  --card: #ffffff;
  --line: #e6eef7;

  --shadow: 0 10px 28px rgba(15, 23, 42, 0.08);

  max-width: 980px;
  margin: 0 auto;
  padding: 14px 12px 44px;
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
  color: var(--ink);
  background: var(--bg);
  min-height: 100vh;
}

/* Header */
.head {
  position: sticky;
  top: 0;
  z-index: 30;
  background: rgba(247, 251, 255, 0.92);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  padding: 10px 2px;
  margin: 0 0 12px;
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

/* Summary */
.summaryCard {
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.summaryTop {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 12px;
}

.statePill {
  border: 1px solid var(--line);
  border-radius: 999px;
  padding: 10px 12px;
  display: inline-flex;
  gap: 10px;
  align-items: center;
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.07));
}

.statePill.rising {
  border-color: rgba(255, 45, 122, 0.26);
}

.statePill.stable {
  border-color: rgba(45, 108, 223, 0.24);
}

.statePill.drained {
  background: #fff;
}

.emoji {
  font-size: 18px;
}

.stateText {
  display: inline-flex;
  gap: 6px;
  align-items: baseline;
}

.stateLabel {
  color: var(--muted);
  font-size: 12px;
  font-weight: 900;
}

.stateValue {
  font-size: 13px;
  font-weight: 900;
}

.scoreWrap {
  text-align: right;
}

.scoreNum {
  font-size: 22px;
  font-weight: 900;
  line-height: 1;
}

.scoreDen {
  font-size: 13px;
  color: var(--muted);
  font-weight: 900;
}

.scoreHint {
  margin-top: 6px;
  font-size: 12px;
  color: var(--muted);
  font-weight: 800;
}

.scoreBar {
  margin-top: 12px;
  height: 10px;
  border-radius: 999px;
  background: rgba(230, 238, 247, 0.9);
  border: 1px solid rgba(230, 238, 247, 1);
  overflow: hidden;
}

.scoreFill {
  height: 100%;
  width: 0%;
  background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
}

.microNote {
  margin-top: 10px;
  color: var(--muted);
  font-size: 12px;
  font-weight: 800;
}

/* Cards */
.card {
  margin-top: 12px;
  border: 1px solid var(--line);
  background: var(--card);
  border-radius: 18px;
  padding: 14px;
  box-shadow: var(--shadow);
}

.card.compact {
  padding: 12px;
}

.cardHead {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 10px;
}

.h2 {
  margin: 0;
  font-size: 16px;
  font-weight: 900;
}

.hint {
  color: var(--muted);
  font-size: 12px;
  font-weight: 800;
}

/* Rows */
.rows {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
  padding-top: 10px;
  border-top: 1px solid rgba(230, 238, 247, 0.8);
}

.row:first-child {
  border-top: 0;
  padding-top: 0;
}

.rowTitle {
  font-weight: 900;
}

.rowSub {
  margin-top: 3px;
  color: var(--muted);
  font-size: 12px;
  font-weight: 800;
}

.seg {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

.segBtn {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 14px;
  padding: 12px 10px;
  font-weight: 900;
  cursor: pointer;
  min-height: 44px;
}

.segBtn.on {
  border-color: rgba(45, 108, 223, 0.32);
  box-shadow: 0 10px 20px rgba(45, 108, 223, 0.10);
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.06));
}

/* Blockers */
.blockerGrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

.blocker {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  padding: 12px;
  cursor: pointer;
  text-align: left;
  display: flex;
  gap: 10px;
  align-items: center;
}

.blocker.on {
  border-color: rgba(255, 45, 122, 0.35);
  box-shadow: 0 14px 28px rgba(255, 45, 122, 0.10);
}

.bIcon {
  width: 44px;
  height: 44px;
  border-radius: 16px;
  border: 1px solid var(--line);
  background: linear-gradient(135deg, rgba(255, 45, 122, 0.10), rgba(45, 108, 223, 0.08));
  display: grid;
  place-items: center;
  font-size: 18px;
}

.bTitle {
  font-weight: 900;
}

.bSub {
  margin-top: 2px;
  color: var(--muted);
  font-size: 12px;
  font-weight: 800;
}

.moveBox {
  margin-top: 12px;
  border: 1px solid rgba(230, 238, 247, 0.9);
  background: rgba(247, 251, 255, 0.9);
  border-radius: 16px;
  padding: 12px;
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
  font-size: 14px;
}

.chips {
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

.actions {
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

.ghost2 {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 14px;
  padding: 12px 12px;
  font-weight: 900;
  cursor: pointer;
}

/* Details */
.details {
  margin-top: 12px;
  border-radius: 18px;
  overflow: hidden;
}

.detailsSummary {
  list-style: none;
  cursor: pointer;
  user-select: none;
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 18px;
  padding: 12px 14px;
  box-shadow: var(--shadow);
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 10px;
  font-weight: 900;
}

.detailsSummary::-webkit-details-marker {
  display: none;
}

.detailsHint {
  font-size: 12px;
  color: var(--muted);
  font-weight: 800;
}

/* Tracks inside Insights */
.tgrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

.trow {
  border-top: 1px solid rgba(230, 238, 247, 0.8);
  padding-top: 10px;
}

.trow:first-child {
  border-top: 0;
  padding-top: 0;
}

.tTop {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  margin-bottom: 6px;
}

.tName {
  font-weight: 900;
}

.tVal {
  font-weight: 900;
  color: var(--muted);
}

.tBar {
  height: 10px;
  border-radius: 999px;
  background: rgba(230, 238, 247, 0.9);
  border: 1px solid rgba(230, 238, 247, 1);
  overflow: hidden;
}

.tFill {
  height: 100%;
  width: 0%;
}

.tHint {
  margin-top: 6px;
  color: var(--muted);
  font-size: 12px;
  font-weight: 800;
}

.link {
  border: 0;
  background: transparent;
  font-weight: 900;
  cursor: pointer;
  color: var(--brand-blue);
  text-decoration: underline;
}

/* Recommendations */
.recoGrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

.reco {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  padding: 12px;
  cursor: pointer;
  text-align: left;
  display: flex;
  gap: 10px;
  align-items: flex-start;
}

.rIcon {
  width: 44px;
  height: 44px;
  border-radius: 16px;
  border: 1px solid var(--line);
  background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.08));
  display: grid;
  place-items: center;
  font-size: 20px;
}

.rTop {
  font-size: 12px;
  font-weight: 900;
  color: var(--muted);
}

.rName {
  font-weight: 900;
  margin-top: 6px;
  display: block;
}

.rSub {
  color: #475569;
  margin-top: 6px;
  line-height: 1.35;
  font-weight: 700;
  font-size: 12px;
}

/* 7-day */
.dotsRow {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.dayDot {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  width: 56px;
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

.noteCard {
  margin-top: 10px;
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  padding: 12px;
}

.noteTop {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

/* Responsive */
@media (min-width: 720px) {
  .row {
    grid-template-columns: 1fr 420px;
    align-items: center;
  }

  .blockerGrid {
    grid-template-columns: 1fr 1fr;
  }

  .actions {
    grid-template-columns: 1.3fr 1fr 1fr;
  }

  .recoGrid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

.suggestCard {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  padding: 12px;
  cursor: pointer;
}

.suggestTop {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

.suggestTitle {
  font-weight: 900;
}

.suggestMeta {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.suggestCta {
  font-weight: 900;
  color: var(--brand-blue);
}

.storyGrid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

.storyCard {
  border: 1px solid var(--line);
  background: #fff;
  border-radius: 16px;
  padding: 12px;
  cursor: pointer;
  text-align: left;
}

.storyTitle {
  font-weight: 900;
  margin-bottom: 6px;
}

.storySub {
  color: #475569;
  font-size: 12px;
  font-weight: 700;
  line-height: 1.35;
}

.storyCta {
  margin-top: 10px;
  font-weight: 900;
  color: var(--brand-blue);
}

@media (min-width: 720px) {
  .storyGrid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}
</style>