// actions.js

// TODO import { TYPE } from "vue-toastification";
import * as types from './mutation-types.js'
import store from '@/store/index.js'
import HF from './help-functions.js'
import * as mutationTypes from '@/store/mutation-types.js'
import router from '@/router/index.js'
import ST from '@/constants/server-types.js'

import * as globalMutationTypes from '@/store/mutation-types.js'

import bao from '@/mixins/basic-operations.js'
const basicOperations = bao.methods

import uit from '@/mixins/ui-text.js'
import moment from "moment";
const uiText = uit.data

const RS = require('@/services/rest.service.js')
const restService = new RS.default()
const helpFunctions = new HF()
const serverTypeConstants = new ST()

import axios from 'axios'
import { authStore } from "@/store/auth.js"
import AppConfig from '@/config/app.config.js'
// --- AXIOS İNSTANSI ---
export const api = axios.create({
  baseURL: AppConfig.API_BASE_URL, // this.$store yok; import edilen store kullan
  withCredentials: false
})

const joinUrl = (base, path) =>
  `${String(base).replace(/\/+$/, '')}/${String(path).replace(/^\/+/, '')}`

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

let refreshInFlight = null // aynı anda tek refresh

// -------------------- ACTIONS --------------------

// Temel verileri arkaplanda getir
export const initializeBasicInfo = async function ({ state }) {
  const { data: categories } = await api.get('/categories')
  store.commit('SET_CATEGORIES', categories)
  const { data: tags } = await api.get('/tags')
  store.commit('SET_TAGS', tags)
  const { data: businesses } = await api.get('/businesses')
  store.commit('SET_BUSINESSES', businesses)
  const { data } = await api.get('/news/latest?limit=10')
  store.commit(types.SET_LATEST_NEWS, data)
  const { data: countries } = await api.get('/countries')
  store.commit('SET_COUNTRIES', countries)
  const { data: provinces } = await api.get('/provinces')
  store.commit('SET_PROVINCES', provinces)
  const { data: towns } = await api.get('/towns')
  store.commit('SET_TOWNS', towns)
  await initializeMyBusinesses({ state })
  getMyNotifications({ state })
  getPosts({ state })
  getFollowings({ state })
  getAllConversations({ state })
  getComingUps({ state })
  getBlockedProfiles({ state })
  getHiddenConversations({ state })
  return true
}


// BLOCKED LIST (GET)
export const getBlockedProfiles = async function ({ state }) {
  console.log('Fetching blocked profiles...')
  const { data } = await api.get('/messages/blocked/')
  // data = { results: [...] }
  console.log(data.results)
  store.commit('SET_BLOCKED_PROFILES', data.results) // store’da mutation yoksa kaldır
  return data.results
}
// HIDDEN CONVERSATIONS (GET)
export const getHiddenConversations = async function ({ state }) {
  console.log('Fetching hidden conversations...')
  const { data } = await api.get('/messages/hidden/')
  // data = { results: [...] }
  console.log(data.results)
  store.commit('SET_HIDDEN_CONVERSATIONS', data.results) // store’da mutation yoksa kaldır
  return data.results
}

export const getMyNotifications = async function ({ state }) {
  const { data: notifications } = await api.get('/notifications/latest')
  store.commit('ADD_MY_NOTIFICATIONS', notifications.results)
  return true
}

export const initializeMyBusinesses = async function ({ state }) {
  const { data: myBusinesses } = await api.get('/businesses/my')
  store.commit('SET_MY_BUSINESSES', myBusinesses)
  return true
}

export const loadAllNews = async function () {
  const { data: news } = await api.get('/news')
  store.commit('SET_ALL_NEWS', news)
  return true
}

