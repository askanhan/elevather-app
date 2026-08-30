/* Load Vue Modules */
import { createRouter, createWebHashHistory } from 'vue-router'
/* Store import for auto-logout */
import store from '../store'
import * as globalTypes from '../store/mutation-types.js'
/* Load Global Components */
import Home from '@/components/screens/home/home.vue'
import AfterLoginPage from '@/components/screens/after-login-page/after-login-page.vue'
import Profile from '@/components/screens/profile/profile.vue'
import Notificaties from '@/components/screens/notificaties/notificaties.vue'
import Login from '@/components/screens/login/login.vue'
import Register from '@/components/screens/register/register.vue'
import splashScreen from '../components/screens/splash-screen/splash-screen.vue'
import Feedback from '../components/complementarities/Feedback.vue'
import Course from '../components/complementarities/module/course/course.vue'
import SimulatorHome from '../components/complementarities/simulator/simulatorHome/simulatorHome.vue'
import SimulatorPlay from '../components/complementarities/simulator/simulatorPlay/simulatorPlay.vue'
import Journey from '@/components/complementarities/module/journey/journey.vue'
import StoriesModels from '../components/complementarities/stories/stories.vue'
import EmailLogin from '@/components/screens/email-login/email-login.vue'
import EmailRegister from '@/components/screens/email-register/email-register.vue'
import Goals from '@/components/complementarities/Goals.vue'
import Reflections from '@/components/complementarities/Reflections.vue'
import { i18n } from '@/i18n/index.js'

const routes = [
  
  {
    path: '/',
    name: 'splashscreen',
    component: splashScreen,
    meta: {
      backButtonAvailable: false,
      moduleName: 'splashScreen',
      firstPage: true,
      showHeaderAndNavbar: false
    }
  },
  
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: {
      backButtonAvailable: false,
      moduleName: 'Login',
      firstPage: true,
      showHeaderAndNavbar: false
    }
  },
  {
    path: '/afterlogin',
    name: 'afterlogin',
    component: AfterLoginPage,
    meta: {
      backButtonAvailable: false,
      moduleName: 'AfterLogin',
      firstPage: true,
      showTabs: false,
      showHeaderTitle: false,
      keepAlive: false
    }
  },
  {
    path: '/register',
    name: 'register',
    component: Register,
    meta: {
      backButtonAvailable: false,
      moduleName: 'Register',
      firstPage: true,
      showHeaderAndNavbar: false
    }
  },

  {
    path: '/email-login',
    name: 'email-login',
    component: EmailLogin,
    meta: {
        backButtonAvailable: false,
        moduleName: 'EmailLogin',
        firstPage: true,
        showHeaderAndNavbar: false
    }
  },
  {
    path: '/email-register',
    name: 'email-register',
    component: EmailRegister,
    meta: {
        backButtonAvailable: false,
        moduleName: 'EmailRegister',
        firstPage: true,
        showHeaderAndNavbar: false
    }
  },
  {
    path: '/home',
    name: 'home',
    component: Home,
    meta: {
      keepAlive: true,
      backButtonAvailable: false,
      moduleName: 'General',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/goals',
    name: 'goals',
    component: Goals,
    meta: {
      keepAlive: true,
      backButtonAvailable: true,
      moduleName: 'Goals',
      firstPage: false,
      showTabs: false
    }
  },
  {
    path: '/notifications',
    name: 'notifications',
    component: Notificaties,
    meta: {
      keepAlive: true,
      backButtonAvailable: true,
      moduleName: 'Notifications',
      firstPage: true,
      showHeaderTitle: true,
      showTabs: true
    }
  },
  {
    path: '/reflections',
    name: 'reflections',
    component: Reflections,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'Reflections',
      firstPage: false,
      showHeaderTitle: true,
      showTabs: true
    }
  },

  {
    path: '/profile/:profileID/',
    name: 'profile',
    component: Profile,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      specialButtonAvailable: true,
      moduleName: 'Profile',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/feedback',
    name: 'feedback',
    component: Feedback,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'feedback',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/course',
    name: 'course',
    component: Course,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'course',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/stories',
    name: 'stories',
    component: StoriesModels,
    meta: {
      keepAlive: false,
      backButtonAvailable: false,
      moduleName: 'stories',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/journey',
    name: 'journey',
    component: Journey,
    meta: {
      keepAlive: false,
      backButtonAvailable: false,
      moduleName: 'journey',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/simulator',
    name: 'simulator',
    component: SimulatorHome,
    meta: {
      keepAlive: false,
      backButtonAvailable: false,
      moduleName: 'simulator',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/simulator/play',
    name: 'simulatorplay',
    component: SimulatorPlay,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'simulatorplay',
      firstPage: false,
      showTabs: true
    }
  }
]
const PERSIST_SCROLL_ROUTES = new Set(['home', 'search', 'newslist', 'journey'])

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {

    // Tarayıcı back/forward pozisyonu varsa, istersen kullanmaya devam
    if (savedPosition) {
      return savedPosition
    }

    // Bu sayfalar scroll'u kendisi yönetecek (keep-alive + activated/deactivated)
    if (PERSIST_SCROLL_ROUTES.has(to.name)) {
      return false
    }

    // Diğer tüm sayfalar: SCROLLER ve window hep en başa
    setTimeout(() => {
      const scroller = document.getElementById('SCROLLER')

      if (scroller) {
        scroller.scrollTop = 0
        scroller.scrollLeft = 0
      }

      window.scrollTo(0, 0)
      document.documentElement.scrollTop = 0
      document.body.scrollTop = 0
    }, 0)

    // Vue Router yine de bir değer bekliyor, default 0 veriyoruz
    return { left: 0, top: 0 }
  }
})


