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

// Cache tracking (without mutations)
let cachedCourseCardsModuleId = null
let cachedSimulatorCardsSimulatorId = null

// -------------------- ACTIONS --------------------

//fetching cards for a module
export const fetchCourseCards = async function ({ state }, moduleId) {
  // Return cached cards if already loaded for THIS moduleId
  if (cachedCourseCardsModuleId === moduleId && state.courseCards.length > 0) return true
  const { data } = await api.get(`/module/${moduleId}/cards-full/`)
  if (!data?.cards?.length) throw new Error('No cards found')
  store.commit(types.SET_COURSE_CARDS_FOR_MODULE, { moduleId, cards: data.cards })
  store.commit(types.SET_COURSE_CARDS, data.cards)
  cachedCourseCardsModuleId = moduleId // Update cache tracking
  return true
}
//fetching statuses for tracks page filter based on statuses
export const fetchJourneyProgressStatuses = async function ({ state }) {
  if (state.journeyStatuses.length > 0) return true
  const { data } = await api.get('/progress-statuses/')
  store.commit(types.SET_JOURNEY_STATUSES, data)
  return true
}
//fetching data (categories and modules) for tracks page
export const fetchJourneyData = async function ({ state }) {
  if (state.journeyModules.length > 0) return true
  const [categoriesRes, modulesRes] = await Promise.all([
    api.get('/categories/'),
    api.get('/all-modules/')
  ])
  store.commit(types.SET_JOURNEY_CATEGORIES, categoriesRes.data)
  store.commit(types.ADD_JOURNEY_MODULES, Array.isArray(modulesRes.data) ? modulesRes.data : modulesRes.data.results || [])
  return true
}
//fetching simulator levels for filter based on levels
export const fetchSimulatorLevels = async function ({ state }) {
  if (state.simulatorLevels.length > 0) return true
  const { data } = await api.get('/sim-levels/')
  store.commit(types.SET_SIMULATOR_LEVELS, data)
  return true
  
}
//fetching simulators for simulators page
export const fetchSimulators = async function ({ state }) {
  if (state.simulators.length > 0) return true
  const { data } = await api.get('/all-simulators/')
  if (!data?.length) throw new Error('No simulators found')
  const transformed = data.map(sim => ({
    id: sim.id,
    icon: '🎯',
    title: sim.title,
    description: sim.description || '',
    level: sim.level || 'N/A',
    duration: sim.estimated_duration ? `${sim.estimated_duration} min` : 'N/A',
    domain: sim.localisation || 'General',
    tags: (sim.tags || []).map(tag => typeof tag === 'object' ? tag.name : tag)
  }))
  store.commit(types.SET_SIMULATORS, transformed)
  return true
}
//fetching cards for a simulator
export const fetchSimulatorCards = async function ({ state }, simulatorId) {
  // Return cached cards if already loaded for THIS simulatorId
  if (cachedSimulatorCardsSimulatorId === simulatorId && state.simulatorCards.length > 0) return true
  const { data: cardsData } = await api.get(`/simulator/${simulatorId}/cards-full/`)
  if (!cardsData?.cards?.length) {
    store.commit(types.SET_SIMULATOR_CARDS, [])
    return false
  }
  store.commit(types.SET_SIMULATOR_CARDS_FOR_SIMULATOR, { simulatorId, cards: cardsData.cards })
  store.commit(types.SET_SIMULATOR_CARDS, cardsData.cards)
  cachedSimulatorCardsSimulatorId = simulatorId // Update cache tracking
  return true
}
//fetching tags for a simulator
export const fetchSimulatorTags = async function ({ state }, simulatorId) {
  const { data } = await api.get(`/simulator/${simulatorId}/tags/`)
  store.commit(types.SET_SIMULATOR_TAGS, data || [])
  return true
}
//fetching metrics for a simulator
export const fetchSimulatorMetrics = async function ({ state }, simulatorId) {
  const { data } = await api.get(`/simulator/${simulatorId}/metrics/`)
  const metricsData = Array.isArray(data) ? data : (data?.results || data?.metrics || [])
  store.commit(types.SET_SIMULATOR_METRICS, metricsData)
  return true
}

