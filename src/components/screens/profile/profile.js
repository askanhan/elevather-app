import UIText from '@/mixins/ui-text.js'
import basicOperations from '@/mixins/basic-operations'
import defaultAvatar from '@/assets/default-avatar.png'   // 👈 burası yeni
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'
import ConfirmDialog from '@/components/complementarities/ConfirmDialog.vue'
import { ElTabs, ElTabPane } from 'element-plus'
import PostCard from '@/components/complementarities/PostCard.vue'
import { authStore } from "@/store/auth.js"
import {
  ElForm,
  ElFormItem,
  ElInput,
  ElSelect,
  ElOption,
  ElSwitch,
  ElButton,
  ElUpload,
  ElIcon,
} from 'element-plus'
import  LanguageSwitcher from "@/components/complementarities/LanguageSwitcher.vue"
import { Plus, Camera } from '@element-plus/icons-vue'
import { create } from 'lodash'
export default {
  components: {
    LanguageSwitcher,
    ProfileAvatar,
    ConfirmDialog,
    ElForm,
    ElFormItem,
    ElInput,
    ElSelect,
    ElOption,
    ElSwitch,
    ElButton,
    ElUpload,
    ElIcon,
    Plus,
    Camera,
    PostCard,
    ElTabs,
    ElTabPane,
  },
  mixins: [UIText, basicOperations],

  data() {
    return {
      activeTab: 'posts',
      deleteOpen: false,
      deleteLoading: false,
      deleteForm: {
        reason: "",
        confirmText: ""
      },
      profileDetails: null,
      category: null,
      tag: null,
      isMyProfile: false,
      profileForm: {
        username: '',
        name: '',
        lastName: '',
        bio: '',
        provinceId: null,
        is_visible: true,
      },
      profileRules: {
        username: [
          { required: true, message: this.$t('pages.profile.messages.nameRequired'), trigger: 'blur' },
          { min: 2, message: this.$t('pages.profile.messages.nameMin'), trigger: 'blur' },
        ],
      },
      isBusinessSidebarOpen: false,
      businessForm: {
        name: '',
        description: '',
        fk_category: null,
        fk_tag: null,
        fk_province: null,
        fk_town: null,
        adres: '',
        phone: '',
        whatsapp: '',
        website: '',
        email: '',
        is_visible: true,
        p_photo_link: '',
      },
      businessRules: {
        name: [
          { required: true, message: this.$t('pages.profile.messages.bizNameRequired'), trigger: 'blur' },
          { min: 2, message: this.$t('pages.profile.messages.bizNameMin'), trigger: 'blur' },
        ],
        fk_category: [
          { required: true, message: this.$t('pages.profile.messages.categoryRequired'), trigger: 'change' },
        ],
        email: [
          { type: 'email', message: this.$t('pages.profile.messages.emailInvalid'), trigger: 'blur' },
        ],
        website: [
          { type: 'url', message: this.$t('pages.profile.messages.urlInvalid'), trigger: 'blur' },
        ],
      },
      logoFileList: [],
      logoFile: null,
      isBusinessEditing: false,
      editingBusinessId: null,
      existingBusinessPhoto: null, // edit modunda eski logo url’ini tutalım
      isModalActive: false,
      isPostModalActive: false,
      currentPostImage: '',
      isSidebarOpen: false,
      darkMode: false,
      isAccountPrivate: localStorage.getItem('isPrivateAccount') === 'yes',

      // Account switcher
      activeAccount: 'enabled',
      defaultAvatar,                    // 👈 string yerine import’u kullanıyoruz
      originalName: this.$t('components.post.testUser')
    }
  },
  created() {
    const profileID = this.$route.params.profileID;
    this.isMyProfile = profileID == this.$store.state.myProfile.id;
    this.profileViewed();
    if (this.isMyProfile) {
      this.$store.dispatch('getMyPosts')
      this.$store.dispatch('getMyBookmarks')
    }
  },
  mounted() {
    const saved = localStorage.getItem('profile_dark_mode')
    if (saved === '1') this.darkMode = true
  },

  computed: {
    otherBusinesses() {
      return this.profileDetails?.businesses || []
    },
    otherPosts() {
      return this.profileDetails?.posts || []
    },
    otherBusinessesCount() {
      return this.otherBusinesses.length
    },
    otherPostsCount() {
      return this.otherPosts.length
    },
    myPosts() {
      return this.$store.state.myPosts || []
    },
    myBookmarks() {
      return this.$store.state.myBookmarks || []
    },
    myPostsCount() {
      return (this.myPosts && this.myPosts.length) || 0
    },
    myBookmarksCount() {
      return (this.myBookmarks && this.myBookmarks.length) || 0
    },

    isFollowed() {
      const pid = this.profileDetails?.id
      if (!pid) return false
      const followings = this.$store.state.followings || []
      return followings.some(f => String(f.profile_id) === String(pid))
    },
    lang() {
      return this.$store.state.lang
    },

    // Kategoriler
    categoryOptions() {
      const raw = this.$store.state.categories

      const cats = Array.isArray(raw)
        ? raw
        : raw && (
          Array.isArray(raw.items) ? raw.items :
            Array.isArray(raw.data) ? raw.data :
              []
        )

      return cats.map(c => {
        const id = c.id ?? c.ca_id ?? c.category_id

        if (!id) return null

        const label =
          c[`name_${this.lang}`] ||
          c[`ca_name_${this.lang}`] ||
          c.name ||
          c.ca_name ||
          `Kategori ${id}`

        return { value: id, label }
      }).filter(Boolean)
    },

    myBusinesses() {
      return this.$store.state.myBusinesses || []
    },

    // Seçilen kategoriye göre etiketler
    tagOptions() {
      const raw = this.$store.state.tags

      const tags = Array.isArray(raw)
        ? raw
        : raw && (
          Array.isArray(raw.items) ? raw.items :
            Array.isArray(raw.data) ? raw.data :
              Array.isArray(raw.results) ? raw.results :
                []
        )

      return tags
        .filter(t => {
          if (!this.businessForm?.fk_category) return true
          return t.category_id === this.businessForm.fk_category
        })
        .map(t => {
          const id = t.tag_id ?? t.id
          if (!id) return null

          const label =
            t[`name_${this.lang}`] ||
            t[`tag_name_${this.lang}`] ||
            t.name ||
            t.tag_name ||
            `Etiket ${id}`

          return { value: id, label }
        })
        .filter(Boolean)
    },

    // İl
    // provinceOptions() {
    //   const raw = this.$store.state.provinces

    //   const provs = Array.isArray(raw)
    //     ? raw
    //     : raw && (
    //       Array.isArray(raw.items) ? raw.items :
    //         Array.isArray(raw.data) ? raw.data :
    //           []
    //     )

    //   return provs.map(p => {
    //     const id = p.pr_id ?? p.id ?? p.province_id
    //     if (!id) return null

    //     const label =
    //       p[`pr_name_${this.lang}`] ||
    //       p[`name_${this.lang}`] ||
    //       p.pr_name_tr ||
    //       p.pr_name ||
    //       p.name ||
    //       `İl ${id}`

    //     return { value: id, label }
    //   }).filter(Boolean)
    // },

    // İlçe (seçili ile göre filtre)
    townOptions() {
      const raw = this.$store.state.towns

      const towns = Array.isArray(raw)
        ? raw
        : raw && (
          Array.isArray(raw.items) ? raw.items :
            Array.isArray(raw.data) ? raw.data :
              []
        )

      return towns
        .filter(t => {
          if (!this.businessForm?.fk_province) return true
          const townProv =
            t.fk_province ??
            t.pr_id ??
            t.province_id
          return String(townProv) === String(this.businessForm.fk_province)
        })
        .map(t => {
          const id = t.town_id ?? t.id
          if (!id) return null

          const label =
            t[`town_name_${this.lang}`] ||
            t[`name_${this.lang}`] ||
            t.town_name ||
            t.name ||
            `İlçe ${id}`

          return { value: id, label }
        })
        .filter(Boolean)
    },

    // store'daki provinces alanını düzgün label'a çeviriyoruz
    provinceOptions() {
      const provs = this.$store.state.provinces || []
      return provs.map(p => {
        const id =
          p.pr_id ??
          p.id ??
          p.province_id

        const label =
          p[`name_${this.lang}`] ||
          p.pr_name_tr ||
          p.pr_name ||
          p.name ||
          `İl ${id}`

        return {
          value: id,
          label,
        }
      })
    },
  },

  watch: {
    darkMode(newVal) {
      if (newVal) document.body.classList.add('dark-mode')
      else document.body.classList.remove('dark-mode')
      localStorage.setItem('profile_dark_mode', newVal ? '1' : '0')
    },

    // 👇 route param değişince profil yenile
    '$route.params.profileID': {
      immediate: true,
      handler() {
        this.loadProfileByRoute()
      }
    }
  },

  methods: {
    openDeleteProfile() {
      this.deleteForm = { reason: "", confirmText: "" };
      this.deleteOpen = true;
    },

    async submitDeleteProfile() {
      if (!this.deleteForm.reason?.trim()) {
        this.$message.error(this.$t('pages.profile.messages.reasonRequired'));
        return;
      }

      if ((this.deleteForm.confirmText || "").trim().toUpperCase() !== "SİL" &&
        (this.deleteForm.confirmText || "").trim().toUpperCase() !== "SIL") {
        this.$message.error(this.$t('pages.profile.messages.typeDelete'));
        return;
      }

      this.deleteLoading = true;
      try {
        // 1) store action (tercih edilen)
        await this.$store.dispatch("createFeedback", {
          type: 'profile_delete',
          message: this.deleteForm.reason
        });

        this.$message.success(this.$t('pages.profile.messages.deleteProcessed'));
        this.$store.dispatch('logout')
      } catch (e) {
        this.$message.error(this.$t('pages.profile.messages.deleteFailed'));
      } finally {
        this.deleteLoading = false;
        this.deleteOpen = false;
      }
    },
    sendMessage(id) {
      if (!id) return
      this.$router.push({ name: 'chat', params: { profileID: this.$route.params.profileID } })
    },
    goToBusinessDetailPage(id) {
      if (!id) return
      this.$router.push({ name: 'business', params: { businessID: id } })
    },
    goToDonate() {
      this.$router.push({ name: 'donate' })
    },
    profileViewed() {
      if (this.isMyProfile) return ''
      const profileID = this.$route.params.profileID
      if (!profileID) return
      this.$store.dispatch('profileViewed', profileID)
    },
    toggleFollow() {
      if (this.isFollowed) {
        this.$store.dispatch('unfollow', this.profileDetails.id)
      } else {
        this.$store.dispatch('follow', this.profileDetails.id)
      }
    },
    async loadProfileByRoute() {
      const profileID = this.$route.params.profileID
      if (!profileID) return

      // overlay/panel kapat
      this.isSidebarOpen = false
      this.isBusinessSidebarOpen = false

      // tab reset: tek tabs
      this.activeTab = 'posts'

      // içerik reset
      this.profileDetails = null
      this.category = null
      this.tag = null

      // isMyProfile güncelle
      const myId = this.$store.state?.myProfile?.id
      this.isMyProfile = String(profileID) === String(myId)

      // kendi profiline geldiyse içerikler
      if (this.isMyProfile) {
        this.$store.dispatch('getMyPosts')
        this.$store.dispatch('getMyBookmarks')
      }

      // başka profile bakıyorsan view say
      this.profileViewed()

      await this.$nextTick()

      this.$store.dispatch('getProfileDetails', {
        profileID,
        successCB: (p) => {
          this.profileDetails = p
          this.category = this.$store.getters.getCategory(p.fk_category)
          this.tag = this.$store.getters.getTag(p.fk_tag)
          this.fillProfileFormFromStore()
        },
        errorCB: (error) => {
          console.error('Error fetching profile details:', error)
          this.profileDetails = null
        }
      })
    },

    logout() {
      this.$store.dispatch('logout')
    },

    resetHiddenPosts() {
      authStore.removeItem('hidden_posts')
      this.$message.success(this.$t('pages.profile.messages.hiddenUpdated'))
      console.log('hidden_posts temizlendi')
    },
    businessPhotoUrl(link) {
      if (!link) return null
      // eğer backend absolute url veriyorsa direkt döndür:
      if (link.startsWith('http')) return link
      // yoksa senin cdn/domain prefixini ekle:
      // return 'https://api.burada.be' + link
      return this.$store.state.serverLocation + link
    },

    categoryIDToLabel(id) {
      const c = this.categoryOptions.find(x => String(x.value) === String(id))
      return c ? c.label : ''
    },

    tagIDToLabel(id) {
      const t = this.tagOptions.find(x => String(x.value) === String(id))
      return t ? t.label : ''
    },

    locationLabel(provId, townId) {
      const prov = this.provinceOptions.find(p => String(p.value) === String(provId))
      const town = this.townOptions.find(t => String(t.value) === String(townId))
      if (prov && town) return prov.label + ' / ' + town.label
      if (prov) return prov.label
      if (town) return town.label
      return ''
    },
    handleLogoChange(file, fileList) {
      // sadece son dosyayı tut
      this.logoFileList = fileList.slice(-1)
      const latest = this.logoFileList[0]

      // Element Plus v2: file.raw içinde gerçek File objesi olur
      this.logoFile = latest ? (latest.raw || latest) : null
    },

    openBusinessSidebar() {
      this.resetBusinessForm()
      this.isBusinessEditing = false
      this.editingBusinessId = null
      this.existingBusinessPhoto = null
      this.isBusinessSidebarOpen = true
    },

    openBusinessSidebarForEdit(business) {
      this.resetBusinessForm()

      this.isBusinessEditing = true
      this.editingBusinessId = business.id
      this.existingBusinessPhoto = business.p_photo_link || null

      this.businessForm = {
        name: business.name || '',
        description: business.description || '',
        fk_category: business.fk_category_id ?? business.fk_category ?? null,
        fk_tag: business.fk_tag_id ?? business.fk_tag ?? null,
        fk_province: business.fk_province_id ?? business.fk_province ?? null,
        fk_town: business.fk_town_id ?? business.fk_town ?? null,
        adres: business.adres || '',
        phone: business.phone || '',
        whatsapp: business.whatsapp || '',
        website: business.website || '',
        email: business.email || '',
        is_visible: !!business.is_visible,
        p_photo_link: business.p_photo_link || '',
      }

      // --- mevcut logoyu preview'e koy
      if (this.existingBusinessPhoto) {
        const base = this.$store.state.serverLocation
        const fullUrl = this.existingBusinessPhoto.startsWith('http')
          ? this.existingBusinessPhoto
          : `${base}${this.existingBusinessPhoto.startsWith('/') ? '' : '/'}${this.existingBusinessPhoto}`

        this.logoFileList = [{
          name: 'current-logo',
          url: fullUrl
        }]
      } else {
        this.logoFileList = []
      }

      this.logoFile = null
      this.isBusinessSidebarOpen = true
    },
    closeBusinessSidebar() {
      this.isBusinessSidebarOpen = false
    },
    resetBusinessForm() {
      // istersen profil / konum bilgilerine göre default doldurabilirsin
      this.businessForm = {
        name: '',
        description: '',
        fk_category: null,
        fk_tag: null,
        fk_province: null,
        fk_town: null,
        adres: '',
        phone: '',
        whatsapp: '',
        website: '',
        email: '',
        is_visible: true,
        p_photo_link: '',
      }
      this.$refs.businessFormRef?.clearValidate()
    },

    async submitBusiness() {
      this.$refs.businessFormRef.validate(async valid => {
        if (!valid) return

        let photoUrl = this.existingBusinessPhoto || null

        // yeni logo seçildiyse upload et, yoksa eskiyi koru
        if (this.logoFile) {
          try {
            photoUrl = await this.$store.dispatch('uploadBusinessLogo', this.logoFile)
          } catch (e) {
            this.$message.error(this.$t('pages.profile.messages.imgError'))
            return
          }
        }

        const payload = {
          name: this.businessForm.name,
          description: this.businessForm.description || null,
          fk_category: this.businessForm.fk_category,
          fk_tag: this.businessForm.fk_tag || null,
          fk_province: this.businessForm.fk_province || null,
          fk_town: this.businessForm.fk_town || null,
          adres: this.businessForm.adres || null,
          phone: this.businessForm.phone || null,
          whatsapp: this.businessForm.whatsapp || null,
          website: this.businessForm.website || null,
          email: this.businessForm.email || null,
          is_visible: this.businessForm.is_visible ? 1 : 0,
          p_photo_link: photoUrl
        }

        try {
          if (this.isBusinessEditing && this.editingBusinessId) {
            await this.$store.dispatch('updateBusiness', {
              id: this.editingBusinessId,
              payload
            })
            this.$message.success(this.$t('pages.profile.messages.bizUpdated'))
          } else {
            await this.$store.dispatch('createBusiness', payload)
            this.$message.success(this.$t('pages.profile.messages.bizAdded'))
          }

          this.closeBusinessSidebar()

        } catch (e) {
          this.$message.error(this.$t('pages.profile.messages.bizFailed'))
        }
      })
    },
    provinceIDToLabel(provinceId) {
      const prov = this.provinceOptions.find(p => p.value === provinceId)
      return prov ? prov.label : ''
    },
    fillProfileFormFromStore() {
      const p = this.profileDetails || {}

      this.profileForm.username = p.username || ''
      this.profileForm.name = p.name || ''
      this.profileForm.lastName = p.lastname || ''
      this.profileForm.bio = p.bio || ''
      this.profileForm.provinceId = p.fk_province || null
      this.profileForm.is_visible =
        p.visible_to_anyone !== undefined ? !!p.visible_to_anyone : true
    },

    submitProfile() {
      this.$refs.profileFormRef.validate((valid) => {
        if (!valid) return

        const payload = {
          username: this.profileForm.username,
          name: this.profileForm.name,
          lastname: this.profileForm.lastName || null,
          bio: this.profileForm.bio || null,
          fk_province: this.profileForm.provinceId || null,
          visible_to_anyone: this.profileForm.is_visible ? 1 : 0,
        }

        // burada istediğin gibi API / store action çağır
        // örnek:
        this.$store.dispatch('updateProfile', {
          id: this.profileDetails.id,
          payload
        })
          .then(() => {
            // console.log('Profil başarıyla güncellendi')
            Object.assign(this.profileDetails, payload);
            this.closeSidebar();
          })
          .catch((err) => {
            console.error('Profil güncellenemedi' + err.message)
          })

      })
    },

    resetProfileForm() {
      this.fillProfileFormFromStore()
      this.$refs.profileFormRef?.clearValidate()
    },
    getGridClass() {
      return this.posts.length % 3 === 0 ? 'three-column-grid' : 'two-column-grid';
    },
    goToChat() {
      this.$router.push({ name: 'chat', params: { userId: this.profile.p_id } })
    },
    sidebarGoToChat() {
      this.goToChat()
      this.closeSidebar()
    },
    closeModal(e) {
      if (e.target.id === 'profile-modal') this.isModalActive = false
    },
    openModal() {
      this.isModalActive = true
    },
    openPostModal(img) {
      this.currentPostImage = img
      this.isPostModalActive = true
    },
    closePostModal(e) {
      if (e.target.id === 'post-modal') this.isPostModalActive = false
    },
    toggleSidebar() {
      this.isSidebarOpen = !this.isSidebarOpen
    },
    closeSidebar() {
      this.isSidebarOpen = false
    },
    goToSettings() {
      this.$router.push({ name: 'settings' })
      this.closeSidebar()
    },
    updateAccountPrivacy() {
      localStorage.setItem(
        'isPrivateAccount',
        this.isAccountPrivate ? 'yes' : 'no'
      )
    },
  }
}