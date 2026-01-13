<template>
  <div class="page hr-page">
    <div class="hr-card">
      <div class="hr-head">
        <div class="hr-title">{{ $t('components.highlightRequest.title') }}</div>
        <div class="hr-sub">
          {{ $t('components.highlightRequest.sub') }}
        </div>
      </div>

      <div v-if="!hasAnyBusiness" class="hr-empty">
        <div class="hr-empty-title">{{ $t('components.highlightRequest.emptyTitle') }}</div>
        <div class="hr-empty-sub">{{ $t('components.highlightRequest.emptySub') }}</div>
        <button type="button" class="hr-btn" @click="goToMyProfile">{{ $t('components.highlightRequest.goToProfile') }}</button>
      </div>

      <form v-else class="hr-form" @submit.prevent="submit">
        <!-- İşletme seçici (native select yok) -->
        <label class="hr-label">{{ $t('components.highlightRequest.labelBusiness') }}</label>

        <div class="hr-pick" ref="bizPick">
          <button type="button" class="hr-pick-btn" @click="bizOpen = !bizOpen"
            :aria-expanded="bizOpen ? 'true' : 'false'">
            <span class="hr-pick-text">
              {{ selectedBusinessLabel }}
            </span>
            <span class="hr-pick-caret">▾</span>
          </button>

          <div v-show="bizOpen" class="hr-pick-panel">
            <button v-for="b in myBusinesses" :key="b.id" type="button" class="hr-pick-item" @click="selectBusiness(b)">
              <span class="hr-pick-name">{{ b.name || ('İşletme #' + b.id) }}</span>
            </button>
          </div>
        </div>

        <label class="hr-label">{{ $t('components.highlightRequest.labelDesc') }}</label>
        <textarea class="hr-textarea" v-model.trim="form.message" rows="3" maxlength="280"
          :placeholder="$t('components.highlightRequest.placeholderDesc')" required></textarea>
        <div class="hr-hint">{{ (form.message || '').length }}/280</div>

        <label class="hr-label">{{ $t('components.highlightRequest.labelContact') }}</label>
        <input class="hr-input" v-model.trim="form.contact" :placeholder="$t('components.highlightRequest.placeholderContact')" maxlength="80" />

        <button type="submit" class="hr-btn" :disabled="sending || !canSubmit">
          <span v-if="!sending">{{ $t('components.highlightRequest.btnSend') }}</span>
          <span v-else>{{ $t('components.highlightRequest.btnSending') }}</span>
        </button>

        <div v-if="success" class="hr-ok">{{ $t('components.highlightRequest.success') }}</div>
        <div v-if="error" class="hr-err">{{ error }}</div>

        <div class="hr-footnote">
          {{ $t('components.highlightRequest.note') }}
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "HighlightRequest",

  data() {
    return {
      bizOpen: false,
      sending: false,
      success: false,
      error: "",
      form: {
        business_id: "",
        message: "",
        contact: "",
      },
    };
  },

  computed: {
    selectedBusinessLabel() {
      const id = Number(this.form.business_id)
      const b = this.myBusinesses.find(x => Number(x.id) === id)
      return b ? (b.name || ("İşletme #" + b.id)) : this.$t('components.highlightRequest.select')
    },
    myProfile() {
      return this.$store.state.myProfile || null;
    },
    myBusinesses() {
      const arr = this.$store.state.myBusinesses || [];
      return Array.isArray(arr) ? arr : [];
    },
    hasAnyBusiness() {
      return this.myBusinesses.length > 0;
    },
    canSubmit() {
      return !!(String(this.form.business_id || "").length && String(this.form.message || "").trim().length >= 10);
    },
  },

  mounted() {
    // tek işletmesi varsa otomatik seç
    if (this.myBusinesses.length === 1) {
      this.form.business_id = this.myBusinesses[0].id;
    }
    this._onDocClick = (e) => {
      const root = this.$refs.bizPick
      if (!root) return
      if (!root.contains(e.target)) this.bizOpen = false
    }
    document.addEventListener("click", this._onDocClick)
  },

  beforeUnmount() {
    if (this._onDocClick) document.removeEventListener("click", this._onDocClick)
    this._onDocClick = null
  },

  methods: {
    selectBusiness(b) {
      this.form.business_id = b.id
      this.bizOpen = false
    },
    goToMyProfile() {
      const id = this.myProfile?.id || this.myProfile?.p_id;
      if (id) this.$router.push({ name: "profile", params: { profileID: id } });
      else this.$router.push({ name: "profile" });
    },

    async submit() {
      if (this.sending || !this.canSubmit) return;

      this.sending = true;
      this.success = false;
      this.error = "";

      const payload = {
        business_id: Number(this.form.business_id),
        message: String(this.form.message || "").trim(),
        contact: String(this.form.contact || "").trim() || null,
        source: "highlight_request_form",
      };

      try {
        // ✅ action adı senin store’da: HighlightRequest
        await this.$store.dispatch("HighlightRequest", payload);

        // ✅ kullanıcıya mesaj
        this.$message?.success?.("Talebin ulaştı. Teşekkürler!");

        // ✅ formu temizle (işletme seçimi kalsın)
        this.form.message = "";
        this.form.contact = "";

        // ✅ geri dön
        this.$router.back();
      } catch (e) {
        console.error("HighlightRequest failed", e);
        this.error = "Talep gönderilemedi. Lütfen tekrar dene.";
        this.$message?.error?.(this.error);
      } finally {
        this.sending = false;
      }
    },
  },
};
</script>

