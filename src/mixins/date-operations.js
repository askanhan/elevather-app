import moment from 'moment'
export default {
  methods: {
    _initialize3DayArray() {
      console.log('komt hier niet')
      return [ /* eslint-disable new-cap */
        new moment().startOf('day'),
        new moment().startOf('day').add(1, 'day'),
        new moment().startOf('day').add(2, 'day')
        /* eslint-enable new-cap */
      ]
    },
    _initializeWeekArray() {
      return [ /* eslint-disable new-cap */
        new moment().startOf('isoWeek'),
        new moment().startOf('isoWeek').add(1, 'day'),
        new moment().startOf('isoWeek').add(2, 'day'),
        new moment().startOf('isoWeek').add(3, 'day'),
        new moment().startOf('isoWeek').add(4, 'day'),
        new moment().startOf('isoWeek').add(5, 'day'),
        new moment().startOf('isoWeek').add(6, 'day')
        /* eslint-enable new-cap */
      ]
    },
    _createDateObjectFromDateOfServer(dateAsStringFromServer) {
      return new Date(dateAsStringFromServer.split('-').join('/'))
    },
    _addZeroIfNeeded(item) {
      let str = item + ''
      return str.length === 1 ? '0' + str : str
    },
    _dateObjectToOnlyDate(dateObject) {
      let date = this._addZeroIfNeeded(dateObject.getDate())
      let month = this._addZeroIfNeeded(dateObject.getMonth() + 1)
      let year = this._addZeroIfNeeded(dateObject.getUTCFullYear())
      return year + '-' + month + '-' + date
    },
    _deleteSecondsFromDateString(str) { // dateAsStringFromServer
      return str.length === 19 ? str.substring(0, str.length - 3) : str
    },
    _formatDate(datum) {
      if (datum !== null && datum !== undefined) {
        return datum.getDate() + '/' + (datum.getMonth() + 1)
      }
    },
    _formatDateWithTimestampT(date) {
      if (date !== null && date !== undefined) {
        return moment(date).format('YYYY-MM-DDTHH:mm:ss')
      }
    },
    _formatDateWithTimestamp(date) {
      if (date !== null && date !== undefined) {
        return moment(date).format('YYYY-MM-DD HH:mm:ss')
      }
    },
    _formatDateWithZeroTimestamp(date) {
      if (date !== null && date !== undefined) {
        return moment(date).format('YYYY-MM-DD 00:00:00')
      }
    },
    _formatDateWithZeroTimestampT(date) {
      if (date !== null && date !== undefined) {
        return moment(date).format('YYYY-MM-DD 00:00:00')
      }
    },
    _formatDateSQL(datum) {
      if (datum !== null && datum !== undefined) {
        return moment(datum).format('YYYY-MM-DD')
      }
    },
    _formatDateStandaard(datum) {
      if (datum !== null && datum !== undefined) {
        return moment(datum).format('DD/MM/YYYY')
      }
    },
    _formatDateCustom(datum, formatting) {
      if (datum !== null && datum !== undefined) {
        return moment(datum).format(formatting)
      }
    },
    _datumZonderTijdstip(datum) {
      if (datum !== null && datum instanceof Date && !isNaN(datum.valueOf())) {
        return new Date(datum.getFullYear(), datum.getMonth(), datum.getDate(), 0, 0, 0)
      }
    },
    _addDays(dat, days) {
      dat = new moment(dat)._d
      dat.setDate(dat.getDate() + days)
      return dat
    },

    _dutchDayToIdxOfDay(dayName) {
      if (dayName === "Maandag") {
        return 0
      } else if (dayName === "Dinsdag") {
        return 1
      } else if (dayName === "Woensdag") {
        return 2
      } else if (dayName === "Donderdag") {
        return 3
      } else if (dayName === "Vrijdag") {
        return 4
      } else if (dayName === "Zaterdag") {
        return 5
      } else if (dayName === "Zondag") {
        return 6
      }
      return -1
    },
    _momentToDayInDutch(momentObject) {
      let dow = momentObject.day()
      if (dow === 1) {
        return 'Maandag'
      } else if (dow === 2) {
        return 'Dinsdag'
      } else if (dow === 3) {
        return 'Woensdag'
      } else if (dow === 4) {
        return 'Donderdag'
      } else if (dow === 5) {
        return 'Vrijdag'
      } else if (dow === 6) {
        return 'Zaterdag'
      } else if (dow === 0) {
        return 'Zondag'
      }
      return '-'
    },
    _stringToDate(stringDate) {
      return new Date(stringDate.replace(' ', 'T'))
    },
    _huidigeDagWeekKortMetDagMaand(datum) {
      if (datum !== null && datum !== undefined) {
        return this._huidigeDagWeekKort(datum) + ' ' + this._formatDate(datum)
      }
    },
    _huidigeDagWeekKort(datum) {
      if (datum !== null && datum !== undefined) {
        return this._huidigeDagWeek(datum).substring(0, 2)
      }
    },
    _huidigeMaandVanDatum(datum) {
      var maandVhJaar = datum.getMonth() + 1
      this.huidigeMaand(maandVhJaar)
    },
    _huidigeMaand(datumInt) {
      var maandVhJaar = ''
      if (datumInt !== null && datumInt !== undefined) {
        switch (datumInt) {
          case 1:
            maandVhJaar = 'Januari'
            break
          case 2:
            maandVhJaar = 'Februari'
            break
          case 3:
            maandVhJaar = 'Maart'
            break
          case 4:
            maandVhJaar = 'April'
            break
          case 5:
            maandVhJaar = 'Mei'
            break
          case 6:
            maandVhJaar = 'Juni'
            break
          case 7:
            maandVhJaar = 'Juli'
            break
          case 8:
            maandVhJaar = 'Augustus'
            break
          case 9:
            maandVhJaar = 'September'
            break
          case 10:
            maandVhJaar = 'Oktober'
            break
          case 11:
            maandVhJaar = 'November'
            break
          case 12:
            maandVhJaar = 'December'
            break
        }
      }
      return maandVhJaar
    },
    _huidigeDagWeek(datum) {
      var huidigeWeekdag = ''
      if (datum !== null && datum !== undefined) {
        var dagVdWeek = datum.getDay()
        switch (dagVdWeek) {
          case 1:
            huidigeWeekdag = 'Maandag'
            break
          case 2:
            huidigeWeekdag = 'Dinsdag'
            break
          case 3:
            huidigeWeekdag = 'Woensdag'
            break
          case 4:
            huidigeWeekdag = 'Donderdag'
            break
          case 5:
            huidigeWeekdag = 'Vrijdag'
            break
          case 6:
            huidigeWeekdag = 'Zaterdag'
            break
          case 7:
            huidigeWeekdag = 'Zondag'
            break
          case 0:
            huidigeWeekdag = 'Zondag'
            break
        }
      }
      return huidigeWeekdag
    },
    _formatCalendarMetRanges(id, vanaf, tot, huidigeRanges, altijdZelfInTeGevenKalendersTonen, bovenOfOnder, cbFunction) {
      if (typeof huidigeRanges === 'undefined') {
        huidigeRanges = false
      }
      if (typeof vanaf === 'undefined' || typeof tot === 'undefined') {
        vanaf = moment
        tot = moment // (jaarInfo.EindeVakantie)
      }

      $(id).daterangepicker({
        locale: {
          format: 'YYYY-MM-DD',
          'cancelLabel': 'Annuleren',
          'applyLabel': 'Toepassen',
          'separator': ' > ',
          'fromLabel': 'Van',
          'toLabel': 'Tot',
          'customRangeLabel': 'Zelf ingeven',
          'daysOfWeek': [
            'Zo',
            'Ma',
            'Di',
            'Wo',
            'Do',
            'Vr',
            'Za'
          ],
          'monthNames': [
            'Januari',
            'Februari',
            'Maart',
            'April',
            'Mei',
            'Juni',
            'Juli',
            'Augustus',
            'September',
            'Oktober',
            'November',
            'December'
          ],
          'firstDay': 1
        },
        'alwaysShowCalendars': altijdZelfInTeGevenKalendersTonen, // true / false
        'showWeekNumbers': true,
        'timePicker': false,
        'startDate': vanaf,
        'endDate': tot,
        'linkedCalendars': false,
        'drops': bovenOfOnder, // down / up
        'ranges': huidigeRanges
      }, function(vanaf, tot, id) {
        if (typeof cbFunction !== 'undefined') {
          cbFunction(vanaf, tot, id)
        }
      })
    },

    _kantelmoment: function(dat) {
      dat = dat || new Date();
      var m = dat.getMonth();
      var y = dat.getFullYear();
      if (m === 7) {
        dat = new Date(y, 8, 1, 0, 0, 0, 0);
      }
      return dat;
    },

    _getBeginSchooljaar(dat) {
      dat = dat || new Date()
      dat = this._kantelmoment(dat) // kantelmoment altijd in rekening brengen!
      var m = dat.getMonth()
      var y = dat.getFullYear()
      if (m < 8) {
        y = y - 1
      }
      return new Date(y, 8, 1, 0, 0, 0, 0)
    },

    _getEindeSchooljaar: function(dat) {
      dat = dat || new Date();
      dat = this._kantelmoment(dat) // kantelmoment altijd in rekening brengen!
      var m = dat.getMonth();
      var y = dat.getFullYear();
      if (m >= 7) { // 7 = augustus !!
        y = y + 1;
      }
      return new Date(y, 5, 30, 0, 0, 0, 0);
    },

    _getEindeVakantieSchooljaar: function(dat) {
      dat = dat || new Date();
      dat = this._kantelmoment(dat) // kantelmoment altijd in rekening brengen!
      var m = dat.getMonth();
      var y = dat.getFullYear();
      if (m >= 8) {
        y = y + 1;
      }
      return new Date(y, 7, 31, 0, 0, 0, 0);
    },

    _isMinderjarig(geboorteDatum, huidigeDatum) {
      let leeftijd = this.berekenLeeftijd(geboorteDatum, huidigeDatum)
      if (leeftijd < 18) {
        return true
      } else {
        return false
      }
    },
    _berekenLeeftijd(geboorteDatum, huidigeDatum) {
      var birthDay = geboorteDatum.getDate()
      var birthMonth = geboorteDatum.getMonth()
      var birthYear = geboorteDatum.getFullYear()

      var todayDay = huidigeDatum.getDate()
      var todayMonth = huidigeDatum.getMonth()
      var todayYear = huidigeDatum.getFullYear()

      let age = todayYear - birthYear

      if (todayMonth < birthMonth - 1) {
        age--
      }

      if (((birthMonth - 1) === todayMonth) && (todayDay < birthDay)) {
        age--
      }
      return age
    },
    _datumNaarDate(datum) {
      let datumArray = datum.split('/')
      if (datumArray.length === 3 && this.isInt(datumArray[0]) && this.isInt(datumArray[1]) && this.isInt(datumArray[2])) {
        return new Date(datumArray[2], datumArray[1] - 1, datumArray[0], 0, 0)
      }
    }

  }
}
