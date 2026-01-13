<template>
    <div class="feedback-page page">
        <div class="feedback-hero">
            <div class="feedback-hero__head">
                <div class="feedback-logos">
                    <img src="@/assets/vision_tree_logo.png" alt="Vision Tree Logo" class="logo logo--vt">
                    <img src="@/assets/burada_logo.png" alt="Burada Logo" class="logo logo--burada">
                </div>

                <div class="feedback-hero__texts mt-2">
                    <div class="feedback-hero__title">{{ title || $t('components.feedback.title') }}</div>
                    <div class="feedback-hero__sub">{{ subtitle || $t('components.feedback.sub') }}</div>
                </div>

                <div class="feedback-hero__tag mt-2" aria-label="Yanıt süresi etiketi">
                    <i class="fas fa-comment-dots"></i>
                    <span>{{ pillText || $t('components.feedback.pill') }}</span>
                </div>
            </div>
        </div>

        <div class="feedback-card">
            <div class="feedback-card__title">
                <i class="fas fa-paper-plane"></i>
                <span>{{ $t('components.feedback.writeMessage') }}</span>
            </div>

            <form @submit.prevent="submitFeedback">
                <div class="field">
                    <label class="field__label">{{ $t('components.feedback.subjects.label') }}</label>
                    <el-select v-model="form.type" class="field__el" :placeholder="$t('components.feedback.subjects.placeholder')" size="large"
                        popper-class="vt-popper">
                        <el-option :label="$t('components.feedback.subjects.general')" value="general" />
                        <el-option :label="$t('components.feedback.subjects.bug')" value="bug" />
                        <el-option :label="$t('components.feedback.subjects.suggestion')" value="suggestion" />
                        <el-option :label="$t('components.feedback.subjects.business_claim')" value="business_claim" />
                        <el-option :label="$t('components.feedback.subjects.profile_delete')" value="profile_delete" />
                    </el-select>
                </div>

                <div class="field">
                    <label class="field__label">{{ $t('components.feedback.emailLabel') }}</label>
                    <input class="field__control" type="email" v-model="form.email" placeholder="mail@..."
                        autocomplete="email" />
                </div>

                <div class="field">
                    <label class="field__label">{{ $t('components.feedback.messageLabel') }}</label>
                    <textarea class="field__control field__control--textarea" v-model="form.message" :maxlength="maxLen"
                        rows="6"
                        :placeholder="$t('components.feedback.messagePlaceholder')" />
                    <div class="field__meta">
                        <span class="field__hint">{{ hintText }}</span>
                        <span class="field__count">{{ (form.message || '').length }} / {{ maxLen }}</span>
                    </div>
                </div>

                <div class="actions">
                    <button class="btn btn--primary" type="submit" :disabled="loading || !canSend">
                        <span v-if="!loading"><i class="fas fa-paper-plane me-2"></i> {{ $t('components.feedback.send') }}</span>
                        <span v-else><i class="fas fa-spinner fa-spin me-2"></i> {{ $t('components.feedback.sending') }}</span>
                    </button>

                    <button class="btn btn--ghost" type="button" @click="resetForm" :disabled="loading">
                        {{ $t('components.feedback.cancel') }}
                    </button>
                </div>

                <div v-if="success" class="success">
                    <i class="fas fa-check-circle"></i>
                    <span>{{ $t('components.feedback.success') }}</span>
                </div>
            </form>
        </div>

        <div class="feedback-mini">
            <div class="feedback-mini__title">{{ $t('components.feedback.tipTitle') }}</div>
            <div class="feedback-mini__sub">
                {{ $t('components.feedback.tipText') }}
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "SupportUs", // route adı değişmesin diye aynı bıraktım, istersen Feedback yap
    props: {
        title: { type: String, default: "" },
        subtitle: {
            type: String,
            default: "",
        },
        pillText: { type: String, default: "" },
    },
    data() {
        return {
            loading: false,
            success: false,
            maxLen: 800,
            form: {
                type: "general",
                email: "",
                message: "",
            },
        };
    },
    computed: {
        canSend() {
            return (this.form.message || "").trim().length >= 5;
        },
        hintText() {
            if (this.form.type === "bug") return this.$t('components.feedback.hint.bug');
            if (this.form.type === "suggestion") return this.$t('components.feedback.hint.suggestion');
            return this.$t('components.feedback.hint.general');
        },
    },
    methods: {
        resetForm() {
            this.success = false;
            this.form = { type: "general", email: "", message: "" };
        },

        async submitFeedback() {
            this.success = false;

            const msg = (this.form.message || "").trim();
            if (msg.length < 5) {
                this.$message?.error
                    ? this.$message.error("Mesaj çok kısa. Biraz daha detay ver.")
                    : alert("Mesaj çok kısa. Biraz daha detay ver.");
                return;
            }

            // İstersen context ekle: route, user agent vs
            const context = {
                route: this.$route?.name || "",
                path: this.$route?.fullPath || "",
            };

            const payloadMsg =
                `Type: ${this.form.type}\n` +
                (this.form.email ? `Email: ${this.form.email}\n` : "") +
                `Context: ${JSON.stringify(context)}\n\n` +
                msg;

            this.loading = true;
            try {
                await this.$store.dispatch("createFeedback", {
                    type: this.form.type,
                    message: payloadMsg,
                });

                this.success = true;
                this.$message?.success ? this.$message.success("Gönderildi.") : null;
                this.resetForm();
                this.success = true;
            } catch (e) {
                this.$message?.error
                    ? this.$message.error("Gönderilemedi. Bir daha dene.")
                    : alert("Gönderilemedi. Bir daha dene.");
            } finally {
                this.loading = false;
            }
        },
    },
};
</script>