// Refresh token ile yeni access üret
export const refreshAccess = async function ({ state }, refresh) {
  const url = joinUrl(AppConfig.API_BASE_URL, '/auth/token/refresh')

  const { data } = await axios.post(url, { refresh }, { withCredentials: false })

  if (!data?.access) throw new Error('No access token returned from refresh')

  window.__ACCESS_TOKEN__ = data.access
  await authStore.setItem('access', data.access)

  if (data.refresh) {
    await authStore.setItem('refresh', data.refresh) // refresh rotation varsa
  }

  // user_id yoksa getMyProfile çağırma (bazı backend'ler dönmez)
  if (data.user_id) {
    await getMyProfile({ state }, data.user_id)
  }

  return true
}

// Kimlik bilgilerini çek
export const getUserDetails = async function ({ state }) {
  const { data: me } = await api.get('/auth/me') // Authorization header interceptor’da ekleniyor
  // await authStore.setItem('user', me)
  await authStore.setItem('user', JSON.stringify(me))
  store.commit('USER_LOGGED_IN', me)
  await getMyProfile({ state }, me.id)
  return true
}

// Kimlik bilgilerini çek
export const logout = async function () {
  try {
    await api.post('/auth/logout')
  } catch (e) {
    // backend patlasa bile client logout devam etsin
  }

  // önce tokenları tek tek sil
  try {
    await authStore.removeItem('access')
    await authStore.removeItem('refresh')
    await authStore.removeItem('me')
    await authStore.removeItem('myProfile')
    await authStore.removeItem('myBusinesses')
    // sende başka auth keyleri varsa ekle
  } catch (e) { }

  // sonra komple temizle
  try {
    await authStore.clear()
  } catch (e) { }

  // vuex state'i temizle (persist varsa burada durduracak şekilde)
  store.commit('LOGGED_OUT')

  // son olarak yönlendir
  router.replace({ name: "splash" })

  return true
}

export const getMyProfile = async function ({ state }, user_id) {
  const { data: profile } = await api.get('profile/by-user/' + user_id) // Authorization header interceptor’da ekleniyor
  store.commit('SET_MY_PROFILE', profile)
  return true
}

export const fetchPostById = async function ({ state }, id) {
  const { data: post } = await api.get('posts/' + id) // Authorization header interceptor’da ekleniyor
  return post
}


export const getBusinessPosts = async function ({ state }, { businessId, successCB, errorCB }) {
  try {
    console.log('Fetching posts for business ID:', businessId)
    const { data: post } = await api.get('posts?business=' + businessId) // Authorization header interceptor’da ekleniyor
    if (successCB) successCB(post.results);
    return true;
  } catch (error) {
    if (errorCB) errorCB(error);
    return false;
  }
}

export const getMessagesOfConversation = async function ({ state }, payload) {
  console.log('Fetching messages for conversation with profile ID:', payload.profileId)
  const { data: messages } = await api.get('/messages/conversation/' + payload.profileId + '/') // Authorization header interceptor’da ekleniyor
  return messages
}

export const sendMessage = async function ({ state }, payload) {
  console.log('Sending message to profile ID:', payload)
  await api.post('/messages/send/' + payload.to_profile + '/', { content: payload.content, type: 0 })
  // await api.post('/messages/send/' + payload.to_profile + '/', payload.content) // Authorization header interceptor’da ekleniyor
  return true
}

export const getAllConversations = async function ({ state }, profile_id) {
  const { data: conversations } = await api.get('/messages/conversations' + '/') // Authorization header interceptor’da ekleniyor
  console.log(conversations.results)
  store.commit('SET_ALL_CONVERSATIONS', conversations.results)
  return true
}

export const getComingUps = async function ({ state }, profile_id) {
  const { data: comingups } = await api.get('/coming-ups') // Authorization header interceptor’da ekleniyor
  console.log(comingups.results)
  store.commit('SET_COMING_UPS', comingups.results)
  return true
}

export const getMyPosts = async function ({ state }, id) {
  const { data: posts } = await api.get('posts/mine') // Authorization header interceptor’da ekleniyor
  store.commit('SET_MY_POSTS', posts.results)
  return true
}