// Visitor gate: guests may browse the app, but course content and
// simulators require a real account, except for one free item of each kind
// (mirrors the pick made in journey.js/simulatorHome.js: lowest id for
// simulators, earliest day for modules). This is the enforcement point for
// direct navigation (typed URL, deep link, browser back/forward) - the
// in-page "sign in to continue" prompts on the journey/simulator lists
// are just an earlier, friendlier warning for the same rule.
function freeSimulatorId() {
  const list = store.state.simulators || []
  if (list.length === 0) return null
  return list.slice().sort((a, b) => a.id - b.id)[0].id
}

function freeModuleId() {
  const list = store.state.journeyModules || []
  if (list.length === 0) return null
  return list.slice().sort((a, b) => {
    const dayA = a.day_number || 0
    const dayB = b.day_number || 0
    return dayA !== dayB ? dayA - dayB : a.id - b.id
  })[0].id
}

const GUEST_BLOCKED_ROUTES = new Set(['course', 'simulatorplay'])

router.beforeEach((to, from, next) => {
  if (store.state.guestMode && GUEST_BLOCKED_ROUTES.has(to.name)) {
    const targetId = to.query.id
    const isFreeSimulator = to.name === 'simulatorplay' && String(targetId) === String(freeSimulatorId())
    const isFreeModule = to.name === 'course' && String(targetId) === String(freeModuleId())

    if (!isFreeSimulator && !isFreeModule) {
      try {
        store.commit(globalTypes.SHOW_MESSAGE, i18n.global.t('auth.guestGate.locked'))
      } catch (e) { /* ignore */ }
      next({ name: 'login' })
      return
    }
  }
  next()
})

const scrollPositions = new Map()

// #SCROLLER has no height/overflow of its own, and `<body>`'s own
// `overflow-y: auto` (main.css) clips `<html>` to the viewport, so neither
// `document.scrollingElement`/`documentElement` nor `window.scrollTo` ever
// move — `<body>` is the element that actually scrolls. Detect whichever
// element is truly overflowing instead of hardcoding one, so this keeps
// working if the layout changes later.
function getRealScroller() {
  const candidates = [document.body, document.documentElement, document.getElementById('SCROLLER')]
  return candidates.find(el => el && el.scrollHeight > el.clientHeight) || document.body
}

function getScrollY() {
  return getRealScroller().scrollTop
}

function setScrollY(top) {
  getRealScroller().scrollTop = top
}

router.beforeEach((to, from, next) => {
  if (from?.name && PERSIST_SCROLL_ROUTES.has(from.name)) {
    scrollPositions.set(from.fullPath, { top: getScrollY() })
  }
  next()
})


router.afterEach((to) => {
  // girerken uygula
  requestAnimationFrame(() => {
    if (to?.name && PERSIST_SCROLL_ROUTES.has(to.name)) {
      const pos = scrollPositions.get(to.fullPath)
      setScrollY(pos ? pos.top : 0)
      return
    }

    // Persist olmayan sayfalar: her zaman başa
    setScrollY(0)
  })
})


export default router
