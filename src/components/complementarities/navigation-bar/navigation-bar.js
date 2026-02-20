import Vue from 'vue'
import UIText from '@/mixins/ui-text.js'
import * as mutationTypes from '@/store/mutation-types.js'
import basicOperations from '@/mixins/basic-operations'
import icons from '@/mixins/icons'
export default {
  name: 'NavigationBar',
  mixins: [icons, UIText, basicOperations],
  data() {
    return {
      current: '/'
    }
  },
  mounted() {
    // Initialiser avec la route actuelle au montage pour que la navbar s'affiche au refresh
    this.current = this.$route.name || '/'
  },

  computed: {
    lang() {
      return this.$store.state.lang
    },
    loggedIn() {
      return this.$store.state.flags.loggedIn
    }
  },
  methods: {
    profileTo() {
      console.log('Navigating to profile' + this.$store?.state?.myProfile?.id)
      return this.$store?.state?.myProfile?.id ? this.$router.push('/profile/' + this.$store?.state?.myProfile?.id) : null;
    },
    async homeSelected() {
      if (this.current === 'home') {
        let newMessages = await this.$store.dispatch('getNewPosts')
        if (newMessages > 0){
          this.$message.success('Yeni postlar var: ' + newMessages + ' adet')
        }
        setTimeout(() => {
          this._goToTop("#home-head")
        }, 10)
      } else {
        this.$router.push('/home')
      }
    },
    searchSelected() {
      if (this.current === 'search') {
        setTimeout(() => {
          this._goToTop("#search-top")
        }, 10)
      } else {
        this.$router.push('/search')
      }
    },
    addSelected() {
      this.$router.push('/add')
    },
    newsSelected() {
      this.$router.push('/news-list')
    },
    arrangeCurrentRoute(route) {
      this.current = route.name
    },

    goPowerCheck() {
      this.$router.push({ name: 'home' })
    },
  
    goTracks() {
      // Journey / Tracks page
      this.$router.push({ name: 'journey' })
    },
  
    goPowerSimulator() {
      // Simulator list page
      this.$router.push({ name: 'simulator' })
    },
  
    goStoriesModels() {
      this.$router.push({ name: 'stories' })
    },
  
    goProfile() {
      this.$router.push({ name: 'profile' })
    }
  },

  watch: {

    $route(to, from) {
      this.isMenuOpen = false
      this.arrangeCurrentRoute(to)
    }
  }
}