// Reset all simulator scores to 50 when entering a simulator
export const resetSimulatorMetrics = async function ({ state }, simulatorId) {
  try {
    const userId = state.user?.id 
    console.log(`🔄 Resetting metrics for user ${userId}, simulator ${simulatorId}`)
    
    // Call backend endpoint to reset all scores to 50
    const { data } = await api.post(`/user/${userId}/simulator/${simulatorId}/reset-scores/`)
    
    console.log(`✅ Metrics reset successfully:`, data)
    return true
  } catch (err) {
    console.error('⚠️ Error resetting metrics:', err.message)
    // Still return true to allow navigation to continue
    return true
  }
}

// fetching and saving simulator results for a user (combined fetch + save)
export const fetchSimulatorResults = async function ({ state, commit }, { userId, simulatorId }) {
  try {
    console.log(`📥 Fetching simulator results: userId=${userId}, simulatorId=${simulatorId}`)
    const { data } = await api.get(`/user/${userId}/simulator/${simulatorId}/results/`)
    
    // Build result object to save
    const result = {
      id: Date.now(),
      simulatorId: simulatorId,
      userId: userId,
      ...data  // Contains feedbacks and other data
    }
    
    // Save to store
    store.commit(types.ADD_SIMULATOR_RESULT, result)
    
    return data  // Return API data for components to use
  } catch (error) {
    console.error('Error fetching simulator results:', error)
    throw error
  }
}

//fetching questions for daily check-in
export const fetchDailyCheckinQuestions = async function ({ state }, userId) {
  try {
    const { data } = await api.get(`/daily-checkin/questions/?user_id=${userId}`)
    // Backend now returns { questions: [...], is_today_response: boolean, message: string }
    if (!data || !data.questions || !Array.isArray(data.questions)) {
      throw new Error('Invalid daily checkin questions format.')
    }
    store.commit(types.SET_DAILY_CHECKIN_QUESTIONS, data.questions)
    return {
      questions: data.questions,
      isTodayResponse: data.is_today_response,
      message: data.message
    }
  } catch (error) {
    console.error('Error fetching daily checkin questions:', error)
    throw error
  }
}

//updating user progress for a module/simulator
export const updateUserProgress = async function ({ state, dispatch }, { userId, ownerType, ownerId, status }) {
  try {
    const payload = {
      user_id: userId,
      owner_type: ownerType,
      owner_id: ownerId,
      status: status
    }
    console.log('Sending progress update:', payload)
    const { data } = await api.post('/user/progress/update/', payload)
    // Update local state with new status
    store.commit(types.UPDATE_MODULE_STATUS, { moduleId: ownerId, status: status })
    // Reload user progress to ensure profile page sees the update
    await dispatch('fetchUserProgress', userId)
    return true
  } catch (error) {
    console.error('Error updating user progress:', error)
    throw error
  }
}

//fetching user progress for a specific user
export const fetchUserProgress = async function ({ state }, userId) {
  try {
    const { data } = await api.get(`/user/${userId}/progress/`)
    store.commit(types.SET_USER_PROGRESS, data)
    // Synchronize module statuses with user progress
    if (Array.isArray(data)) {
      data.forEach(item => {
        if (item.owner_type === 'module') {
          store.commit(types.UPDATE_MODULE_STATUS, { moduleId: item.owner_id, status: item.status })
        }
      })
    }
    return true
  } catch (error) {
    console.error('Error fetching user progress:', error)
    throw error
  }
}

//saving MCQ response for a course question
export const saveMCQResponse = async function ({ state }, { userId, selectedOptionId }) {
  try {
    const payload = {
      user_id: userId,
      selected_option_id: selectedOptionId
    }
    console.log('Sending MCQ response:', payload)
    const { data } = await api.post('/user/response/mcq/', payload)
    
    // Store the response in state
    store.commit(types.SET_MCQ_RESPONSE, {
      userId: userId,
      optionId: selectedOptionId,
      feedback: data.feedback,
      updatedMetrics: data.updated_metrics
    })
    
    return {
      feedback: data.feedback,
      updatedMetrics: data.updated_metrics
    }
  } catch (error) {
    console.error('Error saving MCQ response:', error)
    throw error
  }
}

