<template>
  <div class="al-wrap">
    <div class="al-card">
      <div class="al-logo-row">
        <img v-if="logo" :src="logo" alt="Burada" class="al-logo" />
      </div>

      <div class="al-spinner" aria-hidden="true"></div>

      <h1 class="al-title">
        {{ error ? $t('auth.afterlogin.titleError') : $t('auth.afterlogin.titleLoading') }}
      </h1>

      <p class="al-sub">
        {{
          error
            ? $t('auth.afterlogin.subtitleError')
            : $t('auth.afterlogin.subtitleLoading')
        }}
      </p>

      <div v-if="error" class="al-error">{{ error }}</div>

      <div class="al-actions">
        <button v-if="error" class="al-btn" @click="fetchUser">
          {{ $t('auth.afterlogin.retry') }}
        </button>
        <button v-if="error" class="al-link" @click="goLogin">
          {{ $t('auth.afterlogin.backToLogin') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { Preferences } from '@capacitor/preferences'
import { authStore } from "@/store/auth.js"

export default {
  name: "afterlogin",
  data() {
    return {
      logo: require("@/assets/burada_logo.png"),
      error: null,
      step: this.$t('auth.afterlogin.step.stepCompleting')
    }
  },

  async mounted() {
    try {
      console.log("[AfterLoginPage] mounted")
      // 0) küçük bir bekleme: spinner görünsün
      await new Promise(r => setTimeout(r, 150))

      // 1) session al (native: Preferences, web: hash/query fallback)
      let session = await Preferences.get({ key: "session" })
      session = session?.value || this.readSessionFromUrl()
      console.log("[AfterLoginPage] session:", session)

      if (!session) {
        this.error = this.$t('auth.afterlogin.errNoLoginData')
        console.log("[AfterLoginPage] No session found")
        return
      }

      console.log("[AfterLoginPage] Session found, processing")
      // 2) parse et
      const raw = session.includes('%') ? decodeURIComponent(session) : session
      const data = JSON.parse(raw) // {access, refresh, user}

      this.step = this.$t('auth.afterlogin.step.stepSavingSession')

      // 3) Tokenları app’in beklediği şekilde yaz
      // Interceptor Authorization header’ı window.__ACCESS_TOKEN__ ile basıyor
      window.__ACCESS_TOKEN__ = data.access
      console.log("[AfterLoginPage] Access token set in window")

      authStore.setItem("access", data.access)
      authStore.setItem("refresh", data.refresh)
      authStore.setItem("user", JSON.stringify(data.user))

      // Vuex user state: UI patlamasın
      try { this.$store.commit("USER_LOGGED_IN", data.user) } catch (_) { }

      // 4) Gerçek “init” (SplashScreen’le aynı mantık)
      this.step = this.$t('auth.afterlogin.step.stepLoadingProfile')
      const meOk = await this.$store.dispatch("getUserDetails")

      if (!meOk) {
        // /auth/me patladıysa bir kere refresh dene (gerekirse)
        const refresh = authStore.getItem("refresh")
        if (refresh) {
          this.step = this.$t('auth.afterlogin.step.stepRefreshingSession')
          try { await this.$store.dispatch("refreshAccess", refresh) } catch (_) { }
          this.step = this.$t('auth.afterlogin.step.stepRetryingProfile')
          const meOk2 = await this.$store.dispatch("getUserDetails")
          if (!meOk2) throw new Error(this.$t('auth.afterlogin.errUserDetails'))
        } else {
          throw new Error(this.$t('auth.afterlogin.errUserDetails'))
        }
      }

      console.log("[AfterLoginPage] User details loaded")
      this.step = this.$t('auth.afterlogin.step.stepPreparingApp')
      await this.$store.dispatch("initializeBasicInfo")

      // 5) session tek kullanımlık: temizle
      await Preferences.remove({ key: "session" })

      // 6) home’a geç
      this.step = this.$t('auth.afterlogin.step.stepRedirecting')
      this.$router.replace({ name: "home" })
    } catch (e) {
      console.error(e)
      this.error = e?.message || this.$t('auth.afterlogin.errGeneric')
    }
  },

  methods: {
    readSessionFromUrl() {
      // /afterlogin?session=... veya #/afterlogin?session=...
      const url = new URL(window.location.href)
      const q = url.searchParams.get("session")
      if (q) return q

      const hash = window.location.hash || ""
      const qs = hash.split("?")[1] || ""
      return new URLSearchParams(qs).get("session")
    },

    goLogin() {
      this.$router.replace({ name: "login" })
    }
  }
}
</script>

<style scoped>
.al-wrap {
  min-height: 100vh;
  display: grid;
  place-items: center;
  background: #f7f8fa;
  padding: 24px;
}

.al-card {
  width: 100%;
  max-width: 440px;
  background: #fff;
  border-radius: 16px;
  padding: 28px 24px 32px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
  text-align: center;
}

.al-logo-row {
  margin-bottom: 10px;
}

.al-logo {
  width: 64px;
  height: 64px;
  object-fit: contain;
  opacity: 0.9;
}

.al-title {
  margin: 14px 0 6px;
  font-size: 20px;
  font-weight: 700;
  letter-spacing: 0.2px;
}

.al-sub {
  margin: 0 0 18px;
  color: #6b7280;
  font-size: 14px;
}

.al-spinner {
  margin: 8px auto 6px;
  width: 46px;
  height: 46px;
  border-radius: 50%;
  border: 4px solid #e5e7eb;
  border-top-color: #2563eb;
  animation: spin 0.9s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.al-error {
  background: #fff1f2;
  color: #b91c1c;
  border: 1px solid #fecaca;
  border-radius: 10px;
  padding: 10px 12px;
  font-size: 13px;
  margin-bottom: 14px;
  word-break: break-word;
}

.al-actions {
  display: grid;
  gap: 10px;
}

.al-btn {
  appearance: none;
  border: none;
  background: #2563eb;
  color: #fff;
  font-weight: 600;
  padding: 12px 16px;
  border-radius: 12px;
  cursor: pointer;
}

.al-btn:active {
  transform: translateY(1px);
}

.al-link {
  appearance: none;
  border: none;
  background: transparent;
  color: #374151;
  font-weight: 500;
  cursor: pointer;
  text-decoration: underline;
}
</style>