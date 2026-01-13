import DO from '@/mixins/date-operations.js'
const dateOperations = DO.methods

export const getConnectionWithID = (state, getters) => (id) => {
  let connectionObject = state.listOfConnections.find(conn => conn.ID + '' === id)
  connectionObject.connectionTypes = JSON.parse(JSON.stringify(state.allConnectionTypes))
  connectionObject.connectionTypes.map(function (c) {
    if (c._name === connectionObject.connectionType._name) {
      c._selected = true
    } else {
      c._selected = false
    }
  })
  return connectionObject
}

export const getTag = (state) => (id) => {
  let tag = state.tags.find(t => t.id === id)
  console.log(tag, id, state.tags)
  return tag || null
}

export const getCategory = (state) => (id) => {
  let category = state.categories.find(cat => cat.id === id)
  return category || null
}

export const getSelectedItemsForGivenDropdownID = (state) => (dropdownID) => {
  let dropdown = state.allDropdownMenus[dropdownID]
  if (typeof dropdown === 'undefined') {
    return []
  }
  return dropdown.listOfItems.filter(function (items) {
    return items._SELECTED_DROPDOWN_PAGE
  })
}


export const getTags = (state) => (ids) => {
  return state.tags.filter(t => _.indexOf(ids, t.tag_id) !== -1)
}


export const getPost = (state) => (id) => {
  let p = state.allPosts.filter(p => p.post_id == id)
  if (p.length > 0) {
    return p[0]
  } else {
    return -1
  }
}


export const getProfile = (state) => (id) => {
  let p = state.allProfiles.filter(p => p.p_id == id)
  if (p.length > 0) {
    return p[0]
  } else {
    return -1
  }
}

export const getTown = (state) => (id) => {
  let p = state.towns.filter(t => t.town_id == id)
  if (p.length > 0) {
    return p[0]
  } else {
    return -1
  }
}

export const getProvince = (state) => (id) => {
  let p = state.provinces.filter(pr => pr.pr_id == id)
  if (p.length > 0) {
    return p[0]
  } else {
    return -1
  }
}


export const getHolidaysOnThisDay = (state) => (currentModule, momentObject) => {
  return state[currentModule].holidays.filter(function (holiday) {
    return holiday.Van.startsWith(momentObject.format('YYYY/MM/DD'))
  })
}

export const getHolidaysWithinGivenRange = (rootstate) => (currentModule, dayColumns, filterWeekends) => {
  function isInWeekend(momentObj) {
    return momentObj.isoWeekday() === 6 || momentObj.isoWeekday() === 7
  }
  return rootstate[currentModule].holidays.filter(function (holiday) {
    let vanDate = holiday.Van.split(' ')[0]
    let vanObj = new moment(vanDate)
    return dayColumns.filter(d => d === vanDate).length > 0 &&
      (!filterWeekends ||
        (filterWeekends && !isInWeekend(vanObj)))
  }).map(h => {
    h.dayName = dateOperations._momentToDayInDutch(new moment(h.Van))
    return h
  })
}