export const getMyBookmarks = async function ({ state }, id) {
  const { data: bookmarks } = await api.get('posts/bookmarks') // Authorization header interceptor’da ekleniyor
  store.commit('SET_MY_BOOKMARKS', bookmarks.results)
  return true
}

export const notificationIsSeen = async function ({ state }, id) {
  const { data } = await api.put(`/notifications/${id}/seen`)
  store.commit('MARK_NOTIFICATION_VIEWED', id)
  return true
}

export const getPosts = async function ({ state }, user) {
  const { data: posts } = await api.get('posts') // Authorization header interceptor’da ekleniyor
  store.commit('ADD_POSTS', { posts: posts.results })
  return true
}

export const loadOlderPosts = async function ({ state }, user) {
  let minPostId = Math.min(...state.posts.map(post => post.id));
  if (Number.isFinite(minPostId) && minPostId > 0) {
    const { data: olderPosts } = await api.get('posts/older?before_id=' + minPostId) // Authorization header interceptor’da ekleniyor
    store.commit('ADD_POSTS', { posts: olderPosts.results, toFront: false })
    return olderPosts.results.length
  }
  return 0
}

export const getNewPosts = async function ({ state }, user) {
  let maxPostId = Math.max(...state.posts.map(post => post.id));
  if (Number.isFinite(maxPostId) && maxPostId > 0) {
    const { data: newPosts } = await api.get('posts/new?after_id=' + maxPostId); // Authorization header interceptor’da ekleniyor
    store.commit('ADD_POSTS', { posts: newPosts.results, toFront: true })
    return newPosts.results.length
  }
  return 0
}

export const getFollowings = async function ({ state }) {
  const { data: followings } = await api.get('follows/following')
  store.commit('SET_FOLLOWINGS', followings.results)
  return true
}

export const votePostPoll = async function ({ state }, payload) {
  let postId = payload.postId
  delete payload.post_id
  await api.post(`posts/${postId}/answer`, payload)
  return true
}



export const HighlightRequest = async function ({ state }, payload) {
  await api.post(`highlight-requests`, payload)
  return true
}

export const follow = async function ({ state }, profile_id) {
  await api.post(`profiles/${profile_id}/follow-toggle`)
  await getFollowings({ state })
  return true
}

export const unfollow = async function ({ state }, profile_id) {
  await api.delete(`profiles/${profile_id}/follow-toggle`)
  await getFollowings({ state })
  return true
}

export const getBusinessDetails = async function ({ state }, { businessId, successCB, errorCB }) {
  try {
    // if (Array.isArray(state.businessDetails) && state.businessDetails.some(business => business.id == businessId)) {
    //   const business = state.businessDetails.find(business => business.id == businessId);
    //   if (successCB) successCB(business);
    //   return true;
    // }
    const { data: businessDetails } = await api.get(`businesses/${businessId}`); // Authorization header interceptor’da ekleniyor
    store.commit('SET_BUSINESS_DETAILS', businessDetails);
    if (successCB) successCB(businessDetails);
    return true;
  } catch (error) {
    if (errorCB) errorCB(error);
    return false;
  }
}

export const getProfileDetails = async function ({ state }, { profileID, successCB, errorCB }) {
  try {
    console.log(state.profileDetails)
    if (Array.isArray(state.profileDetails) && state.profileDetails.some(profile => profile.id == profileID)) {
      const profile = state.profileDetails.find(profile => profile.id == profileID);
      if (successCB) successCB(profile);
      return true;
    }
    const { data: profileDetails } = await api.get(`profile/${profileID}`) // Authorization header interceptor’da ekleniyor
    store.commit('SET_PROFILE_DETAILS', profileDetails)
    if (successCB) successCB(profileDetails)
    return true
  } catch (error) {
    if (errorCB) errorCB(error)
    return false
  }
}

