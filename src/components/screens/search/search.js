import icons from '@/mixins/icons.js'
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'
import basicOperations from '@/mixins/basic-operations'
import UIText from '@/mixins/ui-text.js'
import genericLogo from '@/assets/burada_generic_logo.png'

export default {
  name: 'Search',
  mixins: [basicOperations, icons, UIText],
  components: { ProfileAvatar },

  data() {
    return {
      loadingMore: false,
      genericLogo,
      numberOfVisibleBusinesses: 10,
      LOAD_STEP: 10,
      bizObserver: null,
      loadingMore: false,

      // category
      state: '',
      pickedCategoryId: null,
      showCat: false,
      catIndex: 0,

      // province/town
      provinceState: '',
      selectedProvinceAndCities: null,
      showProv: false,
      provIndex: 0,

      // tags
      selectedTagIds: [],
      showAll: true,

      // misc (senin eski alanlar)
      selectedCatAndTags: null
    }
  },
  watch: {
    // filtreler değişince liste yeni hesaplanıyorsa, pagination resetle
    allBusinesses() {
      this.numberOfVisibleBusinesses = 10
      this.$nextTick(() => this.setupBizObserver(true))
    },
  },

  activated() {
    this.restoreSearchScroll()
    this.$nextTick(() => this.setupBizObserver(true))
  },
  deactivated() {
    this.saveSearchScroll()
    this.teardownBizObserver()
  },

  mounted() {
    // click-outside kapatma (mobilde de stabil)
    window.addEventListener('pointerdown', this.onGlobalPointerDown, true)
    this.$nextTick(() => this.setupBizObserver(true))
  },

  unmounted() {
    window.removeEventListener('pointerdown', this.onGlobalPointerDown, true)
    this.teardownBizObserver()
  },

  computed: {
    myBusinesses() {
      return this.$store.state.myBusinesses || []
    },
    lang() { return this.$store.state.lang },

    allCategories() { return this.$store.state.categories || [] },
    provinces() { return this.$store.state.provinces || [] },
    towns() { return this.$store.state.towns || [] },

    allTags() {
      const t = this.$store.state.tags
      return Array.isArray(t) ? t : (t && Array.isArray(t.results) ? t.results : [])
    },

    // --- CATEGORY OPTIONS / FILTER
    catList() {
      return (this.allCategories || []).map(c => ({
        id: c.id,
        value: this.catLabel(c),
        icon: c.icon || null,
      }))
    },

    catFiltered() {
      const q = (this.state || '').toLowerCase().trim()
      const list = this.catList
      if (!q) return list.slice(0, 60)
      return list
        .filter(x => (x.value || '').toLowerCase().includes(q))
        .slice(0, 60)
    },

    // --- PROVINCE OPTIONS / FILTER
    provinceOptions() {
      const provs = Array.isArray(this.provinces) ? this.provinces : []
      const towns = Array.isArray(this.towns) ? this.towns : []
      const lang = this.lang
      const out = []

      for (const p of provs) {
        const id = p.pr_id ?? p.id ?? p.province_id
        const label =
          p[`pr_name_${lang}`] ||
          p[`name_${lang}`] ||
          p.pr_name_tr ||
          p.pr_name ||
          p.name ||
          `İl ${id}`

        out.push({ type: 'province', id, value: `prov-${id}`, label })
      }

      for (const t of towns) {
        const id = t.town_id ?? t.id
        const label =
          t[`town_name_${lang}`] ||
          t[`name_${lang}`] ||
          t.town_name_tr ||
          t.town_name ||
          t.name ||
          `İlçe ${id}`

        out.push({
          type: 'town',
          id,
          value: `town-${id}`,
          label,
          fk_province: t.fk_province ?? t.province_id ?? null,
        })
      }

      return out
    },

    provFiltered() {
      const q = (this.provinceState || '').toLowerCase().trim()
      const list = this.provinceOptions
      if (!q) return list.slice(0, 80)
      return list
        .filter(x => (x.label || '').toLowerCase().includes(q))
        .slice(0, 80)
    },

    // --- selected location parser
    selectedLocation() {
      const v = this.selectedProvinceAndCities
      if (!v || typeof v !== 'string') return null
      if (v.startsWith('prov-')) return { type: 'province', id: v.slice('prov-'.length) }
      if (v.startsWith('town-')) return { type: 'town', id: v.slice('town-'.length) }
      return null
    },

    visibleBusinesses() {
      return this.allBusinesses.slice(0, this.numberOfVisibleBusinesses)
    },

    // --- businesses filter (senin eski mantık)
    allBusinesses() {
      const location = this.selectedLocation
      const businesses = this.$store.state.businesses || []

      return businesses.filter(business => {
        const categoryMatch = this.pickedCategoryId
          ? String(business.fk_category_id) === String(this.pickedCategoryId)
          : true

        const tagMatch = this.selectedTagIds.length > 0
          ? this.selectedTagIds.some(tagId => String(business.fk_tag_id) === String(tagId))
          : true

        let locationMatch = true
        if (location) {
          const id = String(location.id)
          if (location.type === 'province') locationMatch = String(business.fk_province_id) === id
          if (location.type === 'town') locationMatch = String(business.fk_town_id) === id
        }

        return categoryMatch && tagMatch && locationMatch
      })
    },

    selectedCategory() {
      if (!this.pickedCategoryId) return null
      return this.allCategories.find(c => String(c.id) === String(this.pickedCategoryId)) || null
    },

    // ✅ SADECE BURASI: tag’leri kategoriye bağlarken fk_category desteği
    filteredTags() {
      if (!this.selectedCategory) return []
      const cid = String(this.selectedCategory.id)

      return this.allTags.filter(t => {
        const catId = t.fk_category ?? t.fk_category_id ?? t.category_id ?? t.category ?? null
        return catId != null && String(catId) === cid
      })
    },
  },

  methods: {
    goToMyProfile() {
      const p = this.$store.state.myProfile
      const id = p?.id || p?.p_id
      if (!id) {
        // login değilse ya da profil yoksa
        this.$router.push({ name: 'profile' }).catch(() => { })
        return
      }
      this.$router.push({ name: 'profile', params: { profileID: id } }).catch(() => { })
    },

    resetSearch() {
      // kategori + tag + lokasyon temizle
      this.state = ''
      this.pickedCategoryId = null
      this.activateShowAll?.()

      this.provinceState = ''
      this.selectedProvinceAndCities = null

      // dropdown’lar kapansın (simple autocomplete kullanıyorsan)
      this.showCat = false
      this.showProv = false
    },
    getScrollRoot() {
      return document.getElementById("SCROLLER") || null
    },

    setupBizObserver(restart = false) {
      if (this.bizObserver && !restart) return
      this.teardownBizObserver()

      const sentinel = this.$refs.bizSentinel
      if (!sentinel) return

      const root = this.getScrollRoot()

      this.bizObserver = new IntersectionObserver(
        (entries) => {
          const entry = entries[0]
          if (entry && entry.isIntersecting) {
            this.scheduleLoadMore()
          }
        },
        {
          root,
          rootMargin: "0px 0px 500px 0px",
          threshold: 0.01,
        }
      )

      this.bizObserver.observe(sentinel)
    },

    teardownBizObserver() {
      if (this.bizObserver) {
        this.bizObserver.disconnect()
        this.bizObserver = null
      }
    },

    scheduleLoadMore() {
      if (this.loadingMore) return
      if (this.numberOfVisibleBusinesses >= this.allBusinesses.length) return

      this.loadingMore = true

      setTimeout(() => {
        const next = this.numberOfVisibleBusinesses + this.LOAD_STEP
        this.numberOfVisibleBusinesses = Math.min(this.allBusinesses.length, next)
        this.loadingMore = false
      }, 500)
    },

    // --- click outside close
    onGlobalPointerDown(e) {
      const catOk = this.$refs.catWrap?.contains?.(e.target)
      const provOk = this.$refs.provWrap?.contains?.(e.target)
      if (!catOk) this.showCat = false
      if (!provOk) this.showProv = false
    },

    // ✅ SADECE BURASI: category/tag isimlerini name_{lang}’den okut
    catLabel(c) {
      const lang = this.lang || 'tr'
      console.log('catLabel lang:', lang)
      console.log('catLabel c:', c)
      console.log('catLabel c name_lang:', c?.[`name_${lang}`])
      return (
        c?.[`name_${lang}`] ||
        c?.name_tr ||
        c?.name ||                            // en sona kalsın
        ''
      )
    },
    tagName(t) {
      if (this.lang === 'nl' && t.name_nl) return t.name_nl
      if (this.lang === 'fr' && t.name_fr) return t.name_fr
      return t.name || t.name_tr || ''
    },

    tagIdToName(tagId) {
      const tag = this.allTags.find(t => String(t.id) === String(tagId))
      return tag ? this.tagName(tag) : ''
    },
    tagIdToIcon(tagId) {
      const tag = this.allTags.find(t => String(t.id) === String(tagId))
      return (tag && tag.icon) ? tag.icon : ''
    },

    // ============ CATEGORY AUTOCOMPLETE ============
    openCat() {
      this.showCat = true
      this.catIndex = 0
    },
    closeCat() {
      this.showCat = false
    },
    onCatInput() {
      this.showCat = true
      this.catIndex = 0
    },
    clearCat() {
      this.state = ''
      this.pickedCategoryId = null
      this.activateShowAll()
      this.$nextTick(() => {
        this.showCat = true
        this.catIndex = 0
        this.$refs.catInput?.focus?.()
      })
    },
    selectCat(item) {
      this.state = item.value
      this.pickedCategoryId = item.id
      this.activateShowAll()
      this.showCat = false
    },
    catMove(dir) {
      if (!this.showCat) this.showCat = true
      const max = this.catFiltered.length - 1
      if (max < 0) return
      this.catIndex = Math.max(0, Math.min(max, this.catIndex + dir))
    },
    catEnter() {
      const it = this.catFiltered[this.catIndex]
      if (it) this.selectCat(it)
    },

    // ============ PROVINCE AUTOCOMPLETE ============
    openProv() {
      this.showProv = true
      this.provIndex = 0
    },
    closeProv() {
      this.showProv = false
    },
    onProvInput() {
      this.showProv = true
      this.provIndex = 0
    },
    clearProv() {
      this.provinceState = ''
      this.selectedProvinceAndCities = null
      this.$nextTick(() => {
        this.showProv = true
        this.provIndex = 0
        this.$refs.provInput?.focus?.()
      })
    },
    selectProv(item) {
      this.provinceState = item.label
      this.selectedProvinceAndCities = item.value
      this.showProv = false
    },
    provMove(dir) {
      if (!this.showProv) this.showProv = true
      const max = this.provFiltered.length - 1
      if (max < 0) return
      this.provIndex = Math.max(0, Math.min(max, this.provIndex + dir))
    },
    provEnter() {
      const it = this.provFiltered[this.provIndex]
      if (it) this.selectProv(it)
    },

    // ============ TAGS ============
    activateShowAll() {
      this.showAll = true
      this.selectedTagIds = []
    },
    toggleTag(tagId) {
      this.showAll = false
      const i = this.selectedTagIds.indexOf(tagId)
      if (i === -1) this.selectedTagIds.push(tagId)
      else this.selectedTagIds.splice(i, 1)
      if (this.selectedTagIds.length === 0) this.showAll = true
    },
    isTagSelected(tagId) {
      return this.selectedTagIds.includes(tagId)
    },

    // ============ NAV ============
    goToBusinessDetailPage(id) {
      if (!id) return
      this.$router.push({ name: 'business', params: { businessID: id } })
    },

    // ============ SCROLL SAVE/RESTORE (seninki) ============
    saveSearchScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return
      sessionStorage.setItem('scroll:search', String(scroller.scrollTop || 0))
    },
    restoreSearchScroll() {
      const scroller = document.getElementById('SCROLLER')
      if (!scroller) return
      const raw = sessionStorage.getItem('scroll:search')
      const top = raw != null ? Number(raw) : 0
      if (!top) return
      requestAnimationFrame(() => requestAnimationFrame(() => { scroller.scrollTop = top }))
    },
  },
}