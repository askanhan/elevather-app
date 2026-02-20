import { SplashScreen } from '@capacitor/splash-screen'
import { StatusBar, Style } from '@capacitor/status-bar'
import { Capacitor } from '@capacitor/core'


import { createApp, reactive, watch } from "vue";
import App from "@/components/app/app.vue";
import store from "@/store";
import { authStore } from '@/store/auth.js'
import * as globalTypes from "@/store/mutation-types.js";
import router from "@/router";
//TODO import VueAutosuggest from "vue-autosuggest";
import "swiper/css";
import "swiper/css/pagination";
import { Preferences } from '@capacitor/preferences';

/* Directives */
import "@/directives/general-directives.js";

/* Filters */
import "@/filters/date-filters.js";
import "@/filters/string-filters.js";

/* Defining Vue specific modules */
import axios from "axios";
import VueAxios from "vue-axios";
import VueSidebarMenu from "vue-sidebar-menu";
import "vue-sidebar-menu/dist/vue-sidebar-menu.css";

import globalCss from "./main.css";
import ElementPlus, { ElMessage } from 'element-plus'
import 'element-plus/dist/index.css'

//TODO import Vue2TouchEvents from "vue2-touch-events";
//TODO import { ObserveVisibility } from "vue-observe-visibility";

//TODO import "@babel/polyfill";
//TODO import Es6Promise from "es6-promise";
//TODO Es6Promise.polyfill();
//TODO import VueSimpleAlert from "vue-simple-alert";

import moment from "moment";
import "moment/locale/nl-be";
import "moment/locale/fr";
import "moment/locale/tr";
import VueScrollTo from "vue-scrollto";
import VueSweetalert2 from "vue-sweetalert2";

// If you don't need the styles, do not connect
import "sweetalert2/dist/sweetalert2.min.css";

//TODO import VModal from "vue-js-modal";s
//TODO import VueAwesomeSwiper from "vue-awesome-swiper";
//TODO import "swiper/css/swiper.css";
// import { POSITION } from "vue-toastification";
// import Toast from "vue-toastification";
// Import the CSS or use your own!
// import "vue-toastification/dist/index.css";

import { i18n } from './i18n'



async function setupStatusBar() {
  if (!Capacitor.isNativePlatform()) return

  try {
    await StatusBar.setStyle({ style: Style.Dark })
    await StatusBar.setBackgroundColor({ color: '#f0f8fb' })
    // iOS için overlay kapatır; Android’de etkisi yok ama sorun da çıkarmaz
    await StatusBar.setOverlaysWebView({ overlay: false })
  } catch (e) { }
}

const options = {
  //TODO position: POSITION.BOTTOM_CENTER,
};

const app = createApp(App);

window.$app = app;
window.$router = router;
window.$store = store;

app.use(store);
app.use(router);
app.use(ElementPlus)
app.config.globalProperties.$message = ElMessage
app.use(i18n)

// store'daki lang değişince i18n de değişsin:
watch(
  () => store.state.lang,
  (lng) => { i18n.global.locale.value = lng },
  { immediate: true }
)
window.$message = ElMessage   // istersen dışarıda da kullanabilirsin

if (typeof window !== "undefined") {
  // Konsoldan kolay erişim
  window.__app__ = app;
  window.__store = store;
  window.$store = store; // alternatif alias

  // Vue 3'te globalProperties üzerinden de erişim olsun
  app.config.globalProperties.$store = store;
}
app.config.globalProperties.$pref = Preferences;


