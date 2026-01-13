<template>
  <div class="news-ticker-host" v-if="hasItems">
    <div class="news-ticker-wrapper" :class="{ 'is-paused': isPaused }" @click="togglePauseOnClick">
      <div class="news-ticker-label" style="font-size: 12px">
        <span class="dot">{{ icon }}</span>
        <span class="label-text">
          :
        </span>
      </div>

      <div class="news-ticker">
        <div class="news-ticker-inner" :style="{ '--ticker-duration': speed + 's' }">
          <!-- Track 1 -->
          <div class="news-ticker-track">
            <span class="news-ticker-item" v-for="n in items" :key="'a-' + n.id">
              <a class="news-ticker-link" @click="this.$router.push('/news-list/')" rel="noopener">
                {{ n.title }}
              </a>
            </span>
          </div>

          <!-- Track 2 – kesintisiz akış için tekrar -->
          <div class="news-ticker-track">
            <span class="news-ticker-item" v-for="n in items" :key="'b-' + n.id">
              <a class="news-ticker-link" :href="n.url" target="_blank" rel="noopener">
                {{ n.title }}
              </a>
            </span>
          </div>
        </div>
      </div>

      <!-- küçük pause ikonu -->
      <button type="button" class="news-ticker-toggle"
        :title="isPaused ? $t('components.newsTicker.continue') : $t('components.newsTicker.stop')">
        <i v-if="isPaused" class="fas fa-play"></i>
        <i v-else class="fas fa-pause"></i>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "NewsTicker",

  props: {
    label: {
      type: String,
      default: "Gündem",
    },
    icon: {
      type: String,
      default: "🔴",
    },
    // animasyon süresi (ne kadar büyük, o kadar yavaş)
    speed: {
      type: Number,
      default: 40,
    },
  },

  data() {
    return {
      isPaused: false,
    };
  },

  computed: {
    items() {
      // return this.$store.state.latestNews || []
      return [
        { id: 1, title: "She didn’t wait for permission. She built her own path.", url: "#" },
        { id: 2, title: "Your voice is not too much. It’s exactly what’s needed.", url: "#" },
        { id: 3, title: "Growth begins the moment you choose yourself.", url: "#" },
        { id: 4, title: "Strong women don’t compete. They rise together.", url: "#" },
        { id: 5, title: "You are not behind. You are becoming.", url: "#" },
      ]
    },
    hasItems() {
      return Array.isArray(this.items) && this.items.length > 0;
    },
  },

  methods: {
    pause() {
      this.isPaused = true;
    },
    resume() {
      this.isPaused = false;
    },
    togglePauseOnClick() {
      // mobile’da hover yok; tıklayınca durdur/devam etsin
      this.isPaused = !this.isPaused;
    },
  },
};
</script>

<style scoped>
/* Elevate Her palette (professional, not childish) */
.news-ticker-host {
  --eh-bg-1: #0b1220;        /* deep navy */
  --eh-bg-2: #101e3a;        /* navy blue */
  --eh-surface: rgba(255, 255, 255, 0.06);
  --eh-surface-2: rgba(255, 255, 255, 0.08);

  --eh-text: rgba(255, 255, 255, 0.92);
  --eh-text-muted: rgba(255, 255, 255, 0.72);

  --eh-accent: #e11d48;      /* rose (logo-friendly) */
  --eh-accent-soft: rgba(225, 29, 72, 0.22);
  --eh-border: rgba(255, 255, 255, 0.10);
}

.news-ticker-wrapper {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 7px 12px;

  /* More premium background */
  background: linear-gradient(
    90deg,
    rgba(11, 18, 32, 0.96) 0%,
    rgba(16, 30, 58, 0.96) 55%,
    rgba(11, 18, 32, 0.96) 100%
  );

  color: var(--eh-text);
  overflow: hidden;

  border-radius: 999px;
  margin: 6px 10px;

  border: 1px solid var(--eh-border);
  box-shadow:
    0 10px 24px rgba(0, 0, 0, 0.35),
    0 1px 0 rgba(255, 255, 255, 0.06) inset;
}

