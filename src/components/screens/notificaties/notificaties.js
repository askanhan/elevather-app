import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'

export default {
  name: 'notificaties',
  components: { ProfileAvatar },

  created () {
    this.$store.commit('SET_HEADER_TITLE', {
      en: this.$t('pages.notifications.title', {}, { locale: 'en' }),
      tr: this.$t('pages.notifications.title', {}, { locale: 'tr' }),
      nl: this.$t('pages.notifications.title', {}, { locale: 'nl' }),
      fr: this.$t('pages.notifications.title', {}, { locale: 'fr' })
    })

    this.$store.dispatch({
      type: 'getMyNotifications',
      cbFunction: () => {
        this.viewAllNotificationsIfAny()
      }
    })
  },

  watch: {
    notifications () {
      this.viewAllNotificationsIfAny()
    }
  },

  computed: {
    lang () {
      return this.$store.state.lang
    },
    notifications () {
      return this.$store.state.notifications
    }
  },

  methods: {
    // Satıra tıklanınca:
    // TYPE_FOLLOW(3) => profile
    // diğerleri (1,2,5,6) => post (fk_post varsa)
    handleClick (n) {
      this.$store.dispatch('notificationIsSeen', n.id).catch(() => {})
      if (!n) return

      // 3: follow
      if (n.type === 3 && n.fk_by_profile) {
        this.goToProfile(n.fk_by_profile)
        return
      }

      // 1/2/5/6: post varsa post’a
      if ((n.type === 1 || n.type === 2 || n.type === 5 || n.type === 6) && n.fk_post) {
        this.goToPost(n.fk_post)
        return
      }

      // fallback
      if (n.fk_by_profile) this.goToProfile(n.fk_by_profile)


        this.$store.dispatch({
          type: 'notificationIsSeen',
          id: n.id
        }).catch(() => {})
    },

    senderDisplayName (n) {
      if (!n) return this.$t('pages.notifications.unknownUser')
      if (n.sender_username) return n.sender_username
      const full = [n.sender_name, n.sender_lastname].filter(Boolean).join(' ')
      return full || this.$t('pages.notifications.unknownUser')
    },

    senderPhoto (n) {
      return n?.sender_photo || null
    },

    typeIcon (n) {
      if (n.type === 1) return 'fas fa-heart'
      if (n.type === 2) return 'fas fa-comment'
      if (n.type === 3) return 'fas fa-user-plus'
      if (n.type === 5) return 'fas fa-plus'
      if (n.type === 6) return 'fas fa-bookmark'
      return 'fas fa-bell'
    },

    typeBadgeClass (n) {
      if (n.type === 1) return 'is-like'
      if (n.type === 2) return 'is-comment'
      if (n.type === 3) return 'is-follow'
      if (n.type === 5) return 'is-post'
      if (n.type === 6) return 'is-bookmark'
      return 'is-default'
    },

    textFor (n) {
      const typeKeys = {
        1: 'like',
        2: 'comment',
        3: 'follow',
        5: 'post',
        6: 'bookmark'
      }
      const key = typeKeys[n.type]
      return key ? this.$t('pages.notifications.types.' + key) : ''
    },

    viewAllNotificationsIfAny () {
      const list = this.notifications || []
      const unseen = list.filter(x => x && !x.is_seen).map(x => x.id)
      if (!unseen.length) return

      if (this.$store._actions?.markNotificationsSeen) {
        this.$store.dispatch('markNotificationsSeen', unseen).catch(() => {})
      }
    },


    goToProfile (profileID) {
      this.$router.push({ name: 'profile', params: { profileID } })
    },

    getFromNow (dt) {
      try {
        const m = this.moment || window.moment
        return m ? m(dt).fromNow() : dt
      } catch (e) {
        return dt
      }
    }
  }
}