import ConfirmDialog from '@/components/complementarities/ConfirmDialog.vue'
import defaultAvatar from '@/assets/default-avatar.png'
import UIText from '@/mixins/ui-text.js'
import PostCard from '@/components/complementarities/PostCard.vue'
import basicOperations from '@/mixins/basic-operations'
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'

import { ElTabs, ElTabPane } from 'element-plus'
export default {
  components: { ProfileAvatar, ConfirmDialog, ElTabs, ElTabPane, PostCard },
  mixins: [UIText, basicOperations],

  created() {
    const businessId = this.$route.params.businessID

    this.$store.dispatch('getBusinessDetails', {
      businessId,
      successCB: (businessDetails) => {
        console.log('Fetched business details:', businessDetails)
        this.profile = businessDetails.owner_profile
        this.businessDetails = businessDetails
        this.category = this.$store.getters.getCategory(businessDetails.fk_category)
        this.tag = this.$store.getters.getTag(businessDetails.fk_tag)

        // ✅ profile bağlı mı? (backend’den hangi isim geliyorsa bakıyoruz)
        const pid =
          businessDetails.fk_profile_id ??
          businessDetails.profile_id ??
          businessDetails.owner_profile_id ??
          null

        // profile varsa: placeholder test profile yerine “bağlı” kabul edelim
        if (pid) {
          this.profile = { ...(this.profile || {}), p_id: Number(pid) }
        } else {
          this.profile = null
        }
        console.log(businessDetails.id)
        this.$store.dispatch('getBusinessPosts', {
          businessId: businessDetails.id,
          successCB: (posts) => {
            this.allPosts = posts
            this.allPostsCount = posts.length
          },
          errorCB: (error) => {
            console.error('Error fetching business posts:', error)
          }
        })
      },
      errorCB: (error) => {
        console.error('Error fetching business details:', error)
      }
    })
  },

  data() {
    return {
      allPostsCount: 0,
      allPosts: [],
      businessDetails: null,
      category: null,
      tag: null,

      // ✅ Eskiden test profile vardı; artık gerçek mantık:
      // businessDetails profile vermiyorsan null.
      profile: null,

      isModalActive: false,
      isPostModalActive: false,
      currentPostImage: '',
      isFollowed: false,
      isSidebarOpen: false,
      darkMode: false,
      isAccountPrivate: localStorage.getItem('isPrivateAccount') === 'yes',

      // Account switcher (sende lazımsa kalsın)
      activeAccount: 'enabled',
      defaultAvatar,


      editLoading: false,
      claimOpen: false,
      editOpen: false,

      claimLoading: false,

      claimForm: { phone: "", note: "" },
      editForm: { details: "", email: "" },

      reportOpen: false,
      reportLoading: false,
      reportForm: {
        reason: "",
        email: ""
      },



      originalName: this.$t('components.post.testUser')
    }
  },

  computed: {
    lang() { return this.$store.state.lang },
    hasLinkedProfile() {
      const pid = this.profile?.p_id
      return !!(pid && Number(pid) > 0)
    },

    totalViews() {
      return this.posts.reduce((sum, p) => sum + (p.ViewedProfiles || 0), 0)
    }
  },

  watch: {
    darkMode(newVal) {
      if (newVal) document.body.classList.add('dark-mode')
      else document.body.classList.remove('dark-mode')
      localStorage.setItem('profile_dark_mode', newVal ? '1' : '0')
    }
  },

  mounted() {
    const saved = localStorage.getItem('profile_dark_mode')
    if (saved === '1') this.darkMode = true
  },

  methods: {


    openClaim() {
      this.claimForm = { phone: "", note: "" };
      this.claimOpen = true;
    },
    openEditReq() {
      this.editForm = { details: "", email: "" };
      this.editOpen = true;
    },

    openReportReq() {
      this.reportForm = { reason: "", email: "" };
      this.reportOpen = true;
    },

    async submitReportRequest() {
      if (!this.reportForm.reason?.trim()) {
        this.$message.error(this.$t('pages.business.messages.reportReasonRequired'));
        return;
      }

      this.reportLoading = true;
      try {
        await this.sendBusinessClaim(
          this.reportForm.reason + " - " + this.reportForm.email,
          3 // 👈 type 3 = şikayet
        );
        this.reportOpen = false;
      } finally {
        this.reportLoading = false;
      }
    },

    async submitClaim() {
      if (!this.claimForm.note?.trim()) {
        this.$message.error(this.$t('pages.business.messages.noteRequired'));
        return;
      }
      this.sendBusinessClaim(this.claimForm.note + " - " + this.claimForm.phone, 1);
      this.claimOpen = false;
    },

    async submitEditRequest() {
      if (!this.editForm.details?.trim()) {
        this.$message.error(this.$t('pages.business.messages.fixRequired'));
        return;
      }
      this.sendBusinessClaim(this.editForm.details + " - " + this.editForm.email, 2);
      this.editOpen = false;
    },

    toggleFollow() {
      if (!this.hasLinkedProfile) {
        this.requestClaim()
        return
      }
      this.isFollowed = !this.isFollowed
    },

    goToChat() {
      // if (!this.hasLinkedProfile) {
      //   this.requestClaim()
      //   return
      // }
      this.$router.push({ name: 'chat', params: { profileID: this.profile.p_id } })
    },

    async sendBusinessClaim(msg, type) {

      this.claimLoading = true;
      try {
        await this.$store.dispatch("businessClaim", {
          business_id: String(this.$route.params.businessID || ''),
          type,
          message: msg
        });
        this.$message.success(this.$t('pages.business.messages.sent'));
      } catch (e) {
        this.$message.error(this.$t('pages.business.messages.failed'));
      } finally {
        this.claimLoading = false;
      }
    },

    // ✅ Sidebar butonları artık chat değil
    requestClaim() {
      // route adın farklıysa burada değiştir
      this.$router.push({
        name: 'business-claim',
        query: { businessID: String(this.$route.params.businessID || ''), type: '1' }
      })
    },

    requestFix() {
      this.closeSidebar()
      this.$router.push({
        name: 'business-claim',
        query: { businessID: String(this.$route.params.businessID || '') }
      })
    },

    requestReport() {
      this.closeSidebar()
      this.$router.push({
        name: 'business-claim',
        query: { businessID: String(this.$route.params.businessID || '') }
      })
    },

    closeModal() {
      this.isModalActive = false
    },

    openModal() {
      this.isModalActive = true
    },

    openPostModal(img) {
      this.currentPostImage = img
      this.isPostModalActive = true
    },

    closePostModal() {
      this.isPostModalActive = false
    },

    toggleSidebar() {
      this.isSidebarOpen = !this.isSidebarOpen
    },

    closeSidebar() {
      this.isSidebarOpen = false
    },

    updateAccountPrivacy() {
      localStorage.setItem('isPrivateAccount', this.isAccountPrivate ? 'yes' : 'no')
    },

    setActiveAccount(key) {
      this.activeAccount = key
      if (!this.profile) return
      if (key === 'john') this.profile.p_username = 'John Doe'
      else this.profile.p_username = this.originalName
    },

    _openWebsite(url) {
      if (!url) return
      const s = String(url).trim()
      const fixed = s.startsWith('http://') || s.startsWith('https://') ? s : `https://${s}`
      window.open(fixed, '_blank', 'noopener,noreferrer')
    },

    _goToAddress(addr) {
      if (!addr) return
      const q = encodeURIComponent(String(addr))
      window.open(`https://www.google.com/maps/search/?api=1&query=${q}`, '_blank', 'noopener,noreferrer')
    },

    async shareBusiness() {
      const shareData = {
        title: this.businessDetails?.name || this.$t('pages.business.messages.shareTitle'),
        text: this.$t('pages.business.messages.shareText', { name: this.businessDetails?.name || '' }),
        url: window.location.href
      }

      if (navigator.share) {
        try {
          await navigator.share(shareData)
        } catch (err) {
          console.error('Error sharing:', err)
        }
      } else {
        // Fallback: Copy to clipboard
        try {
          await navigator.clipboard.writeText(window.location.href)
          alert(this.$t('pages.business.messages.linkCopied'))
        } catch (err) {
          console.error('Could not copy text: ', err)
        }
      }
    }
  }
}