export const uploadBusinessLogo = async ({ state }, file) => {
  if (!file) return null

  const formData = new FormData()
  formData.append('file', file)

  const res = await api.post('/upload/business-logo', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })

  // backend ne dönüyorsa ona göre:
  return res?.data?.url || res?.data?.path || null
}

export const uploadPostMedia = async ({ state }, file) => {
  if (!file) return null

  const formData = new FormData()
  formData.append('file', file)

  const res = await api.post('/upload/post-media', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })

  // backend ne dönüyorsa ona göre:
  return res?.data?.url || res?.data?.path || null
}

export const createBusiness = async ({ state }, payload) => {
  const res = await api.post('/businesses/create', payload)
  await initializeMyBusinesses({ state })
  return res.id
}

export const createPost = async ({ state }, payload) => {
  const res = await api.post('/posts/create', payload)
  return res
}

export const profileViewed = async ({ }, profileID) => {
  if (!profileID) return
  // backend: /posts/<id>/viewed/ gibi
  await api.post(`/profile/${profileID}/viewed`)
}

export const markPostViewed = async ({ }, postId) => {
  if (!postId) return
  // backend: /posts/<id>/viewed/ gibi
  await api.post(`/posts/${postId}/viewed`)
}

export const togglePostLike = async ({ }, post) => {
  console.log('Toggling like for post:', post.id)
  const res = await api.post('/posts/' + post.id + '/like')
  return res
}

export const togglePostBookmark = async ({ }, post) => {
  const res = await api.post('/posts/' + post.id + '/bookmark')
  return res
}

export const createPostComment = async ({ }, payload) => {
  const res = await api.post(`/posts/${payload.postId}/comment`, {
    comment: payload.text,
  })
  return res.data   // <<< önemli kısım
}

export const reportPost = async ({ }, payload) => {
  const res = await api.post(`/posts/${payload.post.id}/report`, {
    report_type: payload.reason,
  })
  return res.data   // <<< önemli kısım
}

export const deletePost = async ({ }, id) => {
  const res = await api.delete('/posts/' + id + '/delete')
  return res
}

export const deletePostComment = async ({ }, commentId) => {
  const res = await api.delete('/comments/' + commentId)
  return res
}

export const updateBusiness = async ({ state }, { id, payload }) => {
  const res = await api.put(`/businesses/${id}/update`, payload)
  await initializeMyBusinesses({ state })
  return res
}



export const businessClaim = async ({ }, payload) => {
  const res = await api.post(`/business-claims/create`, payload)
  return res.data
}

export const createFeedback = async ({ }, payload) => {
  const res = await api.post(`/feedback/create`, payload)
  return res.data
}



// BLOCK (POST)
export const blockProfile = async function ({ state }, profileId) {
  console.log('Blocking profile ID:', profileId)
  const current = Array.isArray(state.blockedProfiles) ? state.blockedProfiles : []
  const exists = current.some(item => (item && typeof item === 'object') ? item.id === profileId : item === profileId)
  if (!exists) {
    store.commit('SET_BLOCKED_PROFILES', [...current, profileId])
  }
  const { data } = await api.post('/messages/blocked/' + profileId + '/')
  // data = { status:"ok", blocked:true, profile_id:..., created:... }
  return data
}

// UNBLOCK (DELETE)
export const unblockProfile = async function ({ state }, profileId) {
  console.log('Unblocking profile ID:', profileId)
  const { data } = await api.delete('/messages/blocked/' + profileId + '/')
  // data = { status:"ok", blocked:false, profile_id:... }
  return data
}


// HIDE CONVERSATION (POST)
export const hideConversation = async function ({ state }, otherProfileId) {
  console.log('Hiding conversation with profile ID:', otherProfileId)
  const { data } = await api.post('/messages/hidden/' + otherProfileId + '/')
  // data = { status:"ok", hidden:true, other_profile_id:..., created:... }
  return data
}

