<template>
  <div class="al-wrap">
    <div class="al-card">
      <div class="al-logo-row">
        <img v-if="logo" :src="logo" alt="ElevateHer" class="al-logo" />
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
      logo: require("@/assets/elevateher_logo.png"),
      error: null,
      step: this.$t('auth.afterlogin.step.stepCompleting')
    }
  },

  async mounted() {
    try {
      await new Promise(r => setTimeout(r, 150))

      let session = await Preferences.get({ key: "session" })
      session = session?.value || this.readSessionFromUrl()

      if (!session) {
        this.error = 'No session data found'
        return
      }

      const raw = session.includes('%') ? decodeURIComponent(session) : session
      const data = JSON.parse(raw)

      if (!data.access) {
        if (data.refresh) {
          await authStore.setItem('refresh', data.refresh)
          try { await this.$store.dispatch("refreshAccess", data.refresh) } catch (_) { }
        } else {
          this.error = 'No tokens in session'
          return
        }
      } else {
        window.__ACCESS_TOKEN__ = data.access
        await authStore.setItem("access", data.access)
        await authStore.setItem("refresh", data.refresh)
        await authStore.setItem("user", JSON.stringify(data.user))
      }

      // user bilgisi zaten session'da var, commit et
      if (data.user) {
        try { this.$store.commit("USER_LOGGED_IN", data.user) } catch (_) { }
        try { this.$store.commit("SET_MY_PROFILE", data.user) } catch (_) { }
      }

      await Preferences.remove({ key: "session" })
      this.$router.replace({ name: "home" })
    } catch (e) {
      this.error = e?.message || 'Unknown error'
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