//saving MCQ response for a simulator question
export const saveSimulatorMCQResponse = async function ({ state }, { userId, selectedOptionId, simulatorId }) {
  try {
    const payload = {
      user_id: userId,
      selected_option_id: selectedOptionId
    }
    console.log('Sending simulator MCQ response:', payload)
    const { data } = await api.post('/user/response/mcq/', payload)
    
    // Update the simulator metrics in state with the new scores
    if (data.updated_metrics && Array.isArray(data.updated_metrics)) {
      // Create a map indexed by metric name for accurate lookups
      const updatedMetricsMap = {}
      
      data.updated_metrics.forEach(metric => {
        // Backend sends: {metric: 'Authority', new_score: 35}
        // Support both formats for flexibility
        const metricName = metric.metric_name || metric.name || metric.metric
        const newScore = metric.new_score || metric.score
        
        // Index by the metric name
        if (metricName) {
          updatedMetricsMap[metricName] = newScore
          console.log(`✅ Metric: ${metricName} → New Score: ${newScore}`)
        }
      })
      
      // Update metrics in state, matching by metric name
      store.commit(types.SET_SIMULATOR_METRICS, 
        state.simulatorMetrics.map(m => ({
          ...m,
          value: updatedMetricsMap[m.name] !== undefined 
            ? updatedMetricsMap[m.name] 
            : m.value
        }))
      )
    }
    
    return {
      feedback: data.feedback,
      updatedMetrics: data.updated_metrics
    }
  } catch (error) {
    console.error('Error saving simulator MCQ response:', error)
    throw error
  }
}

//saving open question response for a course question
export const saveOpenQuestionResponse = async function ({ state }, { userId, openQuestionId, answerText }) {
  try {
    const payload = {
      user_id: userId,
      open_question_id: openQuestionId,
      answer_text: answerText
    }
    console.log('Sending open question response:', payload)
    const { data } = await api.post('/user/response/open-question/', payload)
    
    // Store the response in state
    store.commit(types.SET_OPEN_QUESTION_RESPONSE, {
      userId: userId,
      openQuestionId: openQuestionId,
      answerText: answerText,
      responseId: data.id
    })
    
    return {
      id: data.id,
      linkedToQuestion: data.linked_to_question
    }
  } catch (error) {
    console.error('Error saving open question response:', error)
    throw error
  }
}

//submitting daily checkin responses
export const submitDailyCheckin = async function ({ state }, { userId, optionIds }) {
  try {
    const payload = {
      user_id: userId,
      option_ids: optionIds
    }
    console.log('Submitting daily checkin:', payload)
    const { data } = await api.post('/daily-checkin/submit/', payload)
    
    // Store the responses in state
    store.commit(types.SET_DAILY_CHECKIN_RESPONSES, {
      responses: optionIds.map(id => ({ option_id: id })),
      powerLevel: data.power_level
    })
    
    return {
      powerLevel: data.power_level,
      status: data.status,
      message: data.message
    }
  } catch (error) {
    console.error('Error submitting daily checkin:', error)
    throw error
  }
}
// -------------------- STORIES --------------------

// Fetch story categories (tracks)
export const fetchStoryCategories = async function ({ state }) {
  try {
    if (state.storyCategories && state.storyCategories.length > 0) {
      return state.storyCategories
    }
    
    const { data } = await api.get('/categories/')
    console.log('🔵 [fetchStoryCategories] Fetched categories:', data)
    store.commit('SET_STORY_CATEGORIES', data)
    
    return data
  } catch (error) {
    console.error('❌ [fetchStoryCategories] Error:', error)
    throw error
  }
}

// Fetch story tags
export const fetchStoryTags = async function ({ state }) {
  try {
    if (state.storyTags && state.storyTags.length > 0) {
      return state.storyTags
    }
    
    const { data } = await api.get('/story-tags/')
    console.log('🔵 [fetchStoryTags] Fetched tags:', data)
    store.commit('SET_STORY_TAGS', data)
    
    return data
  } catch (error) {
    console.error('❌ [fetchStoryTags] Error:', error)
    throw error
  }
}

