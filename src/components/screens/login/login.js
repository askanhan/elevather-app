import { Browser } from '@capacitor/browser'
import { Capacitor } from '@capacitor/core'
import * as globalTypes from '@/store/mutation-types'
import Footer from '@/components/complementarities/footer/footer.vue'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')
import { auth, googleProvider } from '@/firebase'
import { signInWithPopup, signInWithRedirect, getRedirectResult } from 'firebase/auth'
import Vue from 'vue'
import { SignInWithApple } from '@capacitor-community/apple-sign-in'
import axios from 'axios'
import { Preferences } from '@capacitor/preferences'

export default {

  name: 'Login',
  components: {
    Footer
  },
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      email: '',
      password: ''
    }
  },

  computed: { // cached and changed only if one of its dependencies is changed
  },
  created() {
  },
  mounted() { },
  methods: {

    validateEmail(email) {
      let re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(String(email).toLowerCase())
    },
    login() {
      try {
        const inputEmail = (this.email || '').trim().toLowerCase()
        const inputPwd = (this.password || '')

        if (!inputEmail) {
          alert('E-posta gir.')
          return
        }
        if (!this.validateEmail(inputEmail)) {
          alert('Geçerli bir e-posta gir.')
          return
        }

        // 1) localStorage'de possible kayıtları bul
        let storedUser = null

        // Option A: birden fazla kullanıcı saklanmış olabilir (registeredUsers)
        const usersJson = localStorage.getItem('registeredUsers')
        if (usersJson) {
          try {
            const users = JSON.parse(usersJson)
            if (Array.isArray(users)) {
              storedUser = users.find(u => u.email && u.email.toLowerCase() === inputEmail) || null
            }
          } catch (e) {
            // parse hatası yut
            console.warn('registeredUsers parse hatası', e)
          }
        }

        // Option B: tek bir pendingUser varsa ona bak
        if (!storedUser) {
          const pendingJson = localStorage.getItem('pendingUser')
          if (pendingJson) {
            try {
              const p = JSON.parse(pendingJson)
              if (p && p.email && p.email.toLowerCase() === inputEmail) storedUser = p
            } catch (e) { /* yut */ }
          }
        }

        // Eğer kayıt yoksa: girişe izin verme
        if (!storedUser) {
          alert('Bu e-posta ile kayıt bulunamadı. Lütfen önce kayıt olun.')
          return
        }

        // Eğer storedUser içinde password alanı varsa şifre kontrolü yap
        const storedPwd = storedUser.password || storedUser.pwd || null
        const enforcePasswordCheck = true // eğer istersen false yapabilirsin (ama güvenlik için true bırak)

        if (enforcePasswordCheck && storedPwd) {
          if (storedPwd !== inputPwd) {
            alert('Şifre yanlış.')
            return
          }
        }
        // Eğer storedPwd yoksa (kayıtta parola yoksa) parola kontrolünü atlıyoruz.

        // Hepsi tamam: sahte token + user sakla ve yönlendir
        const fakeToken = 'local-' + Date.now()
        try {
          localStorage.setItem('auth_token', fakeToken)
          // user objesini temizleyip sakla (parolayı saklamaya gerek yok)
          const safeUser = Object.assign({}, storedUser)
          if (safeUser.password) delete safeUser.password
          if (safeUser.pwd) delete safeUser.pwd
          localStorage.setItem('user', JSON.stringify(safeUser))
        } catch (e) {
          console.warn('localStorage yazma hatası', e)
        }

        // Store commit dene ama dispatch'ı çağırma (action.js tetiklenmez)
        try {
          if (this.$store && typeof this.$store.commit === 'function') {
            try { this.$store.commit('SET_USER', storedUser) } catch (e) { }
          }
        } catch (e) { /* ignore */ }

        // Yönlendir
        if (this.$router && typeof this.$router.push === 'function') {
          this.$router.push({ name: 'home' }).catch(() => { })
        }
      } catch (err) {
        console.error('login fallback hata:', err)
        alert('Beklenmeyen hata. Konsola bak.')
      }
    },

    async appleLogin() {
      try {
        console.log('[apple] start');

        const res = await SignInWithApple.authorize({
          clientId: 'be.visiontree.burada',
          redirectURI: 'https://api.burada.be/auth/apple/callback',
          scopes: 'email name',
          state: String(Date.now()),
          nonce: String(Math.random()).slice(2),
        });

        console.log('[apple] authorize res:', res);

        const idToken = res?.response?.identityToken;
        console.log('[apple] idToken exists?', !!idToken);

        if (!idToken) throw new Error('No identityToken from Apple');

        // ÖNEMLİ: relative url yerine kesin baseURL kullan (özellikle iOS’ta)
        const api = this.$store.state.serverLocation.replace(/\/+$/, '')
        console.log('[apple] api base:', api);

        const url = `${api}/auth/apple/mobile`;
        console.log('[apple] posting to:', url);

        const r = await axios.post(url, { id_token: idToken })
        console.log('[apple] backend ok:', r.status, r.data)

        // ✅ Google gibi: afterlogin ekranına “session” bırak
        await Preferences.set({
          key: 'session',
          value: JSON.stringify(r.data)   // {access, refresh, user}
        })

        // ✅ aynı pipeline’ı çalıştır
        this.$router.replace({ name: 'afterlogin' })

        return r.data
      } catch (e) {
        console.error('[apple] FAILED:', e?.message || e, e);
        // axios error detail
        if (e?.response) console.error('[apple] axios response:', e.response.status, e.response.data);
        throw e;
      }
    },


    async googleLogin() {
      const api = this.$store.state.serverLocation.replace(/\/+$/, '')

      const isNative =
        (Capacitor?.getPlatform && Capacitor.getPlatform() !== 'web') ||
        !!window.cordova

      const appRedirect = isNative
        ? 'burada://afterlogin'
        : `${window.location.origin}/#/afterlogin`   // localhost yok

      const next = encodeURIComponent(
        `/auth/sessionLogin?redirect=${encodeURIComponent(appRedirect)}`
      )

      const url = `${api}/accounts/google/login/?process=login&next=${next}`

      await Browser.open({ url })
    }
  }
}