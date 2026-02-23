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