<style scoped>
.hr-page {
  padding: 86px 12px 14px;
}

.hr-card {
  background: #fff;
  border-radius: 18px;
  box-shadow: 0 10px 26px rgba(15, 23, 42, 0.08);
  border: 1px solid #eef2f7;
  padding: 14px;
  max-width: 560px;
  margin: 0 auto;
}

.hr-head {
  margin-bottom: 12px;
}

.hr-title {
  font-size: 18px;
  font-weight: 900;
  color: #0f172a;
}

.hr-sub {
  margin-top: 6px;
  font-size: 12.5px;
  color: #64748b;
  line-height: 1.35;
}

.hr-form {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.hr-label {
  font-size: 12px;
  font-weight: 800;
  color: #0f172a;
  margin-top: 6px;
}

.hr-input,
.hr-select,
.hr-textarea {
  width: 100%;
  border-radius: 14px;
  border: 1px solid #e5e7eb;
  padding: 10px 12px;
  font-size: 13px;
  outline: none;
  background: #fff;
}

.hr-textarea {
  resize: none;
}

.hr-input:focus,
.hr-select:focus,
.hr-textarea:focus {
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.14);
}

.hr-hint {
  font-size: 11px;
  color: #94a3b8;
  text-align: right;
  margin-top: -4px;
}

.hr-btn {
  margin-top: 10px;
  border: 0;
  border-radius: 999px;
  padding: 10px 12px;
  font-weight: 900;
  font-size: 13px;
  color: #fff;
  background: #2563eb;
  cursor: pointer;
}

.hr-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.hr-ok {
  margin-top: 10px;
  background: #ecfdf5;
  border: 1px solid #a7f3d0;
  color: #065f46;
  padding: 10px 12px;
  border-radius: 14px;
  font-size: 13px;
  font-weight: 700;
}

.hr-err {
  margin-top: 10px;
  background: #fef2f2;
  border: 1px solid #fecaca;
  color: #991b1b;
  padding: 10px 12px;
  border-radius: 14px;
  font-size: 13px;
  font-weight: 700;
}

.hr-footnote {
  margin-top: 10px;
  font-size: 11.5px;
  color: #64748b;
  line-height: 1.35;
}

.hr-empty {
  padding: 12px;
  border-radius: 14px;
  background: #f8fafc;
  border: 1px dashed #cbd5e1;
}

.hr-empty-title {
  font-weight: 900;
  color: #0f172a;
}

.hr-empty-sub {
  margin-top: 6px;
  color: #64748b;
  font-size: 13px;
}

.hr-pick {
  position: relative;
}

.hr-pick-btn {
  width: 100%;
  border-radius: 14px;
  border: 1px solid #e5e7eb;
  padding: 10px 12px;
  font-size: 13px;
  background: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.hr-pick-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  text-align: left;
  color: #0f172a;
  font-weight: 700;
}

.hr-pick-caret {
  opacity: .7;
}

.hr-pick-panel {
  position: absolute;
  left: 0;
  right: 0;
  top: calc(100% + 8px);
  z-index: 50;
  background: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  box-shadow: 0 18px 40px rgba(15, 23, 42, 0.14);
  padding: 6px;
  max-height: 240px;
  overflow: auto;
}

.hr-pick-item {
  width: 100%;
  border: 0;
  background: transparent;
  padding: 10px 10px;
  border-radius: 12px;
  text-align: left;
  cursor: pointer;
}

.hr-pick-item:active {
  transform: scale(0.99);
}

.hr-pick-item:hover {
  background: rgba(37, 99, 235, 0.08);
}

:global(body.dark-mode) .hr-pick-btn {
  background: #111827;
  border-color: #1f2937;
}

:global(body.dark-mode) .hr-pick-panel {
  background: #111827;
  border-color: #1f2937;
}

:global(body.dark-mode) .hr-pick-text {
  color: #e5e7eb;
}
</style>