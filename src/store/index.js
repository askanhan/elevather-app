/* global module */
import { createStore } from 'vuex'
import * as getters from './getters'
import * as actionsFromFile from './actions'
import { mutations as mutationsFromFile } from './mutations'
import getDefaultState from './defaultState'

// ==== Notifications persist helpers (KALICI) ====
const NOTIF_KEY = 'notif_v1'
const SEED_FLAG = 'notif_seeded_v1'



// Debug bayrakları (mevcut kodun korunması)
let inDebuggingMode = false
let inNewFeaturesMode = false
if (typeof window !== 'undefined' && window.parent !== undefined) {
  if (window.parent.LOGGING !== undefined) {
    inDebuggingMode = window.parent.LOGGING
  }
  if (window.parent.NEW_FEATURES !== undefined) {
    inNewFeaturesMode = window.parent.NEW_FEATURES
  }
}

let isMobile = false
if (typeof $ !== 'undefined' && $('.on-device')[0] !== undefined) {
  isMobile = true
}


// export const state = JSON.parse(JSON.stringify(initialState))
// state.initialValues = JSON.parse(JSON.stringify(initialState))


// Mevcut mutations/actions ile birleştir
const combinedMutations = { ...mutationsFromFile }
const combinedActions = { ...actionsFromFile }

const store = createStore({
  state: getDefaultState(),
  getters,
  actions: combinedActions,
  mutations: combinedMutations,
  modules: {},
})

// Bildirim mutasyonları çalıştıkça localStorage'a yaz
if (typeof window !== 'undefined' && store && typeof store.subscribe === 'function') {
  store.subscribe((mutation, s) => {
    const watched = [
      'SET_NOTIFICATIONS',
      'ADD_NOTIFICATION',
      'MARK_NOTIFICATION_VIEWED',
      'CLEAR_NOTIFICATIONS',
    ]
    if (watched.includes(mutation.type)) {
      saveNotifs(s.notifications)
    }
  })
}



export default store
