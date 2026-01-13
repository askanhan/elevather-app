import defaultAvatar from '@/assets/default-avatar.png'   // 👈 burası yeni
import UIText from '@/mixins/ui-text.js'
import basicOperations from '@/mixins/basic-operations'
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'
import NewsTicker from '@/components/complementarities/NewsTicker.vue'
export default {
  name: 'NewsList',
  components: { ProfileAvatar, NewsTicker },
  mixins: [UIText, basicOperations],
  created() {
    this.$store.dispatch('loadAllNews')
  },
  data() {
    return {
      __newsScrollRestored: false,
    }
  },

  computed: {
    news() {
      return this.$store.state.allNews.results || []
    }
  },
  activated() {
    this.restoreNewsListScroll()
  },

  deactivated() {
    this.saveNewsListScroll()
  },

  watch: {
    darkMode(newVal) {
      if (newVal) document.body.classList.add('dark-mode')
      else document.body.classList.remove('dark-mode')
      localStorage.setItem('profile_dark_mode', newVal ? '1' : '0')
    }
  },

  mounted() {
    const saved = localStorage.getItem('profile_dark_mode')
    if (saved === '1') this.darkMode = true
  },

  methods: {
    saveNewsListScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return

      const top = scroller.scrollTop || 0
      sessionStorage.setItem('scroll:newslist', String(top))
      // console.log('[NewsList] saveScroll', top)
    },

    restoreNewsListScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return

      const raw = sessionStorage.getItem('scroll:newslist')
      const top = raw != null ? Number(raw) : 0
      if (!top) return

      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          scroller.scrollTop = top
          this.__newsScrollRestored = true
          // console.log('[NewsList] restoreScroll', top)
        })
      })
    },
    showMore() {
      this.visibleCount = Math.min(
        this.visibleCount + this.stepCount,
        this.news.length
      )
    },

    openNews(itemIdx) {
      this.$router.push({ name: 'newsDetail', params: { index: itemIdx } })
    },

    formatDate(iso) {
      if (!iso) return ''
      try {
        const d = new Date(iso)
        return d.toLocaleDateString(this.$store.state.lang, {
          day: '2-digit',
          month: 'short',
          year: 'numeric',
        })
      } catch (e) {
        return iso
      }
    },

    // Optional mapping if you keep sources in store
    sourceLabel(sourceId) {
      const sources = this.$store.state.news_sources || []
      const s = sources.find(x => String(x.id) === String(sourceId))
      return s?.name || this.$t('pages.newsList.defaultSource')
    },
  }
}