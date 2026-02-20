import Menubar from '@/components/complementarities/menubar/menubar.vue';
import NavigationBar from '@/components/complementarities/navigation-bar/navigation-bar.vue';
import * as mutationTypes from '@/store/mutation-types.js';
import icons from '@/mixins/icons.js';
import globalMixin from '@/mixins/global.js';
import Darkmode from 'darkmode-js';

export default {
  name: 'app',
  components: { Menubar, NavigationBar },
  mixins: [icons, globalMixin],

  mounted() {
    const options = {
      bottom: '62px',
      right: '32px',
      left: 'unset',
      time: '0.5s',
      mixColor: '#fff',
      backgroundColor: '#000',
      buttonColorDark: '#100f2c',
      buttonColorLight: '#fff',
      saveInCookies: true,
     
      autoMatchOsTheme: true
    };
   
  },

  computed: {
    isScreenDisabled() {
      return this.$store.state.flags.screenDisabled;
    },
    isScreenLocked() {
      return this.$store.state.flags.screenLocked;
    },
    lockedScreenClassIfApplied() {
      let res = this.isDesktopModeOn ? 'desktop-mode-on' : '';
      if (this.isScreenDisabled) return res + ' disabled-screen';
      if (this.isScreenLocked) return res + ' locked-screen';
      return res;
    },
    isDesktopModeOn() {
      return false;
    },
    showTabs() {
      const TAB_ROUTES = ['home', 'search', 'add', 'notifications', 'profile'];
      return TAB_ROUTES.includes(this.$route.name);
    },
    meId() {
      const s = this.$store?.state;
      const u = s?.loggedInUserInformation?.UserData || {};
      return u.userid ?? u.LLinkIDUsername ?? s?.user?.id ?? 0;
    },
    profileTo() {
      return { name: 'profile', params: { profileID: this.meId } };
    },
    isDarkMode() {
      return document.body.classList.contains('dark-mode');
    },
    isUserLoggedIn() {
      // Vérifier d'abord la métadonnée de la route
      const routeMeta = this.$route?.meta;
      if (routeMeta?.showHeaderAndNavbar === false) {
        return false;
      }
      // Par défaut, afficher le header/navbar
      return true;
    },
  },

  methods: {
    showMessage() {
      this.$store.commit(mutationTypes.SHOW_MESSAGE, '');
    }
  }
};
