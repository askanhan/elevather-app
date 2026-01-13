/* import * as globalTypes from '@/store/mutation-types'
import Footer from '@/components/complementarities/footer/footer.vue'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
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
      // eslint-disable-next-line 
      let re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(String(email).toLowerCase())
    },
    login() {
      this.$store.dispatch({
        type: 'login',
        email: this.email,
        password: this.password,
        successCB: (res) => {
          this.$router.push({
            name: 'home'
          })
        }
      })
    }
  },
  watch: {}
}*/

import * as globalTypes from '@/store/mutation-types'
import Footer from '@/components/complementarities/footer/footer.vue'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')
import { auth, googleProvider } from '@/firebase'
import { signInWithPopup, signInWithRedirect, getRedirectResult } from 'firebase/auth'
import googleIcon from '@/assets/google-icon.svg'
import appleIcon from '@/assets/apple-icon.svg'
import Vue from 'vue'

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
          try { this.$store.commit('SET_USER', storedUser) } catch(e){}
        }
      } catch (e) { /* ignore */ }

      // Yönlendir
      if (this.$router && typeof this.$router.push === 'function') {
        this.$router.push({ name: 'home' }).catch(()=>{})
      }
    } catch (err) {
      console.error('login fallback hata:', err)
      alert('Beklenmeyen hata. Konsola bak.')
    }
  },

  // --------- BURAYA TEK GOOGLE METODU EKLENDI ----------
  async googleLogin() {
    try {
      // popup dene
      const result = await signInWithPopup(auth, googleProvider)
      const user = result.user
      if (!user) {
        alert('Google ile giriş başarısız.')
        return
      }
      const idToken = await user.getIdToken()

      // localStorage kaydet
      try {
        localStorage.setItem('auth_token', idToken)
        localStorage.setItem('user', JSON.stringify({
          uid: user.uid,
          email: user.email,
          name: user.displayName || (user.email && user.email.split('@')[0]) || 'GoogleUser',
          photo: user.photoURL || null,
          provider: 'google'
        }))
      } catch (e) {
        console.warn('localStorage yazma hatası (googleLogin):', e)
      }

      // store güncelle (commit kullanıyorum, dispatch çağırmıyorum)
      try {
        if (this.$store && typeof this.$store.commit === 'function') {
          try { this.$store.commit('SET_USER', { uid: user.uid, email: user.email, name: user.displayName }) } catch(e){}
        }
      } catch (e) { /* ignore */ }

      // yönlendir
      if (this.$router && typeof this.$router.push === 'function') {
        this.$router.push({ name: 'home' }).catch(()=>{})
      }
    } catch (err) {
      console.error('googleLogin hata:', err)
      // popup-blocked gibi hatalarda redirect fallback deneyebilirsin
      if (err && (err.code === 'auth/popup-blocked' || err.code === 'auth/cancelled-popup-request')) {
        try {
          await signInWithRedirect(auth, googleProvider)
        } catch (e) {
          console.error('signInWithRedirect hata:', e)
          alert('Google ile giriş yapılamadı.')
        }
      } else if (err && err.code === 'auth/unauthorized-domain') {
        alert('Yetkili domain tanımlı değil. Firebase Console -> Auth -> Authorized domains kısmına domain ekle.')
      } else {
        alert('Google ile giriş başarısız: ' + (err.message || err.code || 'Bilinmeyen hata'))
      }
    }
  }
}
}