// --- DEV: demo verileri tohumla (prod'da çalışmaz)
const __isDev = (import.meta?.env?.DEV) || (process.env.NODE_ENV !== 'production');
if (__isDev) {
  const s = store.state;

  // Temel referanslar (varsa dokunmaz):
  if (!Array.isArray(s.tags) || s.tags.length === 0) {
    s.tags = [
      { tag_id: 10, tag_name_tr: 'Elektrikçi', tag_name_nl: 'Elektricien', tag_name_fr: 'Électricien', tag_icon: 'fa fa-bolt', tag_classname: 'bg-yellow-dark' },
      { tag_id: 11, tag_name_tr: 'Boyacı', tag_name_nl: 'Schilder', tag_name_fr: 'Peintre', tag_icon: 'fa fa-paint-brush', tag_classname: 'bg-blue-dark' }
    ];
  }
  if (!Array.isArray(s.provinces) || s.provinces.length === 0) {
    s.provinces = [{ pr_id: 1, pr_name_tr: 'Brüksel', pr_name_nl: 'Brussel', pr_name_fr: 'Bruxelles' }];
  }
  if (!Array.isArray(s.towns) || s.towns.length === 0) {
    s.towns = [{ town_id: 1, town_name_tr: 'Merkez', town_name_nl: 'Centrum', town_name_fr: 'Centre' }];
  }

  // Demo profiller (me: p_id=7, other: p_id=1)
  s.allProfiles = Array.isArray(s.allProfiles) ? s.allProfiles : [];
  const ensureProfile = (p) => {
    if (!s.allProfiles.some(x => String(x.p_id) === String(p.p_id))) s.allProfiles.push(p);
  };


  //afterlogin ile uyumlu olsun diye
  let refresh = await authStore.getItem('refresh')
  if (refresh) {
    Preferences.set({ key: 'session', value: JSON.stringify({ refresh: refresh }) })
  }

  ensureProfile({
    p_id: 7,
    p_username: 'benimprofilim',
    p_bio: 'Bu benim deneme profilim.',
    p_photo: '',
    fk_town: 1, fk_province: 1,
    lo_id: null,
    ProfileTags: '10,11',
    Followers: '2,3',
    Followings: '1',
    PostIds: ''
  });

  ensureProfile({
    p_id: 1,
    p_username: 'elektrikçi',
    p_bio: 'Elektrikçi profili',
    p_photo: '',
    fk_town: 1, fk_province: 1,
    lo_id: null,
    ProfileTags: '10',
    Followers: '',
    Followings: '',
    PostIds: ''
  });

  ensureProfile({
    p_id: 2,
    p_username: 'boyacı',
    p_bio: 'boyacı profili',
    p_photo: '',
    fk_town: 1, fk_province: 1,
    lo_id: null,
    ProfileTags: '11',
    Followers: '',
    Followings: '',
    PostIds: ''
  });

  // Oturumdaki kullanıcı: kendi profilim p_id=7
  s.user = s.user || {};
  if (!s.user.fk_profile) s.user.fk_profile = 7;

  // (İsteğe bağlı) kendi gönderiler listelerini boş olarak hazırla
  s.myPosts = Array.isArray(s.myPosts) ? s.myPosts : [];
  s.allPosts = Array.isArray(s.allPosts) ? s.allPosts : [];
}

async function __ensureSessionFromStoredRefresh() {
  // Native değilse hiç uğraşma
  if (!Capacitor.isNativePlatform()) return

  try {
    // Zaten session varsa dokunma
    const existing = await Preferences.get({ key: 'session' })
    if (existing?.value && String(existing.value).trim()) return

    // authStore’da refresh varsa session’a yaz
    const refresh = await authStore.getItem('refresh')
    if (!refresh) return

    await Preferences.set({
      key: 'session',
      value: JSON.stringify({ refresh })
    })
  } catch (e) {
    console.log('[auto-login] ensureSessionFromStoredRefresh failed', e)
  }
}



app.use(VueAxios, axios);
//TODO app.use(VueAutosuggest);
app.use(VueSidebarMenu);
//app.use(globalCss);
//TODO app.use(Vue2TouchEvents);
//TODO app.use(VueSimpleAlert);
app.use(VueScrollTo, {
  container: "body",
  duration: 500,
  easing: "ease",
  offset: 0,
  force: true,
  cancelable: true,
  onStart: false,
  onDone: false,
  onCancel: false,
  x: false,
  y: true,
});
//TODO app.use(VModal);
//TODO app.use(VueAwesomeSwiper);
//TODO app.use(Toast, options);
app.use(VueSweetalert2);

//TODO app.directive("observe-visibility",   ObserveVisibility);

app.config.globalProperties.moment = moment;

app.config.globalProperties.mainBus = reactive({});