// Build mapping from categories (dynamic)
function buildTrackMapping(categories) {
  const mapping = {}
  if (Array.isArray(categories)) {
    categories.forEach(cat => {
      mapping[cat.name || cat.title] = cat.id
    })
  }
  return mapping
}

// Mapping for context names to localisation IDs (static for now)
const CONTEXT_TO_LOCALISATION_ID = {
  'Work': 1,
  'Family': 2,
  'Community': 3,
  'Self': 4
}

// Mapping for localisation IDs back to names (reverse)
const LOCALISATION_ID_TO_TEXT = {
  1: 'Work',
  2: 'Family',
  3: 'Community',
  4: 'Self'
}

// Fetch all stories with optional filters
export const fetchAllStories = async function ({ state }, { categoryId = null, userId = null, viewerId = null }) {
  try {
    let url = '/stories/'
    const params = []
    
    if (categoryId) params.push(`category_id=${categoryId}`)
    if (userId) params.push(`user_id=${userId}`)
    if (viewerId) params.push(`viewer_id=${viewerId}`)
    
    if (params.length > 0) {
      url += '?' + params.join('&')
    }
    
    const { data } = await api.get(url)
    store.commit(types.SET_ALL_STORIES, data)
    return true
  } catch (error) {
    console.error('fetchAllStories error:', error)
    throw error
  }
}

// Fetch stories for a specific user
export const fetchUserStories = async function ({ state }, { userId, viewerId = null }) {
  try {
    const { data } = await api.get(`/stories/?user_id=${userId}${viewerId ? `&viewer_id=${viewerId}` : ''}`)
    store.commit(types.SET_USER_STORIES, data)
    return true
  } catch (error) {
    console.error('fetchUserStories error:', error)
    throw error
  }
}

// Fetch stories for a specific user
export const getGoalsAndMissions = async function ({ state }, { userId, viewerId = null }) {
  try {
    const [goalsRes, missionRes] = await Promise.all([
      api.get(`/user/${userId}/goals/`),
      api.get(`/user/${userId}/mission/`),
  ])
    // store.commit(types.SET_CATEGORY_STORIES, data)
    return [goalsRes, missionRes]
  } catch (error) {
    console.error('fetchUserStories error:', error)
    throw error
  }
}

// Fetch stories by category
export const fetchStoriesByCategory = async function ({ state }, { categoryId, viewerId = null }) {
  try {
    const { data } = await api.get(`/stories/?category_id=${categoryId}${viewerId ? `&viewer_id=${viewerId}` : ''}`)
    store.commit(types.SET_CATEGORY_STORIES, data)
    return true
  } catch (error) {
    console.error('fetchStoriesByCategory error:', error)
    throw error
  }
}

// Toggle a reaction to a story (create/update/delete)
export const toggleStoryReaction = async function ({ state, commit }, { storyId, reactionType, userId }) {
  try {
    const payload = {
      story_id: storyId,
      reaction_type: reactionType,
      user_id: userId
    }
    
    const { data } = await api.post('/stories/react/', payload)
    
    // Backend returns action: 'created', 'updated', or 'deleted'
    // The component handles state updates directly, so just return the response
    
    return data
  } catch (error) {
    console.error('toggleStoryReaction error:', error)
    throw error
  }
}