/* subtle top highlight */
.news-ticker-wrapper::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 999px;
  pointer-events: none;
  background: radial-gradient(
    120% 120% at 15% 0%,
    rgba(225, 29, 72, 0.12) 0%,
    rgba(225, 29, 72, 0.00) 55%
  );
}

/* left label */
.news-ticker-label {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 5px 10px;
  border-radius: 999px;

  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(225, 29, 72, 0.35);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.22);

  white-space: nowrap;
  flex-shrink: 0;
}

.news-ticker-label .dot {
  /* Make it look like a refined indicator */
  font-size: 10px;
  line-height: 1;
  color: var(--eh-accent);
  filter: drop-shadow(0 0 6px rgba(225, 29, 72, 0.25));
}

.news-ticker-label .label-text {
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--eh-text-muted);
}

/* scroll area */
.news-ticker {
  flex: 1;
  overflow: hidden;
}

.news-ticker-inner {
  display: flex;
  width: max-content;
  animation: ticker-scroll var(--ticker-duration, 40s) linear infinite;
}

.news-ticker-track {
  display: inline-flex;
}

/* items */
.news-ticker-item {
  display: inline-flex;
  align-items: center;
  white-space: nowrap;
  padding: 0 22px;
  position: relative;
}

.news-ticker-item::after {
  content: "•";
  margin-left: 22px;
  opacity: 0.35;
  font-size: 10px;
  color: rgba(255, 255, 255, 0.65);
}

.news-ticker-item:last-child::after {
  content: "";
  margin: 0;
}

.news-ticker-link {
  color: rgba(255, 255, 255, 0.85);
  text-decoration: none;
  font-size: 13px;
  font-weight: 500;
}

.news-ticker-link:hover {
  color: rgba(255, 255, 255, 0.98);
  text-decoration: underline;
  text-decoration-color: rgba(225, 29, 72, 0.75);
  text-underline-offset: 3px;
}

/* pause button */
.news-ticker-toggle {
  border: none;
  background: transparent;
  color: rgba(255, 255, 255, 0.78);
  padding: 6px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  flex-shrink: 0;
  font-size: 12px;
  border-radius: 10px;
}

.news-ticker-toggle:hover {
  background: rgba(255, 255, 255, 0.06);
  color: rgba(255, 255, 255, 0.92);
}

.news-ticker-toggle:active {
  transform: scale(0.95);
}

.news-ticker-wrapper.is-paused .news-ticker-inner {
  animation-play-state: paused;
}

/* animation */
@keyframes ticker-scroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

@media (max-width: 480px) {
  .news-ticker-wrapper {
    padding-inline: 10px;
    margin-inline: 8px;
  }
  .news-ticker-item { padding: 0 18px; }
  .news-ticker-label { padding-inline: 9px; }
}
.news-ticker-wrapper {
  position: relative;     /* <- kritik */
  isolation: isolate;     /* <- pseudo element dışarı sızmasın */
  overflow: hidden;       /* <- highlight kesinlikle dışarı taşmasın */

  display: flex;
  align-items: center;
  gap: 10px;
  padding: 7px 12px;

  background: linear-gradient(
    90deg,
    rgba(11, 18, 32, 0.96) 0%,
    rgba(16, 30, 58, 0.96) 55%,
    rgba(11, 18, 32, 0.96) 100%
  );

  color: var(--eh-text);
  border-radius: 999px;
  margin: 6px 10px;

  border: 1px solid var(--eh-border);
  box-shadow:
    0 10px 24px rgba(0, 0, 0, 0.35),
    0 1px 0 rgba(255, 255, 255, 0.06) inset;
}

/* highlight */
.news-ticker-wrapper::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: inherit;
  pointer-events: none;
  z-index: 0; /* <- arkaya al */

  background: radial-gradient(
    120% 120% at 15% 0%,
    rgba(225, 29, 72, 0.12) 0%,
    rgba(225, 29, 72, 0.00) 55%
  );
}

/* içerikler highlight'ın üstünde kalsın */
.news-ticker-label,
.news-ticker,
.news-ticker-toggle {
  position: relative;
  z-index: 1;
}
</style>
