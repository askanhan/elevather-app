<template>
    <div class="support-page page">
        <div class="support-hero">
            <div class="support-hero__head">
                <img src="@/assets/vision_tree_logo.png" width="70%" alt="Vision Tree Logo" class="login-logo">
                <img src="@/assets/burada_logo.png" width="30%" alt="Burada Logo" class="login-logo">

                <div class="support-hero__texts mt-2">
                    <div class="support-hero__title">{{ title || $t('components.donate.title') }}</div>
                    <div class="support-hero__sub">{{ subtitle || $t('components.donate.sub') }}</div>
                </div>

                <div class="support-hero__tag mt-2" aria-label="Gönüllü destek etiketi" style="margin-left: auto;">
                    <i class="fas fa-heart"></i>
                    <span>{{ pillText || $t('components.donate.pill') }}</span>
                </div>
            </div>
        </div>

        <div class="support-card">
            <div class="support-card__title">
                <i class="fas fa-hand-holding-heart"></i>
                <span>{{ $t('components.donate.optionsTitle') }}</span>
            </div>

            <button class="support-btn support-btn--primary" type="button" @click="openDonation">
                <span class="support-btn__left">
                    <i class="fas fa-globe"></i>
                    <span>{{ $t('components.donate.webDonate') }}</span>
                </span>
                <i class="fas fa-arrow-right"></i>
            </button>

            <div class="support-iban">
                <div class="support-iban__label">IBAN</div>
                <div class="support-iban__row">
                    <div class="support-iban__value" :title="iban">{{ iban }}</div>
                    <button class="support-btn support-btn--ghost" type="button" @click="copyIban">
                        <i class="far fa-copy"></i>
                        <span>{{ $t('components.donate.copy') }}</span>
                    </button>
                </div>
                <div v-if="orgLegalName" class="support-iban__name">
                    {{ $t('components.donate.receiver') }} {{ orgLegalName }}
                </div>
            </div>

            <div class="support-note">
                <i class="fas fa-shield-alt"></i>
                <span>{{ $t('components.donate.secureNote') }}</span>
            </div>
        </div>

        <div class="support-mini">
            <div class="support-mini__title">{{ $t('components.donate.shareTitle') }}</div>
            <div class="support-mini__sub">{{ $t('components.donate.shareSub') }}</div>

            <div class="support-mini__actions">
                <button class="support-btn support-btn--soft" type="button" @click="shareLink">
                    <i class="fas fa-share-alt"></i>
                    <span>{{ $t('components.donate.shareBtn') }}</span>
                </button>

                <button class="support-btn support-btn--soft" type="button" @click="copyDonationLink">
                    <i class="fas fa-link"></i>
                    <span>{{ $t('components.donate.copyLink') }}</span>
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'

export default {
    name: 'SupportUs',
    components: { ProfileAvatar },

    data() {
        return {
            donationUrl: 'https://visiontree.be/steun-ons/',
            iban: 'BE37 7340 7548 7328',
            orgPhoto: 'https://visiontree.be/assets/images/about/vision-tree-circle.png',
            orgName: 'Vision Tree',
        }
    },

    props: {
        orgLegalName: { type: String, default: '' },
        title: { type: String, default: '' },
        subtitle: { type: String, default: '' },
        pillText: { type: String, default: '' },
    },

    methods: {
        openDonation() {
            // Mobil webview/Cordova/Capacitor fark etmeksizin çoğu ortamda çalışır
            // Eğer InAppBrowser kullanıyorsan burada onu çağırabilirsin.
            try {
                window.open(this.donationUrl, '_blank')
            } catch (e) {
                // fallback
                window.location.href = this.donationUrl
            }
        },

        async copyIban() {
            if (!this.iban) return
            await this.copyText(this.iban, this.$t('common.linkCopied').replace('Link', 'IBAN'))
        },

        async copyDonationLink() {
            await this.copyText(this.donationUrl, this.$t('common.linkCopied'))
        },

        async shareLink() {
            const text = `${this.orgName} destek linki: ${this.donationUrl}`
            try {
                if (navigator.share) {
                    await navigator.share({ title: this.orgName, text, url: this.donationUrl })
                    return
                }
            } catch (e) {
                // share iptal vs.
            }
            await this.copyText(this.donationUrl, 'Paylaşım için link kopyalandı')
        },

        async copyText(value, okMsg) {
            try {
                if (navigator.clipboard?.writeText) {
                    await navigator.clipboard.writeText(value)
                } else {
                    const ta = document.createElement('textarea')
                    ta.value = value
                    ta.setAttribute('readonly', '')
                    ta.style.position = 'absolute'
                    ta.style.left = '-9999px'
                    document.body.appendChild(ta)
                    ta.select()
                    document.execCommand('copy')
                    document.body.removeChild(ta)
                }
                this.notify(okMsg)
            } catch (e) {
                this.notify(this.$t('components.donate.copy') + ' başarisiz') // Simple fallback
            }
        },

        notify(msg) {
            // projende hangisi varsa onu kullanır
            if (this.$message?.success) return this.$message.success(msg)
            if (this.$toast) return this.$toast(msg)
            // çok mecbur kalırsak:
            // eslint-disable-next-line no-alert
            alert(msg)
        },
    },
}
</script>

<style scoped>
.support-page {
    padding: 14px 14px 24px;
    background: #f7f7fb;
    min-height: 100vh;
    padding-bottom: 10em;
}