// Create a new story
export const createStory = async function ({ state }, { userId, content, track, context, tags, authorName = 'Anonymous' }) {
  try {
    // Build dynamic mapping from fetched categories
    const categories = state.storyCategories || []
    const trackMapping = {}
    categories.forEach(cat => {
      trackMapping[cat.name || cat.title] = cat.id
    })
    
    // Convert track string to category_id number
    const categoryId = trackMapping[track]
    const finalCategoryId = categoryId !== undefined ? categoryId : (categories.length > 0 ? categories[0].id : 1)
    
    // Send context string directly (not converted to number)
    // Backend will store the text value (e.g., "Community" not 3)
    const contextStr = String(context)
    
    const payload = {
      user_id: userId,
      author_name: authorName,
      category_id: finalCategoryId,
      localisation: contextStr,
      content: content,
      tags: tags // Array of tag IDs or tag names
    }
    const response = await api.post('/stories/create/', payload)
    const { data } = response
    
    // Refresh stories after creating
    await fetchAllStories({ state }, { viewerId: userId })
    
    // Return the created story for tracking
    return data || { id: null }
  } catch (error) {
    console.error('❌ [createStory] ERROR:', error.message)
    console.error('❌ [createStory] Full error object:', error)
    if (error.response) {
      console.error('❌ [createStory] Response status:', error.response.status)
      console.error('❌ [createStory] Response data:', error.response.data)
      console.error('❌ [createStory] Response headers:', error.response.headers)
    }
    throw error
  }
}

// Delete a story
export const deleteStory = async function ({ state }, { storyId, userId }) {
  try {
    await api.delete(`/stories/${storyId}/delete/?user_id=${userId}`)
    
    // Refresh stories after deleting
    await fetchAllStories({ state }, { viewerId: userId })
    
    return true
  } catch (error) {
    console.error('deleteStory error:', error)
    throw error
  }
}

// Fetch pending stories for the current user (unpublished stories)
// Fetch pending stories for the current user (unpublished stories awaiting moderation)
export const fetchPendingStories = async function ({ state }, userId) {
  try {
    // Fetch all pending stories from the moderation queue
    // Backend returns all unpublished stories, we filter by user_id on frontend
    const { data } = await api.get(`/stories/pending/`)
    
    // Filter to show only current user's pending stories
    const userPendingStories = Array.isArray(data) ? data.filter(story => story.user_id === userId) : []
    store.commit(types.SET_PENDING_STORIES, userPendingStories)
    return true
  } catch (error) {
    console.error('fetchPendingStories error:', error)
    // If endpoint doesn't exist, just set empty pending stories
    store.commit(types.SET_PENDING_STORIES, [])
    return true
  }
}















// Temel verileri arkaplanda getir
export const initializeBasicInfo = async function ({ state }) {
  // const { data: categories } = await api.get('/categories')
  // store.commit('SET_CATEGORIES', categories)
  // const { data: tags } = await api.get('/tags')
  // store.commit('SET_TAGS', tags)
  // const { data: businesses } = await api.get('/businesses')
  // store.commit('SET_BUSINESSES', businesses)
  // const { data } = await api.get('/news/latest?limit=10')
  // store.commit(types.SET_LATEST_NEWS, data)
  // const { data: countries } = await api.get('/countries')
  // store.commit('SET_COUNTRIES', countries)
  // const { data: provinces } = await api.get('/provinces')
  // store.commit('SET_PROVINCES', provinces)
  // const { data: towns } = await api.get('/towns')
  // store.commit('SET_TOWNS', towns)
  // await initializeMyBusinesses({ state })
  // getMyNotifications({ state })
  // getPosts({ state })
  // getFollowings({ state })
  // getAllConversations({ state })
  // getComingUps({ state })
  // getBlockedProfiles({ state })
  // getHiddenConversations({ state })
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
  // await getMyProfile({ state }, me.id)
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

// ============ AUDIO ============
export const fetchAudioForCard = async function ({ state, commit }, { ownerType, ownerId }) {
  const key = `${ownerType}-${ownerId}`
  
  // Check cache first
  if (state.audioCache[key]) {
    return state.audioCache[key].url
  }

  try {
    const response = await api.get(
      `/audio/fetch/${ownerType}/${ownerId}/`
    )

    const audioUrl = response.data.audio_url || response.data.url
    if (!audioUrl) {
      throw new Error('No audio URL in response')
    }

    // Cache it in Vuex
    commit('AUDIO_CARD_FETCHED', { key, url: audioUrl })

    return audioUrl
  } catch (error) {
    console.error(`[fetchAudioForCard] Failed to fetch audio for ${key}:`, error)
    throw error
  }
}

export const updateProfile = async function ({ state }, { id, payload }) {
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