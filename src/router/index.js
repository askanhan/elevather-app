/* Load Vue Modules */
import { createRouter, createWebHashHistory } from 'vue-router'
/* Store import for auto-logout */
import store from '../store'
import * as globalTypes from '../store/mutation-types.js'
/* Load Global Components */
import Home from '@/components/screens/home/home.vue'
import AfterLoginPage from '@/components/screens/after-login-page/after-login-page.vue'
import Search from '@/components/screens/search/search.vue'
import Profile from '@/components/screens/profile/profile.vue'
import Conversations from '@/components/complementarities/Conversations.vue'
import Donate from '@/components/complementarities/donate.vue'
import Notificaties from '@/components/screens/notificaties/notificaties.vue'
import Chat from '@/components/screens/chat/chat.vue'
import Login from '@/components/screens/login/login.vue'
import Register from '@/components/screens/register/register.vue'
import showIcons from '@/components/utils/_show_icons/_show_icons.vue'
import dropdownPage from '@/components/utils/dropdown-page/dropdown-page.vue'
import UpdateProfile from '@/components/screens/update-profile/update-profile.vue'
import selectTag from '@/components/screens/select-tag/select-tag.vue'

import postContainer from '@/components/complementarities/PostContainer.vue'
import Feedback from '../components/complementarities/Feedback.vue'
import Course from '../components/complementarities/Course.vue'
import Story from '../components/complementarities/Story.vue'
import SimulatorHome from '../components/complementarities/SimulatorHome.vue'
import SimulatorPlay from '../components/complementarities/SimulatorPlay.vue'
import Journey from '../components/complementarities/Journey.vue'
import StoriesModels from '../components/complementarities/StoriesModels.vue'

const routes = [
  
  {
    path: '/:pathMatch(.*)*',
    redirect: '/home'
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
    path: '/search',
    name: 'search',
    component: Search,
    meta: {
      keepAlive: true,
      backButtonAvailable: false,
      moduleName: 'Search',
      firstPage: true,
      showTabs: true
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
    path: '/chat/:profileID', // 🔥 parametreli chat
    name: 'chat',
    component: Chat,
    meta: {
      backButtonAvailable: true,
      moduleName: 'Messages',
      firstPage: false,
      showHeaderTitle: true,
      showHeaderAndNavbar: false
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
    path: '/donate',
    name: 'donate',
    component: Donate,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'donate',
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
    path: '/story',
    name: 'story',
    component: Story,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'story',
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
      backButtonAvailable: true,
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
      backButtonAvailable: true,
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
      backButtonAvailable: true,
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
  },
  {
    path: '/conversations',
    name: 'conversations',
    component: Conversations,
    meta: {
      keepAlive: false,
      backButtonAvailable: true,
      moduleName: 'conversations',
      firstPage: true,
      showTabs: true
    }
  },
  {
    path: '/update-profile',
    name: 'updateprofile',
    component: UpdateProfile,
    meta: {
      backButtonAvailable: true,
      moduleName: 'Profile',
      firstPage: true
    }
  },
  {
    path: '/postcontainer/:postID/:specialPostId?',
    name: 'postcontainer',
    component: postContainer,
    meta: {
      backButtonAvailable: true,
      moduleName: 'PostContainer',
      firstPage: true
    }
  }
]
const PERSIST_SCROLL_ROUTES = new Set(['home', 'search', 'newslist'])

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


const scrollPositions = new Map()

function getScroller() {
  return document.getElementById('SCROLLER')
}

router.beforeEach((to, from, next) => {
  const scroller = getScroller()
  if (scroller && from?.name && PERSIST_SCROLL_ROUTES.has(from.name)) {
    scrollPositions.set(from.fullPath, {
      top: scroller.scrollTop,
      left: scroller.scrollLeft
    })
  }
  next()
})


router.afterEach((to) => {
  // girerken uygula
  requestAnimationFrame(() => {
    const scroller = getScroller()
    if (!scroller) return

    if (to?.name && PERSIST_SCROLL_ROUTES.has(to.name)) {
      const pos = scrollPositions.get(to.fullPath)
      if (pos) {
        scroller.scrollTop = pos.top
        scroller.scrollLeft = pos.left
        return
      }
      // ilk kez giriyorsa en baş
      scroller.scrollTop = 0
      scroller.scrollLeft = 0
      return
    }

    // Persist olmayan sayfalar: her zaman başa
    scroller.scrollTop = 0
    scroller.scrollLeft = 0
  })
})


export default router
