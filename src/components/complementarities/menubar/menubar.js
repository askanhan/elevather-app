import Vue from 'vue'
import * as mutationTypes from '@/store/mutation-types.js'
import { ChatDotRound } from '@element-plus/icons-vue'
import icons from '@/mixins/icons'
import basicOperations from '@/mixins/basic-operations'

export default {
  name: 'Menubar',
  mixins: [icons, basicOperations],
  components: { ChatDotRound },

  data() {
    return {
      isMenuOpen: false,
      current: '/',
      backButtonAvailable: false,
      specialButtonAvailable: false,
      showHeaderTitle: false
    }
  },

  computed: {
    lang() {
      return this.$store.state.lang
    },

    specialButton() {
      return this.$store.state.specialButton
    },

    altyazi() {
      return "We Rise Together!"
      const firstName = this.$store?.state?.user?.first_name || ''

      if (this.$route.name === 'home') {
        return this.$t('components.menubar.subtitle.home', { name: firstName })
      }
      if (this.$route.name === 'search') {
        return this.$t('components.menubar.subtitle.search')
      }
      if (this.$route.name === 'add') {
        return this.$t('components.menubar.subtitle.add')
      }
      if (this.$route.name === 'newslist') {
        return this.$t('components.menubar.subtitle.newslist')
      }
      if (this.$route.name === 'profile') {
        return this.$t('components.menubar.subtitle.profile')
      }
      if (this.$route.name === 'business') {
        return this.$t('components.menubar.subtitle.business')
      }
      if (this.$route.name === 'donate') {
        return this.$t('components.menubar.subtitle.donate')
      }
      if (this.$route.name === 'conversations') {
        return this.$t('components.menubar.subtitle.conversations')
      }
      if (this.$route.name === 'chat') {
        return this.$t('components.menubar.subtitle.profile')
      }

      return this.$t('components.menubar.subtitle.default', { name: firstName })
    },

    allConversations() {
      return this.$store.state.allConversations || []
    },

    numberOfUnredMessages() {
      if (this.allConversations && this.allConversations.length > 0) {
        return this.allConversations.filter(c => c.has_unread == true).length
      }
      return 0
    },

    numberOfUnviewedNotifications() {
      return this.$store.state.notifications.filter(m => m.is_seen == 0).length
    },

    loggedIn() {
      return this.$store.state.flags.loggedIn
    },

    isRightSideMenuOpen() {
      return this.$store.state.menubarItems.isRightSideMenuOpen
    },

    titelbalkLinks() {
      return this.$store.state.menubarItems.left
    },

    titelbalkTitel() {
      return this.$store.state.menubarItems.title
    },

    titelbalkRechts() {
      return this.$store.state.menubarItems.right
    },

    textButtons() {
      return this.$store.state.menubarItems.rightAsTextButtons
    },

    rightSideMenuItems() {
      return this.$store.state.menubarItems.rightSideMenuItems
    }
  },

  mounted() {
    // Initialiser avec la route actuelle au montage
    this.current = this.$route.name || '/'
    this.backButtonAvailable = this.$route.meta.backButtonAvailable || false
    this.specialButtonAvailable = this.$route.meta.specialButtonAvailable || false
    this.showHeaderTitle = this.$route.meta.showHeaderTitle || false
  },

  methods: {
    goToMessages() {
      this.$router.push({ name: 'conversations' })
    },

    goToNotifications() {
      this.$router.push({ name: 'notifications' })
    },

    openFeedback() {
      this.$router.push({ name: 'feedback' })
    },

    toggleMenu() {
      console.log(this.isMenuOpen)
      this.isMenuOpen = !this.isMenuOpen
      console.log(this.isMenuOpen)
    },

    toggleRightSideMenu(status, itemright) {
      if (typeof itemright === 'undefined' || typeof itemright.cascading === 'undefined' || !itemright.cascading) {
        this.$store.commit(mutationTypes.SET_MENUBAR_RIGHT_SIDE_MENU_VISIBLE, status)
      }
    },

    longpressTooltipMenubar(item) {
      return function (event) {
        if (event !== undefined) {
          event.preventDefault()
        }
        if (typeof item.FUNCTIE_HELP !== 'undefined') {
          item.FUNCTIE_HELP()
        }
      }.bind(this)
    },

    rightClickTooltipMenubar(item, event) {
      if (typeof item.FUNCTIE_HELP !== 'undefined') {
        event.preventDefault()
        item.FUNCTIE_HELP()
      }
    },

    goToDonate() {
      this.$router.push({ name: 'donate' })
    },

    getTextButtonClass(item) {
      return item.getTextButtonClass()
    },

    goBack() {
      this.$router.go(-1)
    },

    arrangeCurrentRoute(route) {
      this.current = route.name
    },

    getHeaderTitle() {
      if (this.showHeaderTitle) {
        return this.$store.state.headerTitle[this.lang]
      }
    }
  },

  watch: {
    $route(to, from) {
      this.isMenuOpen = false
      this.backButtonAvailable = to.meta.backButtonAvailable
      this.specialButtonAvailable = to.meta.specialButtonAvailable
      this.showHeaderTitle = to.meta.showHeaderTitle
      this.arrangeCurrentRoute(to)
    }
  }
}