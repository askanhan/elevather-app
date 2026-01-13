import * as globalTypes from '@/store/mutation-types'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
// import VueUploadComponent from 'vue-upload-component'
// import Treeselect from '@riophae/vue-treeselect'
//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
export default {
  name: 'UpgradeProfile',
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      imgID: 'profilephoto-' + this.$store.state.profile.p_id + '-' + new Date().getTime(),
      profile: {},
      toBeUploadedPhoto: [],
      ppLink: '', // imgID + ext  TODO
      photoExt: '',
      selectedCatAndTags: null,
      originalSelectedCatAndTags: null,
      selectedProvince: 12,
      selectedTown: null,
    }
  },

  components: {
    // FileUpload: VueUploadComponent,
    // Treeselect
  },

  computed: {
    toBeUploadedPhotoUrl() {
      return `http://173.212.229.149:8448/uploader/pp`
    },
    searchCatsAndTags() {
      return this.$store.state.searchCatsAndTags
    },
    provinces() {
      return _.sortBy(this.$store.state.provinces, 'pr_sort')
    },
    towns() {
      return this.$store.state.towns.filter(t => t.pr_id === this.selectedProvince)
    },
    lang() {
      return this.$store.state.lang
    }
  },
  created() {
  },
  mounted() {
    // this.initializeProfileAndStuff()
    // this.initializeSelectedCatAndTags()
  },
  methods: {
    toggleShowMail() {
      if (this.profile.p_showmail == 0) {
        this.profile.p_showmail = 1
      } else {
        this.profile.p_showmail = 0
      }
    },
    getTagIcon(id) {
      return this.$store.state.tags.filter(t => t.tag_id == id).map(t => t.tag_icon)[0]
    },
    initializeProfileAndStuff() {
      this.profile = JSON.parse(JSON.stringify(this.$store.state.profile))
      if (this.profile.lo_id !== null) {
        this.selectedProvince = this.profile.fk_province
        this.selectedTown = this.profile.fk_town
      }
    },
    initializeSelectedCatAndTags() {

      if (this.profile.ProfileTags && this.profile.ProfileTags.length > 0) {
        console.log('hmmf')
        let tags = this.profile.ProfileTags.split(',')
        let newSelectedCatAndTags = []
        for (let i = 0; i < tags.length; i++) {
          newSelectedCatAndTags.push(this.getTagIcon(tags[i]) + ' tag-id-' + tags[i])
        }
        console.log(newSelectedCatAndTags)
        this.selectedCatAndTags = newSelectedCatAndTags
        this.originalSelectedCatAndTags = newSelectedCatAndTags
      }
    },
    inputPhoto(newFile, oldFile) {
      console.log('inputphoto')
      console.log(newFile)
      if (newFile) {
        this.photoExt = newFile.name.split('.')[newFile.name.split('.').length - 1]
        this.uploadPhoto()
      }
      if (newFile.success) {
        this.profile.p_photo = `https://img.burada.be/profiles/${this.imgID}.${this.photoExt}`
        this.$store.dispatch({
          type: 'putProfile',
          profile: _.pick(this.profile, Object.keys(this.profile).filter(o => o.startsWith('p_'))),
          successCB: (res) => {
            console.log(res)
            this.$toast(this.UIText.profileUpdated[this.lang])
            this.profile = JSON.parse(JSON.stringify(this.$store.state.profile))
          }
        })
      }
    },
    goQuestion(type) {
      // this.$route.g
      console.log(type)
    },
    isSelectedCatAndTagsChanged() {
      if (this.selectedCatAndTags && this.selectedCatAndTags.length > 0) {
        if (this.originalSelectedCatAndTags == null || this.originalSelectedCatAndTags.length === 0
          || this.originalSelectedCatAndTags.length !== this.selectedCatAndTags.length) {
          return true
        }
        for (let i = 0; i < this.selectedCatAndTags.length; i++) {
          if (this.originalSelectedCatAndTags[i] !== this.selectedCatAndTags[i]) {
            return true
          }
        }
        return false
      }
      if ((this.selectedCatAndTags == null || this.selectedCatAndTags.length === 0)
        && (this.originalSelectedCatAndTags == null || this.originalSelectedCatAndTags.length === 0)) {
        return false
      }
      return true // nothing selected -> no need to post
    },
    arrangeProfileTags() {
      if (!this.isSelectedCatAndTagsChanged()) {
        console.log('degismemiiisss')
      } else {
        console.log('degismis....')
        console.log('sil bastan....')
        this.$store.dispatch({
          type: 'postNewProfileTags',
          tagIds: this.selectedCatAndTags.map(b => b.split('tag-id-')[1]),
          successCB: (res) => {
            console.log(res)
          }
        })
      }
    },
    getLocationObject(forPost) {
      let res = _.pick(this.profile, Object.keys(this.profile).filter(o => o.startsWith('lo_')))
      res.fk_province = this.selectedProvince
      res.fk_town = this.selectedTown
      res.fk_country = 1
      if (forPost) {
        delete res.lo_id
      }
      return res
    },
    arrangeLocation(cbFunction) {
      if (this.selectedProvince === 12 && this.profile.lo_id !== null) {
        this.$store.dispatch({
          type: 'deleteLocation',
          location: this.getLocationObject(false),
          successCB: (res) => {
            this.profile = _.merge(this.profile, {
              lo_id: null,
              fk_location: null
            })
            cbFunction()
          }
        })
      } else if (this.selectedProvince === 12 && this.profile.lo_id === null) {
        cbFunction()
      }
      else if (this.profile.lo_id === null) {
        this.$store.dispatch({
          type: 'postLocation',
          location: this.getLocationObject(true),
          successCB: (res) => {
            console.log(res)
            this.profile = _.merge(this.profile, {
              fk_location: res.data.Document,
              lo_id: res.data.Document,
            })
            cbFunction()
          }
        })
      } else {
        this.$store.dispatch({
          type: 'putLocation',
          location: this.getLocationObject(false),
          successCB: (res) => {
            console.log(res)
            cbFunction()
          }
        })
      }
    },
    saveClicked() {
      if (this.selectedCatAndTags == null || this.selectedCatAndTags.length === 0) {
        console.log('emin misin, gozukmicen?')
        this.$fire({
          title: "Dikkat",
          text: "Mesleginizi ya da sektörünüzü girmezseniz, diger kullanicilar tarafindan bulunamayacaksiniz.",
          showConfirmButton: true,
          showCancelButton: true,
          confirmButtonText: 'Anladim, doldurup yeniden kaydetmek istiyorum',
          cancelButtonText: 'Benim için gerekli degil',
        }).then(r => {
          if (r.value) {
            // stay on page
          } else {
            this.startToUpdate()
          }
        })
      } else {
        this.startToUpdate()
      }
    },
    startToUpdate() {
      console.log(this.profile)
      this.arrangeProfileTags()
      this.arrangeLocation(() => {
        let toBeSentProfile = _.pick(this.profile, Object.keys(this.profile).filter(o => o.startsWith('p_')))
        toBeSentProfile.fk_location = this.profile.fk_location
        if (toBeSentProfile.p_whatsapp) {
          toBeSentProfile.p_whatsapp = toBeSentProfile.p_whatsapp.startsWith('+') ? toBeSentProfile.p_whatsapp : '+32' + toBeSentProfile.p_whatsapp.substring(1)
        }
        if (toBeSentProfile.p_telephone) {
          toBeSentProfile.p_telephone = toBeSentProfile.p_telephone.startsWith('+') ? toBeSentProfile.p_telephone : '+32' + toBeSentProfile.p_telephone.substring(1)
        }
        this.$store.dispatch({
          type: 'putProfile',
          profile: toBeSentProfile,
          successCB: (res) => {
            console.log(res)
            this.$toast(this.UIText.profileUpdated[this.lang])
            this.profile = JSON.parse(JSON.stringify(this.$store.state.profile))
            this.$router.go(-1)
          }
        })
      })
    },
    uploadPhoto() {
      this.$refs.uploadphoto.active = true
    }
  },
  watch: {}
}