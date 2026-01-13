// src/components/screens/register/register.js

// import { TYPE } from "vue-toastification";
import * as globalTypes from '@/store/mutation-types'
import Footer from '@/components/complementarities/footer/footer.vue'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'

import Vue from 'vue'

export default {
  name: 'Register',
  components: {
    Footer
  },
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      onceFilledInUsername: false,
      onceFilledInEmail: false,
      onceFilledInPwd: false,
      onceFilledInPwd2: false,
      username: '',
      password: '',
      password2: '',
      email: '',
      usernameError: 'Lutfen kullanici adi girin',
      passwordError: 'Lutfen sifrenizi girin',
      password2Error: 'Lutfen sifrenizi girin',
      mailError: 'Lutfen mail adresi girin',
      _gsiInited: false // dahili: google init tekrar etmesin
    }
  },

  created() {},

  mounted() {
    // GOOGLE CLIENT ID -> config/dev.env.js & prod.env.js içinde tanımlı
    const clientId = process.env.GOOGLE_CLIENT_ID

    const initGsi = () => {
      if (this._gsiInited) return
      const g = window.google && window.google.accounts && window.google.accounts.id
      if (!g || !clientId) return

      // 1) initialize
      g.initialize({
        client_id: clientId,
        callback: this.onCredential, // ID Token burada gelecek
        ux_mode: 'popup',
        auto_select: false,
        context: 'signup'
      })

      // 2) Butonu render et
      const el = document.getElementById('gsi-btn')
      if (el) {
        g.renderButton(el, {
          theme: 'filled_blue', // 'outline' da olabilir
          size: 'large',
          text: 'signup_with',  // "Google ile kaydol"
          shape: 'rectangular',
          width: 360,
          locale: 'tr'
        })
      }

      // (opsiyonel) One Tap
      // g.prompt()

      this._gsiInited = true
    }

    // google script’i async geldiği için yüklenmesini bekle
    if (document.readyState === 'complete') {
      initGsi()
    } else {
      window.addEventListener('load', initGsi)
      // ekstra güvence
      setTimeout(initGsi, 700)
    }
  },

  methods: {
    async onCredential(response) {
      try {
        const idToken = response && response.credential
        if (!idToken) throw new Error('Google kimlik bilgisi alınamadı')

        // Backend’e gönder – kendi endpoint’ini kullan
        // Geliştirmede farklı origin ise dev proxy’de /api yönlendirmesi yap
        const res = await fetch('/api/auth/google', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ credential: idToken })
        })
        if (!res.ok) throw new Error('Sunucu doğrulaması başarısız')
        const data = await res.json()

        // Örn. uygulama JWT’nizi saklayın ve yönlendirin
        if (data && data.token) localStorage.setItem('token', data.token)
        // İstersen Vuex’e user set edebilirsin:
        // this.$store.commit('SET_USER', data.user)
        this.$router.push({ name: 'home' })
      } catch (err) {
        console.error(err)
        this.showError('Google ile giriş başarısız oldu.')
      }
    },

    unChanged() {},

    validateEmail(email) {
      // eslint-disable-next-line
      let re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(String(email).toLowerCase())
    },

    goToLogin() {
      this.$router.push({ name: 'login' })
    },

    showError(err) {
      this.$toast(err, { type: 1 }) // TODO TYPE.ERROR
    },

    createAccount() {
      if (this.usernameError.length > 0) {
        this.showError(this.usernameError)
      } else if (this.mailError.length > 0) {
        this.showError(this.mailError)
      } else if (this.passwordError.length > 0) {
        this.showError(this.passwordError)
      } else if (this.password2Error.length > 0) {
        this.showError(this.password2Error)
      } else {
        this.$store.dispatch({
          type: 'register',
          username: this.username,
          mail: this.email,
          password: this.password,
          successCB: () => this.$router.push({ name: 'home' })
        })
      }
    }
  },

  watch: {
    username() {
      this.onceFilledInUsername = true
      this.usernameError = (this.username && this.username.length > 2) ? '' : 'Kullanici adiniz en az 3 haneli olmalidir'
    },
    email() {
      this.onceFilledInEmail = true
      this.mailError = (this.email && this.email.length > 2 && this.validateEmail(this.email)) ? '' : 'Not valid mail address'
    },
    password() {
      this.onceFilledInPwd = true
      this.passwordError = (this.password && this.password.length > 5) ? '' : 'Sifreniz en az 6 haneli olmali'
    },
    password2() {
      this.onceFilledInPwd2 = true
      this.password2Error = (this.password2 && this.password2 === this.password) ? '' : 'Sifreleriniz birbiriyle uyusmuyor'
    }
  }
}