// UNHIDE CONVERSATION (DELETE)
export const unhideConversation = async function ({ state }, otherProfileId) {
  console.log('Unhiding conversation with profile ID:', otherProfileId)
  const { data } = await api.delete('/messages/hidden/' + otherProfileId + '/')
  // data = { status:"ok", hidden:false, other_profile_id:... }
  return data
}



export const updateProfile = async function ({ commit }, { id, payload }) {
  try {
    const res = await api.put(`/profile/${id}/update`, payload, {
      headers: {
        'Content-Type': 'application/json'
      }
    })

    // İstersen store’a da yaz
    // commit('SET_PROFILE_DETAILS', res.data)

    return res.status === "ok"
  } catch (err) {
    console.error('updateProfile error:', err)
    throw err
  }
}

// -------------------- İNTERCEPTORLAR --------------------

// İstekten önce access ekle; yoksa refresh dene
api.interceptors.request.use(async (config) => {
  // refresh endpoint'inde intercept yapma
  if (config?.url && String(config.url).includes('/auth/token/refresh')) {
    return config
  }

  // access yoksa refresh dene (max 3)
  if (!window.__ACCESS_TOKEN__) {
    const refresh = await authStore.getItem('refresh')

    if (refresh) {
      if (!refreshInFlight) {
        refreshInFlight = (async () => {
          const delays = [0, 600, 1500] // 3 deneme, aralıklı
          let lastErr = null

          for (let i = 0; i < delays.length; i++) {
            if (delays[i]) await sleep(delays[i])
            try {
              await store.dispatch('refreshAccess', refresh)
              return true
            } catch (e) {
              lastErr = e
            }
          }
          throw lastErr
        })().finally(() => {
          refreshInFlight = null
        })
      }

      try {
        await refreshInFlight
      } catch (e) {
        // refresh patladıysa token eklemeye çalışma
      }
    }
  }

  if (window.__ACCESS_TOKEN__) {
    config.headers = config.headers || {}
    config.headers.Authorization = `Bearer ${window.__ACCESS_TOKEN__}`
  }

  return config
})

// 401 dönerse bir kez daha refresh dene, sonra aynı isteği tekrar et
api.interceptors.response.use(
  (res) => res,
  async (error) => {
    const status = error?.response?.status
    const original = error?.config || {}
    const url = String(original.url || '')

    // refresh isteği 401 döndüyse: artık bırak, logout
    if (url.includes('/auth/token/refresh')) {
      await authStore.removeItem('refresh')
      await authStore.removeItem('access')
      window.__ACCESS_TOKEN__ = null
      location.href = '/#/login'
      return Promise.reject(error)
    }

    if (status === 401 && !original.__isRetryRequest) {
      original.__isRetryRequest = true

      const refresh = await authStore.getItem('refresh')
      if (!refresh) {
        location.href = '/#/login'
        return Promise.reject(error)
      }

      // refresh lock ile tek refresh
      if (!refreshInFlight) {
        refreshInFlight = (async () => {
          const delays = [0, 600, 1500]
          let lastErr = null
          for (let i = 0; i < delays.length; i++) {
            if (delays[i]) await sleep(delays[i])
            try {
              await store.dispatch('refreshAccess', refresh)
              return true
            } catch (e) {
              lastErr = e
            }
          }
          throw lastErr
        })().finally(() => {
          refreshInFlight = null
        })
      }

      try {
        await refreshInFlight
        original.headers = original.headers || {}
        original.headers.Authorization = `Bearer ${window.__ACCESS_TOKEN__}`
        return api.request(original)
      } catch (e) {
        // refresh 3 kez fail → clean + login
        await authStore.removeItem('refresh')
        await authStore.removeItem('access')
        window.__ACCESS_TOKEN__ = null
        location.href = '/#/login'
      }
    }

    return Promise.reject(error)
  }
)