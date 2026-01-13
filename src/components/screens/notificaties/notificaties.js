import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'

export default {
  name: 'notificaties',
  components: { ProfileAvatar },

  created () {
    this.$store.commit('SET_HEADER_TITLE', {
      tr: 'Bildirimlerim',
      nl: 'Mijn notificaties',
      fr: 'Mes notifications'
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
      if (!n) return 'Kullanıcı'
      if (n.sender_username) return n.sender_username
      const full = [n.sender_name, n.sender_lastname].filter(Boolean).join(' ')
      return full || 'Kullanıcı'
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
      if (this.lang === 'tr') {
        if (n.type === 1) return 'senin gönderini beğendi.'
        if (n.type === 2) return 'senin gönderine yorum yazdı.'
        if (n.type === 3) return 'seni takip etmeye başladı.'
        if (n.type === 5) return 'yeni bir paylaşımda bulundu.'
        if (n.type === 6) return 'gönderini kaydetti.'
      } else if (this.lang === 'nl') {
        if (n.type === 1) return 'vond je bericht leuk.'
        if (n.type === 2) return 'reageerde op je bericht.'
        if (n.type === 3) return 'is begonnen je te volgen.'
        if (n.type === 5) return 'deelde een nieuwe post.'
        if (n.type === 6) return 'heeft je bericht opgeslagen.'
      } else {
        if (n.type === 1) return 'a aimé votre message.'
        if (n.type === 2) return 'a commenté votre message.'
        if (n.type === 3) return 'a commencé à vous suivre.'
        if (n.type === 5) return 'a partagé une nouvelle publication.'
        if (n.type === 6) return 'a enregistré votre publication.'
      }
      return ''
    },

    viewAllNotificationsIfAny () {
      const list = this.notifications || []
      const unseen = list.filter(x => x && !x.is_seen).map(x => x.id)
      if (!unseen.length) return

      if (this.$store._actions?.markNotificationsSeen) {
        this.$store.dispatch('markNotificationsSeen', unseen).catch(() => {})
      }
    },

    goToPost (postID) {
      this.$router.push({ name: 'postcontainer', params: { postID } })
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