.support-hero {
    background: radial-gradient(1200px 400px at 20% 0%, rgba(74, 137, 220, .25), transparent 60%),
        radial-gradient(1200px 400px at 80% 0%, rgba(22, 163, 74, .20), transparent 55%),
        #111827;
    border-radius: 18px;
    padding: 14px;
    color: #fff;
    box-shadow: 0 10px 24px rgba(0, 0, 0, .18);
    margin-bottom: 12px;
}

.support-hero__top {
    display: flex;
    gap: 12px;
    align-items: center;
}

.support-hero__texts {
    min-width: 0;
}

.support-hero__title {
    font-size: 16px;
    font-weight: 800;
    letter-spacing: .2px;
}

.support-hero__sub {
    font-size: 13px;
    opacity: .86;
    margin-top: 2px;
}

.support-hero__pill {
    margin-top: 12px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(255, 255, 255, .12);
    border: 1px solid rgba(255, 255, 255, .16);
    padding: 8px 10px;
    border-radius: 999px;
    font-size: 12px;
    opacity: .95;
}

.support-card {
    background: #fff;
    border-radius: 18px;
    padding: 14px;
    box-shadow: 0 10px 22px rgba(17, 24, 39, .07);
    border: 1px solid rgba(17, 24, 39, .06);
}

.support-card__title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 800;
    font-size: 13px;
    margin-bottom: 10px;
    color: #111827;
}

.support-btn {
    width: 100%;
    border: 0;
    outline: 0;
    cursor: pointer;
    border-radius: 14px;
    padding: 12px 12px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 700;
    transition: transform .05s ease, opacity .15s ease, box-shadow .15s ease;
}

.support-btn:active {
    transform: scale(.99);
}

.support-btn__left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.support-btn--primary {
    background: linear-gradient(135deg, #4a89dc, #2563eb);
    color: #fff;
    box-shadow: 0 10px 18px rgba(37, 99, 235, .18);
}

.support-btn--ghost {
    width: auto;
    padding: 10px 10px;
    background: #f3f4f6;
    color: #111827;
    border: 1px solid rgba(17, 24, 39, .08);
    gap: 8px;
}

.support-btn--soft {
    background: #f3f4f6;
    color: #111827;
    border: 1px solid rgba(17, 24, 39, .08);
    justify-content: center;
    gap: 10px;
}

.support-iban {
    margin-top: 12px;
    background: #fafafa;
    border: 1px dashed rgba(17, 24, 39, .18);
    border-radius: 16px;
    padding: 12px;
}

.support-iban__label {
    font-size: 11px;
    font-weight: 800;
    color: rgba(17, 24, 39, .65);
}

.support-iban__row {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-top: 8px;
}

.support-iban__value {
    flex: 1;
    font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
    font-size: 12px;
    color: #111827;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.support-iban__name {
    margin-top: 8px;
    font-size: 12px;
    color: rgba(17, 24, 39, .7);
}

.support-note {
    margin-top: 12px;
    display: flex;
    gap: 10px;
    align-items: flex-start;
    font-size: 12px;
    color: rgba(17, 24, 39, .70);
}

.support-mini {
    margin-top: 12px;
    background: #fff;
    border-radius: 18px;
    padding: 14px;
    box-shadow: 0 10px 22px rgba(17, 24, 39, .06);
    border: 1px solid rgba(17, 24, 39, .06);
}

.support-mini__title {
    font-size: 13px;
    font-weight: 900;
    color: #111827;
}

.support-mini__sub {
    font-size: 12px;
    color: rgba(17, 24, 39, .65);
    margin-top: 4px;
}

.support-mini__actions {
    display: flex;
    gap: 10px;
    margin-top: 12px;
}

.support-mini__actions .support-btn {
    width: 50%;
}

.support-hero{
  padding: 14px 14px 12px;
  border-radius: 18px;
  background: #ffffff;
  border: 1px solid rgba(15, 23, 42, 0.08);
  box-shadow: 0 10px 28px rgba(15, 23, 42, 0.06);
}

.support-hero__head{
  display: inline-block;
  align-items: flex-start;
  gap: 12px;
}

.support-hero__texts{
  flex: 1;
  min-width: 0;
  padding-top: 2px;
}

.support-hero__title{
  font-size: 18px;
  font-weight: 800;
  letter-spacing: -0.2px;
  color: #0f172a;
  line-height: 1.2;
  margin-bottom: 6px;
}

.support-hero__sub{
  font-size: 13px;
  line-height: 1.55;
  color: rgba(15, 23, 42, 0.78);
  max-width: 46ch;
  word-break: break-word;
}

.support-hero__tag{
  display: inline-flex;
  align-items: center;
  gap: 6px;
  flex-shrink: 0;

  padding: 6px 10px;
  border-radius: 999px;

  background: rgba(239, 68, 68, 0.08);
  border: 1px solid rgba(239, 68, 68, 0.18);

  color: rgba(185, 28, 28, 0.95);
  font-size: 12px;
  font-weight: 700;
  line-height: 1;
  user-select: none;
  cursor: default;
}

.support-hero__tag i{
  font-size: 12px;
  opacity: 0.95;
}

/* küçük ekranlarda etiketi alta al, metin nefes alsın */
@media (max-width: 420px){
  .support-hero__head{
    flex-wrap: wrap;
  }
  .support-hero__tag{
    margin-left: 68px; /* avatar genişliği + gap hissi */
    margin-top: -2px;
  }
  .support-hero__sub{
    max-width: 100%;
  }
}
</style>