// ✅ NOUVEAU: Restaure l'authentification au refresh si token existe en localStorage
async function restoreAuthenticationFromLocalStorage() {
  try {
    // Vérifier si on a un token en localStorage
    const accessToken = await authStore.getItem('access')
    const refreshToken = await authStore.getItem('refresh')
    const myProfile = await authStore.getItem('myProfile')
    
    if (accessToken || refreshToken) {
      // Token existe = utilisateur était connecté
      console.log('[auto-restore] Tokens trouvés dans localStorage, restauration de la session...')
      
      // Définir loggedIn = true
      store.commit(globalTypes.LOGGED_IN)
      
      // Restaurer le profil s'il existe
      if (myProfile) {
        try {
          const profile = JSON.parse(myProfile)
          store.commit(globalTypes.SET_MY_PROFILE, profile)
        } catch (e) {
          console.warn('[auto-restore] Erreur parsing myProfile', e)
        }
      }
    }
  } catch (e) {
    console.log('[auto-restore] Erreur lors de la restauration', e)
  }
}

function checkSessionStorage() {
  //TODO console.log("checkSessionStorage");
  let vueRouting = sessionStorage.getItem("VUE_ROUTING");
  if (vueRouting !== null) {
    let puntenboekjeId = sessionStorage.getItem("VUE_PUNTENBOEKJEID");
    let loggedInUserInformation = {
      SessionConfig: {},
      UserData: {},
    };
    loggedInUserInformation.SessionConfig = JSON.parse(
      sessionStorage.getItem("VUE_SESSIE")
    );
    loggedInUserInformation.UserData.userid = parseInt(
      sessionStorage.getItem("VUE_USERID")
    );
    loggedInUserInformation.UserData.LLinkIDUsername = parseInt(
      sessionStorage.getItem("VUE_LLINKID_USERNAME")
    );
    loggedInUserInformation.UserData.LLinkIDPWD = parseInt(
      sessionStorage.getItem("VUE_LLINKID_PASSWORD")
    );
    loggedInUserInformation.menu = JSON.parse(
      sessionStorage.getItem("VUE_MENU")
    );
    loggedInUserInformation.rights = JSON.parse(
      sessionStorage.getItem("VUE_RIGHTS")
    );
    store.commit(globalTypes.SET_LOGGED_IN_USER_INFORMATION, loggedInUserInformation);

    store.commit(globalTypes.SET_USERS_TYPE, sessionStorage.getItem("VUE_USERTYPE"));

    store.commit(
      globalTypes.SET_LOGGED_IN_CONNECTION_OBJECT,
      JSON.parse(sessionStorage.getItem("VUE_LOGIN"))
    );
    router.push(vueRouting);
  }
}
checkSessionStorage();

router.beforeEach((to, from, next) => {
  next();
});

app.config.errorHandler = (err, instance, info) => {
  try {
    const name = instance?.type?.name || instance?.type?.__file || '(isimsiz)';
    console.group('%c[VUE ERROR]', 'color:#f33;font-weight:bold');
    console.error(err);
    // console.log('component:', name, instance?.type);
    // console.log('info:', info);
    console.groupEnd();
  } catch (e) {
    console.error(err);
  }
};

router.beforeResolve((to, from, next) => {
  // console.log('[route]', '->', to.fullPath, ' component:', to.name);
  next();
});
//TODO app.mount("#app");

window.mainVueApp = {
  initialize: function () {
    this.bindEvents();
    this.setupVue();
  },
  bindEvents: function () {
    document.addEventListener("deviceready", this.onDeviceReady, false);
  },
  onDeviceReady: function () {
    setupStatusBar()
    // StatusBar.backgroundColorByHexString("#f9f9f9");

    // $("body").on("focusin", "input, textarea", function (event) {
    //   window.latestElement = $(event.target);
    // });
    // $(window).resize(function () {
    //   setTimeout(function () {
    //     if (window.latestElement !== undefined) {
    //       window.latestElement[0].scrollIntoView();
    //     }
    //   }, 100);
    // });

    // cordova.getAppVersion.getVersionNumber(function (version) {
    //   console.log("versienummer: " + version);
    // });

    // cordova.getAppVersion.getAppName(function (appname) {
    //   console.log("projectNaam: " + appname);
    // });

  },
  receivedEvent: function (id) {
    console.log("Received Event: " + id);
  },
  setupVue: async function () {
    setupStatusBar()
      // ✅ Restaurer l'authentification d'abord
    await restoreAuthenticationFromLocalStorage()
        // ✅ auto-login’i geri getirir (prod’da da çalışır)
    await __ensureSessionFromStoredRefresh()
  
    app.mount("#app");
  
    setTimeout(() => {
      SplashScreen.hide().catch(() => { })
    }, 2000)
  },
};

