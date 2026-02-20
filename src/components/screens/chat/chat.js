import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import UIText from '@/mixins/ui-text.js'
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'
import ConfirmDialog from '@/components/complementarities/ConfirmDialog.vue'

export default {
  name: 'Chat',
  mixins: [basicOperations, icons, UIText],
  components: { ProfileAvatar, ConfirmDialog },

  data() {
    return {
      messages: [],
      toBeSentMessage: '',
      isLoading: false,
      isSending: false,
      otherProfileInformation: null,
  
      showBlockConfirm: false,
      showDeleteConfirm: false,
    }
  },

  computed: {
    lang() {
      return this.$store.state.lang
    },

    myProfileId() {
      return this.$store.state?.profile?.p_id ?? this.$store.state?.myProfile?.id ?? 0
    },

    myProfileName() {
      return this.$store.state?.profile?.username || this.$store.state?.myProfile?.username || 'Ben'
    },

    myProfilePhoto() {
      const p = this.$store.state?.profile
      const raw = p?.profile_photo || p?.p_photo_link || p?.p_photo || null
      return this._pPhotoUrl ? this._pPhotoUrl(raw) : raw
    },

    otherProfileId() {
      return this.$route?.params?.profileID ?? null
    },

    otherProfileName() {
      const p = this.otherProfileInformation
      return p?.username || p?.name || 'Kullanıcı'
    },

    otherProfilePhoto() {
      const p = this.otherProfileInformation
      const raw = p?.profile_photo || p?.p_photo_link || p?.p_photo || null
      return this._pPhotoUrl ? this._pPhotoUrl(raw) : raw
    },

    canSend() {
      return !!this.toBeSentMessage.trim() && !this.isSending && !!this.otherProfileId
    },
  },

  created() {
    this.loadChat()
  },

  watch: {
    '$route.fullPath'() {
      this.loadChat()
    },
  },

  methods: {
    confirmBlock() {
      this.showBlockConfirm = true
    },
  
    confirmDeleteConversation() {
      this.showDeleteConfirm = true
    },
  
    async blockUser() {
      const profileID = this.otherProfileId
      await this.$store.dispatch('blockProfile', profileID)
      this.$router.replace({ name: 'conversations' })
    },
  
    async deleteConversation() {
      const profileID = this.otherProfileId
      await this.$store.dispatch('hideConversation', profileID)
      this.$router.replace({ name: 'conversations' })
    },

    async loadChat() {
      this.isLoading = true
      this.messages = []
      this.otherProfileInformation = null

      if (!this.otherProfileId) {
        this.isLoading = false
        return
      }

      try {
        const result = await this.$store.dispatch({
          type: 'getMessagesOfConversation',
          profileId: this.otherProfileId,
        })

        this.messages = Array.isArray(result?.messages) ? result.messages : []
        this.otherProfileInformation = result?.other_profile || null

        // Eğer sende "view" endpointi/action'ı varsa burada çağırırsın.
        // Yoksa bu satırı hiç kullanma.
        // this.viewUnviewedMessages()
      } catch (e) {
        console.error('loadChat failed:', e)
      } finally {
        this.isLoading = false
        this.$nextTick(() => this.scrollToBottom(true))
      }
    },

    myMessage(msg) {
      if (typeof msg?.is_me === 'boolean') return msg.is_me
      return String(msg?.from_profile) === String(this.myProfileId)
    },

    getFromNow(msgOrDate) {
      const dateStr = msgOrDate?.pm_date || msgOrDate
      if (!dateStr) return ''
      return new moment(dateStr).fromNow()
    },

    scrollToBottom(force = false) {
      const el = this.$refs.chatBody
      if (!el) return

      if (!force) {
        const nearBottom = el.scrollHeight - (el.scrollTop + el.clientHeight) < 140
        if (!nearBottom) return
      }

      el.scrollTop = el.scrollHeight
    },

    async sendMessage() {
      const content = (this.toBeSentMessage || '').trim()
      if (!content) return
      if (content.length > 2040) return
      if (!this.otherProfileId) return
      if (this.isSending) return

      this.isSending = true

      try {
        await this.$store.dispatch('sendMessage', {
          to_profile: this.otherProfileId,
          content,
        })

        // başarılıysa local'e ekle (backend mesaj döndürmüyor diye varsayıyorum)
        this.messages.push({
          id: null,
          content,
          from_profile: this.myProfileId,
          to_profile: this.otherProfileId,
          pm_date: new moment().toISOString(),
          is_me: true,
          is_viewed: true,
          type: 0,
        })

        this.toBeSentMessage = ''
        this.$nextTick(() => this.scrollToBottom(true))
      } catch (e) {
        // "giderse gider" mod: sadece logla, kullanıcıyı rahatsız etme
        console.error('sendMessage failed:', e)
      } finally {
        this.isSending = false
      }
    },

    goToProfile(profileID) {
      if (!profileID) return
      this.$router.push({ name: 'profile', params: { profileID } })
    },
  }
}