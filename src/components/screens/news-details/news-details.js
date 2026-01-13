export default {
  name: 'NewsDetail',

  data() {
    return {
      index: null,
      NEWS_SOURCES: {
        1: "Yeni Vatan",
        2: "Avrupa TV",
        3: "Belem Turk",
        4: "Gazete Turk",
        5: "Aktif.be",
        6: "Gundem.be",
        7: "Bruksel Turk"
      }
    }
  },

  computed: {
    allNews() {
      return this.$store.state.allNews.results || []
    },

    newsItem() {
      const i = Number(this.index)
      if (!Number.isFinite(i) || i < 0 || i >= this.allNews.length) return null
      return this.allNews[i]
    },

    otherNews() {
      // basitçe son 5 haberi gösterelim (current hariç)
      const i = Number(this.index)
      return this.allNews
        .filter((_, idx) => idx !== i)
        .slice(0, 5)
    }
  },

  mounted() {
    // index paramdan ya da query'den gelsin
    const p = this.$route.params.index
    const q = this.$route.query.index
    this.index = p ?? q ?? null

  },

  watch: {
    '$route.params.index'(val) {
      this.index = val
      window.scrollTo(0, 0)
    },
    '$route.query.index'(val) {
      if (val != null) {
        this.index = val
        window.scrollTo(0, 0)
      }
    }
  },

  methods: {
    goBack() {
      this.$router.back()
    },
    sourceLabel(sourceId) {
      return this.NEWS_SOURCES[sourceId] || this.$t('common.other');
    },

    sanitizeHtml(html) {
      const tempDiv = document.createElement('div');
      tempDiv.innerHTML = html;
      const scripts = tempDiv.querySelectorAll('script');
      scripts.forEach(script => script.remove());
      return tempDiv.innerHTML;
    },

    openOriginal() {
      if (!this.newsItem?.url) return
      // mobilde in-app browser ya da normal open
      window.open(this.newsItem.url, '_blank')
    },

    shareNews() {
      if (!this.newsItem?.url) return
      const text = `${this.newsItem.title}\n${this.newsItem.url}`

      if (navigator.share) {
        navigator.share({ title: this.newsItem.title, text, url: this.newsItem.url })
      } else {
        navigator.clipboard?.writeText(text)
        alert(this.$t('common.linkCopied'))
      }
    },

    goToNews(i) {
      // listede index farklı olduğu için i'yi yeniden hesaplıyoruz:
      const realIndex = this.allNews.findIndex(n => n.id === this.otherNews[i].id)
      if (realIndex >= 0) {
        this.$router.push({ name: 'newsDetail', params: { index: realIndex } })
      }
    },

    formatDate(iso) {
      try {
        const d = new Date(iso)
        return d.toLocaleDateString('tr-TR', {
          day: '2-digit',
          month: 'long',
          year: 'numeric'
        })
      } catch (e) {
        return iso
      }
    }
  }
}