window.currentVueApp = window.mainVueApp.initialize();

window.parent.getVueWindowScope = function () {
  return window;
};

if (process.env.NODE_ENV === 'development') {
  const roMsg = /ResizeObserver loop (limit exceeded|completed with undelivered notifications)/i

  window.addEventListener(
    'error',
    (e) => {
      const msg = e?.message || e?.error?.message || ''
      if (roMsg.test(msg)) {
        e.preventDefault()
        e.stopImmediatePropagation()
        return false
      }
    },
    true
  )
}
import { App as CapApp } from '@capacitor/app'
import { Browser } from '@capacitor/browser'

// Cold-start’ta link’i yakalayıp login akışını bozmadan biraz sonra uygulayacağız
let __pendingDeepLink = null
let __deepLinkTimer = null

function __parseBuradaUrl(url) {
  let u
  try { u = new URL(url) } catch (_) { return null }
  if (u.protocol !== 'burada:') return null

  // burada://afterlogin?session=...
  if (u.host === 'afterlogin') {
    return { type: 'afterlogin', session: u.searchParams.get('session') }
  }

  // burada://post/2929  veya burada://post?id=2929
  if (u.host === 'post') {
    const pathId = (u.pathname || '').replace('/', '').trim()
    const qId = u.searchParams.get('id')
    const postId = (qId || pathId || '').trim()
    if (!postId) return null
    return { type: 'post', postId }
  }

  return null
}

// Login mekanizmasına dokunmadan route’a gitmek
async function __applyParsedLink(parsed) {
  if (!parsed) return

  // 1) afterlogin (eski davranış)
  if (parsed.type === 'afterlogin') {
    try { await Browser.close() } catch (_) { }

    if (parsed.session) {
      await Preferences.set({ key: 'session', value: parsed.session })
    }

    await router.isReady()
    return router.replace({ name: 'afterlogin' })
  }

  // 2) post
  if (parsed.type === 'post') {
    await router.isReady()
    return router.replace({ name: 'postcontainer', params: { postID: parsed.postId } })
  }
}

// App açıksa anında uygula, kapalıysa biraz geciktir
function __handleDeepLink(url, { coldStart = false } = {}) {
  const parsed = __parseBuradaUrl(url)
  if (!parsed) return

  // App zaten açıkken -> direkt uygula
  if (!coldStart) {
    __applyParsedLink(parsed)
    return
  }

  // Cold start: login/restore akışın kendi kendine çalışsın diye bekletiyoruz.
  // 1) önce session set et (afterlogin ise) - bu login restore’a yardımcı olur
  __pendingDeepLink = parsed

  // Daha önce timer varsa iptal
  if (__deepLinkTimer) clearTimeout(__deepLinkTimer)

  // 2) “deviceready + app mount + session restore” için biraz zaman tanı.
  // Login mekanizmasına dokunmuyoruz; sadece route değişimini geciktiriyoruz.
  __deepLinkTimer = setTimeout(async () => {
    const p = __pendingDeepLink
    __pendingDeepLink = null
    await __applyParsedLink(p)
  }, 1200)
}

// App açıkken gelen linkler
CapApp.addListener('appUrlOpen', ({ url }) => __handleDeepLink(url, { coldStart: false }))

// Cordova fallback
window.handleOpenURL = (url) => __handleDeepLink(url, { coldStart: false })

// App kapalıyken link ile açıldıysa (cold start)
CapApp.getLaunchUrl().then(res => {
  const url = res?.url
  if (url) __handleDeepLink(url, { coldStart: true })
})

window.addEventListener('error', e => console.log('[window.error]', e?.message, e?.error))
window.addEventListener('unhandledrejection', e => console.log('[unhandledrejection]', e?.reason))