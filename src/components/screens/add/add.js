import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'

export default {
  name: 'Add',
  components: { ProfileAvatar },

  data() {
    return {
      MAX_MB: 10,
      description: '',
      photos: [],
      videos: [],
      questionnaire: false,
      options: [],
      showOptions: true,
      selectedCategory: 0,

      selectedPublisherType: null,
      selectedPublisherId: null,

      isSending: false,
      sendError: null,
      eventForm: {
        from_date: '',
        until_date: '',
        start_time: '',
        end_time: '',
        location: '',
      },
    }
  },

  computed: {

    isEventCategory() {
      return String(this.selectedCategory) === '1'
    },

    numberOfMyPostsWithin24Hours() {
      const myId = this.profileDetails?.id || this.profileDetails?.p_id
      const myBusinesses = this.myBusinesses.map(b => b.id)

      const now = Date.now()
      const oneDayAgo = now - (24 * 60 * 60 * 1000)

      const myPosts = this.$store.state.posts.filter(p => {
        return myId == p.fk_profile_id || p.fk_business_id && myBusinesses.includes(p.fk_business_id)
      })

      console.log('My posts in last 24 hours:', myPosts)

      const recentPosts = myPosts.filter(p => {
        const createdAt = new Date(p.post_date).getTime()
        return createdAt >= oneDayAgo
      })

      return recentPosts.length
    },

    profileDetails() { return this.$store.state.myProfile || null },
    myBusinesses() { return this.$store.state.myBusinesses || [] },

    categoryOptions() {
      return [
        { value: 0, label: this.$t('add.category.general'), icon: 'fas fa-home' },
        { value: 1, label: this.$t('add.category.event'), icon: 'fas fa-calendar-alt' },
        { value: 2, label: this.$t('add.category.job'), icon: 'fas fa-briefcase' },
        { value: 4, label: this.$t('add.category.education'), icon: 'fas fa-graduation-cap' },
      ]
    },

    publisherOptions() {
      const opts = []
      const p = this.profileDetails

      if (p && (p.id || p.p_id)) {
        opts.push({
          type: 'user',
          id: p.id ?? p.p_id,
          name: p.username ?? p.p_username ?? this.$t('add.publisher.meFallback'),
          photo: p.profile_photo ?? p.p_photo_link ?? p.p_photo ?? null,
        })
      }

      for (const b of this.myBusinesses) {
        opts.push({
          type: 'business',
          id: b.id,
          name: b.name,
          photo: b.p_photo_link || null,
        })
      }

      return opts
    },

    currentPublisher() {
      const list = this.publisherOptions
      if (!list.length) return null
      return (
        list.find(o => o.type === this.selectedPublisherType && o.id === this.selectedPublisherId) || list[0]
      )
    },

    placeholderText() {
      return this.questionnaire ? this.$t('add.text.pollPlaceholder') : this.$t('add.text.postPlaceholder')
    },

    addOptionText() { return this.$t('add.poll.addOption') },
    addPhotoText() { return this.$t('add.media.photo.add') },
    addVideoText() { return this.$t('add.media.video.add') },
    addQuestionnaireText() { return this.$t('add.media.poll.add') },
    closeQuestionnaireText() { return this.$t('add.media.poll.close') },
    sendText() { return this.isSending ? this.$t('add.send.sending') : this.$t('add.send.send') },
  },

  watch: {
    selectedCategory(newVal) {
      if (String(newVal) !== '1') {
        this.eventForm = { from_date:'', until_date:'', start_time:'', end_time:'', location:'' }
      }
    },
    publisherOptions: {
      immediate: true,
      handler(list) {
        if (!list?.length) return
        if (this.selectedPublisherType && this.selectedPublisherId) return

        const firstBiz = list.find(o => o.type === 'business')
        const def = firstBiz || list[0]

        this.selectedPublisherType = def.type
        this.selectedPublisherId = def.id
      },
    },
  },

  methods: {
    makeAbsolute(url) {
      if (!url) return ''
      if (url.startsWith('http')) return url
      return this.$store.state.serverLocation + url
    },

    beforePhotoUpload(file) {
      const max = this.MAX_MB * 1024 * 1024
      if (file.size > max) {
        this.$message.error(this.$t('add.errors.photoTooLarge', { mb: this.MAX_MB }))
        return false
      }
      return true
    },

    beforeVideoUpload(file) {
      const max = this.MAX_MB * 1024 * 1024
      if (file.size > max) {
        this.$message.error(this.$t('add.errors.videoTooLarge', { mb: this.MAX_MB }))
        return false
      }
      return true
    },

    async uploadPhotoRequest({ file, onSuccess, onError }) {
      try {
        const url = await this.$store.dispatch('uploadPostMedia', file)
        if (!url) throw new Error('URL alınamadı')

        this.photos.push(url)
        onSuccess({ url })
      } catch (e) {
        this.$message.error(this.$t('add.errors.photoUploadFailed'))
        onError(e)
      }
    },

    async uploadVideoRequest({ file, onSuccess, onError }) {
      try {
        const url = await this.$store.dispatch('uploadPostMedia', file)
        if (!url) throw new Error('URL alınamadı')

        this.videos.push(url)
        onSuccess({ url })
      } catch (e) {
        this.$message.error(this.$t('add.errors.videoUploadFailed'))
        onError(e)
      }
    },

    onRemovePhoto(uploadFile) {
      const url = uploadFile?.response?.url
      if (url) this.photos = this.photos.filter(u => u !== url)
    },

    onRemoveVideo(uploadFile) {
      const url = uploadFile?.response?.url
      if (url) this.videos = this.videos.filter(u => u !== url)
    },

    toggleQuestionnaire() {
      this.questionnaire = !this.questionnaire
      if (this.questionnaire && this.options.length === 0) this.resetOptions()
    },

    resetOptions() {
      this.options = [
        { id: 1, name: '', placeholder: this.$t('add.poll.option', { n: 1 }) },
        { id: 2, name: '', placeholder: this.$t('add.poll.option', { n: 2 }) },
      ]
    },

    addOption() {
      const n = this.options.length + 1
      this.options.push({
        id: Date.now(),
        name: '',
        placeholder: this.$t('add.poll.option', { n }),
      })
    },

    removeOption(i) {
      this.options.splice(i, 1)
    },

    publisherAvatarUrl(opt) {
      if (!opt?.photo) return ''
      if (opt.type === 'user') return `https://img.burada.be/profiles/${opt.photo}`
      if (opt.photo.startsWith('http')) return opt.photo
      return this.$store.state.serverLocation + opt.photo
    },

    headerAvatarUrl() {
      return this.currentPublisher ? this.publisherAvatarUrl(this.currentPublisher) : ''
    },

    handleHeaderClick() {
      if (this.currentPublisher?.type === 'user')
        this.$router.push({ name: 'profile', params: { profileID: this.currentPublisher.id } })
      else
        this.$router.push({ name: 'business', params: { businessID: this.currentPublisher.id } })
    },

    buildPayload() {
      const pub = this.currentPublisher
      if (!pub) return null

      const payload = {
        category: this.selectedCategory,
        description: this.description.trim(),
        is_questionnaire: !!this.questionnaire,
        options: this.questionnaire ? this.options.map(o => o.name.trim()).filter(Boolean) : [],
        photos: [...this.photos],
        videos: [...this.videos],
      }

      if (String(this.selectedCategory) === '1') {
        payload.from_date = this.eventForm.from_date || null
        payload.until_date = this.eventForm.until_date || null
        payload.start_time = this.eventForm.start_time || null
        payload.end_time = this.eventForm.end_time || null
        payload.location = (this.eventForm.location || '').trim() || null
      }

      if (pub.type === 'business') payload.fk_business_id = pub.id
      else payload.fk_profile_id = pub.id

      return payload
    },

    isPublisherActive(option) {
      return (
        this.currentPublisher &&
        option.type === this.currentPublisher.type &&
        option.id === this.currentPublisher.id
      )
    },

    async sendPost() {
      if (this.numberOfMyPostsWithin24Hours >= 3) {
        this.$message.error(this.$t('add.errors.postLimitReached'))
        return
      }
      if (this.isSending) return

      const payload = this.buildPayload()
      if (!payload) return

      const hasText = payload.description.length > 0
      const hasMedia = payload.photos.length || payload.videos.length
      const hasPoll = payload.is_questionnaire && payload.options.length >= 2

      if (!hasText && !hasMedia && !hasPoll) {
        this.$message.warning(this.$t('add.errors.emptyPost'))
        return
      }

      this.isSending = true
      try {
        await this.$store.dispatch('createPost', payload)
        this.$message.success(this.$t('add.send.success'))
        this.resetForm()
        this.$router.push({ name: 'home' })
      } catch (e) {
        this.$message.error(this.$t('add.send.fail'))
      } finally {
        this.isSending = false
      }
    },

    selectPublisher(option) {
      this.selectedPublisherType = option.type
      this.selectedPublisherId = option.id
    },

    resetForm() {
      this.description = ''
      this.photos = []
      this.videos = []
      this.questionnaire = false
      this.options = []
      this.showOptions = true
      this.selectedCategory = 0
      this.eventForm = { from_date:'', until_date:'', start_time:'', end_time:'', location:'' }
    },
  },
}