<style scoped>
.feedback-page {
    padding: 14px 14px 24px;
    background: #f7f7fb;
    min-height: 100vh;
    padding-bottom: 10em;
}

.feedback-hero {
    padding: 14px 14px 12px;
    border-radius: 18px;
    background: #ffffff;
    border: 1px solid rgba(15, 23, 42, 0.08);
    box-shadow: 0 10px 28px rgba(15, 23, 42, 0.06);
    margin-bottom: 12px;
}

.feedback-hero__head {
    display: inline-block;
}

.feedback-logos {
    display: flex;
    align-items: center;
    gap: 10px;
}

.logo {
    display: block;
    height: 44px;
    object-fit: contain;
}

.logo--vt {
    height: 48px;
}

.logo--burada {
    height: 36px;
    opacity: 0.95;
}

.feedback-hero__texts {
    min-width: 0;
    padding-top: 6px;
}

.feedback-hero__title {
    font-size: 18px;
    font-weight: 800;
    letter-spacing: -0.2px;
    color: #0f172a;
    line-height: 1.2;
    margin-bottom: 6px;
}

.feedback-hero__sub {
    font-size: 13px;
    line-height: 1.55;
    color: rgba(15, 23, 42, 0.78);
    max-width: 60ch;
    word-break: break-word;
}

.feedback-hero__tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    flex-shrink: 0;
    padding: 8px 10px;
    border-radius: 999px;
    margin-top: 10px;
    background: rgba(37, 99, 235, 0.08);
    border: 1px solid rgba(37, 99, 235, 0.18);
    color: rgba(30, 64, 175, 0.95);
    font-size: 12px;
    font-weight: 800;
    line-height: 1;
    user-select: none;
}

.feedback-card {
    background: #fff;
    border-radius: 18px;
    padding: 14px;
    box-shadow: 0 10px 22px rgba(17, 24, 39, 0.07);
    border: 1px solid rgba(17, 24, 39, 0.06);
}

.feedback-card__title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 12px;
    color: #111827;
}

.field {
    margin-top: 12px;
}

.field__label {
    display: block;
    font-size: 12px;
    font-weight: 800;
    color: rgba(17, 24, 39, 0.75);
    margin-bottom: 6px;
}

.field__control {
    width: 100%;
    border-radius: 14px;
    border: 1px solid rgba(17, 24, 39, 0.10);
    background: #fff;
    padding: 12px 12px;
    outline: none;
    font-size: 14px;
    color: #111827;
}

.field__control--textarea {
    resize: vertical;
    min-height: 120px;
}

.field__control:focus {
    border-color: rgba(37, 99, 235, 0.55);
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
}

.field__meta {
    margin-top: 6px;
    display: flex;
    justify-content: space-between;
    gap: 10px;
    font-size: 12px;
    color: rgba(17, 24, 39, 0.55);
}

.actions {
    display: flex;
    gap: 10px;
    margin-top: 14px;
}

.btn {
    border: 0;
    outline: 0;
    cursor: pointer;
    border-radius: 14px;
    padding: 12px 12px;
    font-weight: 900;
    width: 50%;
    transition: transform 0.05s ease, opacity 0.15s ease, box-shadow 0.15s ease;
}

.btn:active {
    transform: scale(0.99);
}

.btn--primary {
    background: linear-gradient(135deg, #4a89dc, #2563eb);
    color: #fff;
    box-shadow: 0 10px 18px rgba(37, 99, 235, 0.18);
}

.btn--ghost {
    background: #f3f4f6;
    color: #111827;
    border: 1px solid rgba(17, 24, 39, 0.08);
}

.btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.success {
    margin-top: 12px;
    border-radius: 16px;
    padding: 12px;
    background: rgba(22, 163, 74, 0.08);
    border: 1px solid rgba(22, 163, 74, 0.18);
    color: rgba(21, 128, 61, 0.95);
    display: flex;
    gap: 10px;
    align-items: center;
    font-weight: 800;
    font-size: 12px;
}

.feedback-mini {
    margin-top: 12px;
    background: #fff;
    border-radius: 18px;
    padding: 14px;
    box-shadow: 0 10px 22px rgba(17, 24, 39, 0.06);
    border: 1px solid rgba(17, 24, 39, 0.06);
}

.feedback-mini__title {
    font-size: 13px;
    font-weight: 900;
    color: #111827;
}

.feedback-mini__sub {
    font-size: 12px;
    color: rgba(17, 24, 39, 0.65);
    margin-top: 4px;
    line-height: 1.5;
}
</style>