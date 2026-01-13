
import * as types from './mutation-types.js'
import HF from './help-functions.js'
import Vue from 'vue'
import iconsMixin from '@/mixins/icons.js'
import getDefaultState from './defaultState'

const icons = iconsMixin.data().icons
const helpFunctions = new HF()

/* global $  */
export const mutations = {

  [types.LOCK_SCREEN](state, params) {
    let timing = 5000
    var doNotAutoEnable = null
    var customTimingScreenDisabled = null
    if (!_.isEmpty(params)) {
      doNotAutoEnable = params.doNotAutoEnable
      customTimingScreenDisabled = params.customTimingScreenDisabled
    }
    if (doNotAutoEnable) {
      state.flags.screenDisabled = true
      state.flags.screenLocked = true
    } else if (customTimingScreenDisabled > 0) {
      timing = customTimingScreenDisabled
      state.flags.screenDisabled = true
    } else {
      state.flags.screenLocked = true
    }
    if (!doNotAutoEnable) {
      setTimeout(function () {
        if (state.flags.screenLocked) {
          state.flags.screenLocked = false
        }
        if (state.flags.screenDisabled) {
          state.flags.screenDisabled = false
        }
      }, timing)
    }
  },
  [types.UNLOCK_SCREEN](state) {
    state.flags.screenLocked = false
    state.flags.screenDisabled = false
  },

  [types.SHOW_MESSAGE](state, params) {
    $('#TOAST-MESSAGE-BOX').stop()
    $('#TOAST-MESSAGE-BOX').css('display', 'none')
    if (typeof params === 'string') {
      state.showedMessage = params
      $('#TOAST-MESSAGE-BOX').text(params)
      $('#TOAST-MESSAGE-BOX')
        .fadeIn(400)
        .delay(1000)
        .fadeOut(400)
    } else {
      state.showedMessage = params[0]
      $('#TOAST-MESSAGE-BOX').text(params[0])
      if (params[1] === 'error') {
        if (params[2] > 0) {
          $('#TOAST-MESSAGE-BOX')
            .fadeIn(400)
            .delay(params[2])
            .fadeOut(400)
        } else {
          $('#TOAST-MESSAGE-BOX')
            .fadeIn(400)
            .delay(2000)
            .fadeOut(400)
        }
      } else if (params[1] === 'long') {
        $('#TOAST-MESSAGE-BOX')
          .fadeIn(400)
          .delay(4000)
          .fadeOut(400)
      } else {
        $('#TOAST-MESSAGE-BOX')
          .fadeIn(400)
          .delay(1000)
          .fadeOut(400)
      }
    }
  },
  [types.LOGGED_IN](state) {
    state.flags.loggedIn = true
  },
  [types.LOGGED_OUT](state) {
    Object.assign(state, getDefaultState())
  },
  USER_LOGGED_IN(state, user) {
    state.user = user
    state.flags.loggedIn = true
  },
  SET_CATEGORIES(state, categories) {
    state.categories = categories.results
  },

  SET_MY_PROFILE(state, profileObj) {
    state.myProfile = profileObj || []
  },
  SET_LATEST_NEWS(state, items) {
    state.latestNews = items || []
  },

  SET_ALL_NEWS(state, items) {
    state.allNews = items || []
    state.allNewsLoaded = true
  },
  SET_COMING_UPS(state, items) {
    state.comingUps = items || []
  },
  SET_BLOCKED_PROFILES(state, items) {
    state.blockedProfiles = items || []
  },
  SET_HIDDEN_CONVERSATIONS(state, items) {
    state.hiddenConversations = items || []
  },
  ADD_MY_NOTIFICATIONS(state, notifications) {
    console.log('Adding notifications:', notifications);
    if (state.notifications.length === 0) {
      notifications.forEach(notification => {
        if (!state.notifications.some(existingNotification => existingNotification.id === notification.id)) {
          state.notifications.push(notification);
        }
      });
    } else {
      notifications.forEach(notification => {
        if (!state.notifications.some(existingNotification => existingNotification.id === notification.id)) {
          state.notifications.unshift(notification);
        }
      });
    }
  },
  ADD_POSTS(state, payload) {
    let posts = payload.posts || [];
    let toFront = payload.toFront || false;
    console.log('mutation posts to add:', posts, toFront);
    if (!state.posts) {
      state.posts = [];
    }
    posts.forEach(post => {
      if (!state.posts.some(existingPost => existingPost.id === post.id)) {
        if (toFront) {
          state.posts.unshift(post);
        } else {
          state.posts.push(post);
        }
      }
    });
    console.log('mutation posts:', state.posts);
  },
  DELETE_POST(state, postId) {
    state.posts = state.posts.filter(post => post.id !== postId);
  },
  SET_PROFILE_DETAILS(state, profileDetails) {
    console.log('mutation profileDetails:', profileDetails);
    if (!state.profileDetails) {
      state.profileDetails = [];
    }
    if (!state.profileDetails.some(detail => detail.id == profileDetails.id)) {
      state.profileDetails.push(profileDetails);
    }
    console.log('mutation profileDetails:', state.profileDetails);
  },
  SET_BUSINESS_DETAILS(state, businessDetails) {
    if (!state.businessDetails) {
      state.businessDetails = [];
    }
    if (!state.businessDetails.some(detail => detail.id == businessDetails.id)) {
      state.businessDetails.push(businessDetails);
    }
  },

  SET_COUNTRIES(state, items) {
    state.countries = items || []
  },

  SET_PROVINCES(state, items) {
    state.provinces = items || []
  },

  SET_TOWNS(state, items) {
    state.towns = items || []
  },

  SET_TAGS(state, tags) {
    state.tags = tags.results
  },

  SET_MY_BUSINESSES(state, businesses) {
    state.myBusinesses = businesses.results
  },

  SET_BUSINESSES(state, businesses) {
    state.businesses = businesses.results
  },

  TOGGLE_FOLLOWINGS(state, profileId) {
    if (!state.myProfile || !state.myProfile.Followings) {
      return
    }
    const followingsArray = state.myProfile.Followings.split(',').map(id => id.trim())
    const index = followingsArray.indexOf(String(profileId))
    if (index === -1) {
      followingsArray.push(String(profileId))
    } else {
      followingsArray.splice(index, 1)
    }
    state.myProfile.Followings = followingsArray.join(',')
  },
  SET_FOLLOWINGS(state, followings) {
    state.followings = followings
  },
  SET_MY_POSTS(state, posts) {
    state.myPosts = posts
  },
  SET_MY_BOOKMARKS(state, bookmarks) {
    state.myBookmarks = bookmarks
  },
  SET_ALL_CONVERSATIONS(state, conversations) {
    state.allConversations = conversations
  },

  [types.CHANGE_LANGUAGE](state, language) {
    state.lang = language
  },
  [types.SET_MY_PROFILE](state, profileObj) {
    state.myProfile = profileObj
  },
  [types.ALL_CATCHED](state) {
    state.allCatched = true
  },
  [types.SET_SPECIAL_BUTTON](state, specialButton) {
    state.specialButton = specialButton
  },
  [types.SET_HEADER_TITLE](state, title) {
    state.headerTitle = title
    console.log(state.headerTitle)
  },

  [types.SET_STATE_TO_INITIAL_VALUES](state) {
    let init = JSON.parse(JSON.stringify(state.initialValues))
    for (var property in init) {
      if (
        init.hasOwnProperty(property) &&
        property !== 'listOfConnections' &&
        property !== 'title' &&
        property !== 'versienummer'
      ) {
        state[property] = init[property]
      }
    }
  },
  [types.INITIALIZE_DROPDOWN_PAGE](state, payload) {
    // if dropdown was not defined before OR if it was given that data should be kept after made a selection
    if (
      typeof state.allDropdownMenus[payload.dropdownID] === 'undefined' ||
      !state.allDropdownMenus[payload.dropdownID].keepDataAfterSelection
    ) {
      let newDropdown = {}
      newDropdown.propertyToBeShown = payload.propertyToBeShown
      newDropdown.listOfItems = payload.listOfItems
      newDropdown.title =
        typeof payload.title !== 'undefined' ? payload.title : 'Maak een keuze'
      newDropdown.keepDataAfterSelection = typeof payload.keepDataAfterSelection !== 'undefined' ?
        payload.keepDataAfterSelection :
        true
      newDropdown.isMultiSelect = typeof payload.isMultiSelect !== 'undefined' ?
        payload.isMultiSelect :
        false
      newDropdown.showFilterBar = typeof payload.showFilterBar !== 'undefined' ?
        payload.showFilterBar :
        false
      newDropdown.atLeastOneSelectedItemRequired = typeof payload.atLeastOneSelectedItemRequired !== 'undefined' ?
        payload.atLeastOneSelectedItemRequired :
        false
      newDropdown.selectAllButtonName = payload.selectAllButtonName === 'undefined' ?
        'Selecteer alles' :
        payload.selectAllButtonName
      newDropdown.selectAllButtonVisible = typeof payload.selectAllButtonVisible !== 'undefined' ?
        payload.selectAllButtonVisible :
        false
      newDropdown.listOfItems.map(function (item, idx) {
        item._ID_DROPDOWN_PAGE = idx
        item._SELECTED_DROPDOWN_PAGE = typeof item._SELECTED_DROPDOWN_PAGE === 'undefined' ?
          false :
          item._SELECTED_DROPDOWN_PAGE
      })
      if (newDropdown.selectAllButtonVisible) {
        newDropdown.listOfItems.unshift({
          _ID_DROPDOWN_PAGE: -1,
          _SELECTED_DROPDOWN_PAGE: false,
          [newDropdown.propertyToBeShown]: newDropdown.selectAllButtonName
        })
      }
      state.allDropdownMenus[payload.dropdownID] = newDropdown
    }
    state.currentDropdownMenu = payload.dropdownID
  },
  [types.UPDATE_LIST_OF_ITEMS_OF_DROPDOWN](state, newListOfItems) {
    state.allDropdownMenus[state.currentDropdownMenu].listOfItems = {}
    state.allDropdownMenus[state.currentDropdownMenu].listOfItems = newListOfItems
  },
  [types.UNLOCK_LOGIN_PROCEDURE](state) {
    state.flags.loginProcedureLocked = false
  },
  [types.LOCK_LOGIN_PROCEDURE](state) {
    state.flags.loginProcedureLocked = true
  },
  [types.CLOSE_DIALOG](state, flag) {
    state.closeDialog = flag
  },
  [types.LAST_ACTIVE_DIALOG](state, dialog) {
    state.lastActiveDialog = dialog
  },
  [types.SET_CONNECTED_PROVINCE](state, pr) {
    state.connectedProvince = pr
  },
  [types.UPDATE_PROFILE](state, profileObj) {
    state.profile = _.merge(state.profile, profileObj)
  },
  [types.ADD_POST_TO_FRONT](state, post) {
    let newPostArray = state.allPosts
    newPostArray.unshift(post)
    state.allPosts = newPostArray
  },

  SET_NOTIFICATIONS(state, list) {
    state.notifications = Array.isArray(list) ? list : [];
  },
  MARK_NOTIFICATION_VIEWED(state, id) {
    const it = state.notifications.find(x => String(x.id) === String(id));
    if (it) it.is_seen = 1;
  }


}

