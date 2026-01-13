import { createApp } from 'vue'
import dateOperations from '@/mixins/date-operations.js'
import moment from 'moment'

const app = createApp({})

app.config.globalProperties.$filters = {
  slashDDMMYYYY(value) {
    if (value._isAMomentObject) {
      console.log(value)
      return value.format('DD/MM/YYYY')
    } else if (value instanceof Date) {
      return this.formatDate(value, '/')
    } else if (typeof value === 'string') {
      return this.formatDate(dateOperations._stringToDate(value), '/')
    }
  },

  formatDateDDmmYYYY(value) {
    if (value) {
      return moment(String(value)).format('DD/MM/YYYY')
    }
  },

  formatDateDDmmYYYYHHmm(value) {
    if (value) {
      return moment(String(value)).format('DD/MM/YYYY HH:mm')
    }
  },

  formatDecimal(value) {
    return value.replace('.', ',')
  },

  formatDate(date, punctuation = '/', dayNameVisible = false, monthNameVisible = false, yearVisible = true, order = 'dmy') {
    let monthNames = [
      'Januari', 'Februari', 'Maart',
      'April', 'Mei', 'Juni', 'Juli',
      'Augustus', 'September', 'Oktober',
      'November', 'December'
    ]
    let dayNames = ['Maandag', 'Dinsdag', 'Woensdag', 'Donderdag', 'Vrijdag', 'Zaterdag', 'Zondag']

    let day = date.getDate()
    let month = date.getMonth() + 1
    let monthIndex = date.getMonth()
    let dayIndex = date.getDay() - 1
    let year = date.getFullYear()

    let dayToShow = dayNameVisible ? dayNames[dayIndex] : day
    let monthToShow = monthNameVisible ? monthNames[monthIndex] : month

    let res = ''

    function addToRes(i, val) {
      if (i > 0 && i < order.length) {
        res += punctuation
      }
      res += val
    }
    for (let i = 0; i < order.length; i++) {
      if (order[i].toLowerCase() === 'd') {
        addToRes(i, dayToShow)
      } else if (order[i].toLowerCase() === 'm') {
        addToRes(i, monthToShow)
      } else if (yearVisible && order[i] === 'y') {
        addToRes(i, year)
      }
    }
    return res
  }
}
