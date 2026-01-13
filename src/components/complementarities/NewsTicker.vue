<template>
  <div class="news-ticker-host" v-if="hasItems">
    <div
      class="news-ticker-wrapper"
      :class="{ 'is-paused': isPaused }"
      @click="togglePauseOnClick"
    >
      <div class="news-ticker-label" style="font-size: 12px">
        <span class="dot">{{ icon }}</span>
        <span class="label-text">{{ label === 'Gündem' ? $t('components.newsTicker.label') : label  }}</span>
      </div>

      <div class="news-ticker">
        <div class="news-ticker-inner" :style="{ '--ticker-duration': speed + 's' }">
          <!-- Track 1 -->
          <div class="news-ticker-track">
            <span class="news-ticker-item" v-for="n in items" :key="'a-' + n.id">
              <a
                class="news-ticker-link"
                @click="this.$router.push('/news-list/')"
                rel="noopener"
              >
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
      <button
        type="button"
        class="news-ticker-toggle"
        :title="isPaused ? $t('components.newsTicker.continue') : $t('components.newsTicker.stop')"
      >
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
      return this.$store.state.latestNews || []
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
.news-ticker-host {
  width: 100%;
  position: relative;
  z-index: 5;
}

/* ana kapsayıcı */
.news-ticker-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 6px 10px;
  background: linear-gradient(90deg, rgba(15, 23, 42, 0.96), rgb(37 58 130 / 95%));
  color: #f9fafb;
  font-size: 16px;
  font-weight: 600;
  overflow: hidden;
  border-radius: 999px;
  margin: 4px 6px;
  box-shadow: 0 4px 12px rgba(15, 23, 42, 0.35);
}

/* sol etiket */
.news-ticker-label {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  border-radius: 999px;
  background: rgba(15, 23, 42, 0.9);
  white-space: nowrap;
  flex-shrink: 0;
}

.news-ticker-label .dot {
  font-size: 12px;
}

.news-ticker-label .label-text {
  font-weight: 600;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

/* scroll alanı */
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

/* item’lar */
.news-ticker-item {
  display: inline-flex;
  align-items: center;
  white-space: nowrap;
  padding: 0 24px;
  position: relative;
}

.news-ticker-item::after {
  content: "•";
  margin-left: 24px;
  opacity: 0.45;
  font-size: 10px;
}

.news-ticker-item:last-child::after {
  content: "";
  margin: 0;
}

.news-ticker-link {
  color: #e5e7eb;
  text-decoration: none;
  font-size: 13px;
}

.news-ticker-link:hover {
  text-decoration: underline;
}

/* pause buton */
.news-ticker-toggle {
  border: none;
  background: transparent;
  color: #e5e7eb;
  padding: 4px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  flex-shrink: 0;
  font-size: 12px;
}

.news-ticker-toggle:active {
  transform: scale(0.9);
}

/* animasyon */
@keyframes ticker-scroll {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-50%);
  }
}

/* pause state */
.news-ticker-wrapper.is-paused .news-ticker-inner {
  animation-play-state: paused;
}

/* küçük ekran optimizasyonu */
@media (max-width: 480px) {
  .news-ticker-wrapper {
    padding-inline: 8px;
    margin-inline: 4px;
  }

  .news-ticker-item {
    padding: 0 18px;
  }

  .news-ticker-label {
    padding-inline: 8px;
  }
}
</style>
