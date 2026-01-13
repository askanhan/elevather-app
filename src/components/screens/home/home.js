import PostCard from '@/components/complementarities/PostCard.vue'
import NewsTicker from '@/components/complementarities/NewsTicker.vue'
import PartnerRail from '@/components/complementarities/PartnerRail.vue'

export default {
  name: 'Home',
  components: { PostCard, NewsTicker, PartnerRail },

  computed: {
    lang() {
      return this.$store.state.lang
    },
    posts() {
      return this.$store.state.posts || []
    },
    generalPosts() {
      return this.posts.filter(p => p.category == 0)
    },
    activityPosts() {
      return this.posts.filter(p => p.category == 1)
    },
    jobPosts() {
      return this.posts.filter(p => p.category == 2)
    },
    educationPosts() {
      return this.posts.filter(p => p.category == 3)
    },
    filteredPosts() {
      switch (this.activeTab) {
        case 'general': return this.generalPosts
        case 'activity': return this.activityPosts
        case 'job': return this.jobPosts
        case 'education': return this.educationPosts
        default: return this.generalPosts
      }
    },
    visiblePosts() {
      return this.filteredPosts.slice(0, this.numberOfVisiblePosts)
    },
  },

  data() {
    return {
      activeTab: 'general',
      __homeScrollRestored: false,

      // infinite (basit)
      numberOfVisiblePosts: 10,
      step: 10,
      loadingMore: false,
      noMorePosts: false,

      _io: null,
      _scrollerEl: null,
      _onScrollerScroll: null,
      _olderInFlight: false,
    }
  },

  watch: {
    activeTab() {
      this.numberOfVisiblePosts = 10
      this.noMorePosts = false
      this.$nextTick(() => this.setupFeedObserver())
    },
    filteredPosts() {
      // liste güncellenince observer’ı tazele
      this.$nextTick(() => this.setupFeedObserver())
    },
  },

  async activated() {
    this.$store.dispatch('getAllConversations')

    const newMessages = await this.$store.dispatch('getNewPosts')
    if (newMessages > 0) {
      this.$message.success('Yeni postlar var: ' + newMessages + ' adet')
    }

    this.restoreHomeScroll()

    this.$nextTick(() => {
      // scroller listener sadece scroll kaydetmek için, infinite için değil
      const scroller = document.getElementById('SCROLLER')
      this._scrollerEl = scroller

      this._onScrollerScroll = () => {}
      if (scroller) scroller.addEventListener('scroll', this._onScrollerScroll, { passive: true })

      this.setupFeedObserver()
    })
  },

  deactivated() {
    this.saveHomeScroll()
    this.teardownFeedObserver()

    if (this._scrollerEl && this._onScrollerScroll) {
      this._scrollerEl.removeEventListener('scroll', this._onScrollerScroll)
    }
    this._scrollerEl = null
    this._onScrollerScroll = null
  },

  beforeUnmount() {
    this.teardownFeedObserver()

    if (this._scrollerEl && this._onScrollerScroll) {
      this._scrollerEl.removeEventListener('scroll', this._onScrollerScroll)
    }
    this._scrollerEl = null
    this._onScrollerScroll = null
  },

  methods: {
    setupFeedObserver() {
      this.teardownFeedObserver()

      const sentinel = this.$refs.feedSentinel
      if (!sentinel) return

      const scroller = document.getElementById('SCROLLER') || null

      this._io = new IntersectionObserver(
        (entries) => {
          const e = entries[0]
          if (!e?.isIntersecting) return
          this.handleSentinelHit()
        },
        {
          root: scroller,
          rootMargin: '400px',
          threshold: 0.01,
        }
      )

      this._io.observe(sentinel)
    },

    teardownFeedObserver() {
      if (this._io) {
        this._io.disconnect()
        this._io = null
      }
    },

    async handleSentinelHit() {
      if (this.loadingMore || this.noMorePosts) return
      const sentinel = this.$refs.feedSentinel
      if (!this._io || !sentinel) return

      // spam'i bitir: tetikler tetiklemez durdur
      this._io.unobserve(sentinel)

      try {
        // 1) önce mevcut listeden daha fazla göster
        if (this.numberOfVisiblePosts < this.filteredPosts.length) {
          this.numberOfVisiblePosts = Math.min(
            this.numberOfVisiblePosts + this.step,
            this.filteredPosts.length
          )

          // DOM büyüsün, sonra tekrar observe
          await new Promise(r => this.$nextTick(r))
          if (this._io && this.$refs.feedSentinel) this._io.observe(this.$refs.feedSentinel)
          return
        }

        // 2) artık UI'da gösterecek yok => store'dan daha eski çek
        await this.fetchOlderPosts()

      } finally {
        // her durumda yeniden observe etmeye çalış
        this.$nextTick(() => {
          if (this._io && this.$refs.feedSentinel && !this.noMorePosts) {
            this._io.observe(this.$refs.feedSentinel)
          }
        })
      }
    },

    async fetchOlderPosts() {
      if (this._olderInFlight || this.noMorePosts) return

      this._olderInFlight = true
      this.loadingMore = true

      try {
        const before = this.filteredPosts.length
        const res = await this.$store.dispatch('loadOlderPosts')
        const after = this.filteredPosts.length

        const added = (typeof res === 'number') ? res : (after - before)

        if (!added || added <= 0) {
          this.noMorePosts = true
          return
        }

        // yeni gelenler de görünsün
        this.numberOfVisiblePosts = Math.min(
          this.numberOfVisiblePosts + Math.max(this.step, added),
          this.filteredPosts.length
        )
      } catch (e) {
        console.error('loadOlderPosts failed', e)
      } finally {
        this.loadingMore = false
        this._olderInFlight = false
      }
    },

    saveHomeScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return
      sessionStorage.setItem('scroll:home', String(scroller.scrollTop || 0))
    },

    restoreHomeScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return

      const raw = sessionStorage.getItem('scroll:home')
      const top = raw != null ? Number(raw) : 0
      if (!top) return

      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          scroller.scrollTop = top
          this.__homeScrollRestored = true
        })
      })
    },
  },
}