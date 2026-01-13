import { Preferences } from '@capacitor/preferences'
import * as globalTypes from '@/store/mutation-types'
import Footer from '@/components/complementarities/footer/footer.vue'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'

import { Swiper, SwiperSlide } from 'swiper/vue'
import { Pagination } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'
import { authStore } from "@/store/auth.js"
import  LanguageSwitcher from "@/components/complementarities/LanguageSwitcher.vue"

export default {
  name: 'SplashScreen',
  components: {
    LanguageSwitcher,
    Swiper,
    SwiperSlide,
  },
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      selectedLanguage: 'nl',
      swiperReady: false,
      activeIdx: 0,
      isLangOpen: false
    }
  },
  computed: {
    lang() {
      return this.$store.state.lang
    }
  },
  created() {
    this.detectLang()
    this.detectLocation()
  },
  async mounted() {

    try {

      const { value: session } = await Preferences.get({ key: 'session' })
      if (session) {
        console.log('Session var -> afterlogin')
        await this.$router.isReady()
        this.$router.replace({ name: 'afterlogin' })
        return
      }

      console.log('Session yok -> splash ekranda kal')
      // hiçbir şey yapma, burada bitir
      return
    } catch (e) {
      console.log('Session check hata', e)
      // hata olsa da ekranda kal
      return
    }
  },
  methods: {
    detectLocation() {
      // konum entegrasyonu kapalı
    },

    // Swiper instance'ı burada yakalıyoruz
    onSwiper(sw) {
      this.swiper = sw
      this.swiperReady = true
      // Başlangıç indexi
      if (typeof sw.activeIndex === 'number') {
        this.activeIdx = sw.activeIndex
      }
      // Pagination modülünü etkinleştir
      if (sw.params && sw.modules && !sw.params.modules) {
        sw.params.modules = [Pagination]
      }
    },


    applyLang(code) {
      // 1) Vuex’e yaz (projenizde iki farklı mutation var; varsa ikisini de tetikle)
      // console.log(this.$store.state.lang);
      this.$store.commit("CHANGE_LANGUAGE", code)
      // console.log('LANG CHANGED TO:', code);
      // console.log(this.$store.state.lang);
      // if (this.$store._mutations?.[mutationTypes.CHANGE_LANGUAGE]) {
      //   this.$store.commit(mutationTypes.CHANGE_LANGUAGE, code)
      // }

      // 2) Persist et
      try { authStore.setItem('lang', code) } catch (e) { }

      // 3) Tarih/çeviri kütüphaneleri
      const momentLocale = { tr: 'tr', nl: 'nl-be', fr: 'fr', en: 'en' }[code]
      this.moment?.locale?.(momentLocale)
    },


    // Slide değişince aktif index'i güncelle
    handleClickSlide(sw) {
      const s = sw || this.swiper
      if (s && typeof s.activeIndex === 'number') {
        this.activeIdx = s.activeIndex
      }
    },

    // Geri/İleri ve belirli index'e git
    slidePrev() {
      const s = this.swiper
      if (s?.slidePrev) s.slidePrev()
    },
    slideNext() {
      const s = this.swiper
      if (s?.isEnd) {
        // İleri tuşu son slaytta ise register'a yönlendir
        this.$router.push({ name: 'login' })
        return
      }
      if (s?.slideNext) s.slideNext()
    },
    goTo(index) {
      const s = this.swiper
      if (!s?.slideTo) return
      s.slideTo(index)
      // Son slayta giderse opsiyonel yönlendirme yapmak istersen:
      // if (index === 2) this.$router.push({ name: 'register' })
    },

    goToRegister() {
      this.$router.push({ name: 'login' })
    },

    openLangModal() {
      console.log('OPEN LANG MODAL (new)');
      this.isLangOpen = true;
    },

    closeLangModal() {
      this.isLangOpen = false
    },


    selectLang(code) {
      this.applyLang(code)
      this.isLangOpen = false
    },

    detectLang() {
      authStore.getItem('lang', (err, lang) => {
        if (lang == null) {
          if (navigator.language) {
            if (navigator.language.indexOf('nl') !== -1) {
              this.applyLang('nl')
            } else if (navigator.language.indexOf('fr') !== -1) {
              this.applyLang('fr')
            }  else if (navigator.language.indexOf('en') !== -1) {
              this.applyLang('en')
            } else {
              this.applyLang('tr')
            }
          } else {
            this.applyLang('tr')
          }
        } else {
          this.applyLang(lang)
        }
      })
    },

    setLang(lang) {
      this.$store.commit(mutationTypes.SET_LANG, lang)
      this.selectedLanguage = lang
    },

    changeToLoginMode() {
      this.mode = 'login'
      this.name = ''
      this.password = ''
      this.email = ''
    },

    changeToRegisterMode() {
      this.mode = 'register'
      this.name = ''
      this.password = ''
      this.email = ''
    },

    languageChanged() {
      this.$store.commit(mutationTypes.CHANGE_LANGUAGE, this.selectedLanguage)
    }
  },
  watch: {}
}
