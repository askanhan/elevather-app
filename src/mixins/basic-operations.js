import VueScrollTo from 'vue-scrollto'
import moment from 'moment'
import 'moment/locale/nl-be'
import 'moment/locale/fr'
import 'moment/locale/tr'
import { authStore } from "@/store/auth.js"
export default {
  data() {
    return {
      _CLONE: {
        'Array': function (clone) {
          return Array.prototype.map.call(this, clone)
        },
        'Date': function () {
          return new Date(this.valueOf())
        },
        'String': String.prototype.valueOf,
        'Number': Number.prototype.valueOf,
        'Boolean': Boolean.prototype.valueOf
      }
    }
  },
  computed: {
    _no_photo_url() {
      return './static/pics/no_photo.png'
    }
  },
  methods: {
    _setLanguageOfApp(lang) {
      console.log('changing language to... ...')
      console.log(lang)
      if (lang === 'nl') {
        moment.locale('nl-be')
      } else {
        moment.locale(lang)
      }
      this.$store.commit('SET_LANG', lang)
      //TODO this.$modal.hide('threedot')
      authStore.setItem('lang', lang)
    },
    _goToTop(topElementID) {
      this.$nextTick(() => {
        const target = document.querySelector(topElementID);
        if (!target) return;
    
        const OFFSET = 60;
    
        const isScrollable = (el) => {
          const s = getComputedStyle(el);
          const oy = s.overflowY;
          return (oy === "auto" || oy === "scroll") && el.scrollHeight > el.clientHeight;
        };
    
        const getScrollParent = (el) => {
          let p = el.parentElement;
          while (p) {
            if (isScrollable(p)) return p;
            p = p.parentElement;
          }
          return null;
        };
    
        const scroller = getScrollParent(target);
    
        if (scroller) {
          const top = target.getBoundingClientRect().top - scroller.getBoundingClientRect().top + scroller.scrollTop - OFFSET;
          scroller.scrollTo({ top, behavior: "smooth" });
        } else {
          const top = target.getBoundingClientRect().top + window.scrollY - OFFSET;
          window.scrollTo({ top, behavior: "smooth" });
        }
      });
    },
    calcCrow(lat1, lon1, lat2, lon2) {
      let R = 6371 // km
      let dLat = this._toRad(lat2 - lat1)
      let dLon = this._toRad(lon2 - lon1)
      lat1 = this._toRad(lat1)
      lat2 = this._toRad(lat2)
      let a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2)
      let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      let d = R * c
      return d
    },
    _toRad(Value) {
      return Value * Math.PI / 180;
    },
    _detectLocation(successCallback) {
      if (navigator && navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
          console.log('positionpositionpositionpositionpositionpositionpositionposition')
          console.log(position)
          this.$store.dispatch({
            type: `getRegionInfo`,
            position,
            tryNumber: 4,
            successCB: (res) => {
              console.log('wooooooooooooo')
              console.log(res)
              if (res.adminareas.admin7 && res.adminareas.admin7.name_nl && res.adminareas.admin7.name_nl.toLowerCase().indexOf('brussel') !== -1) {
                successCallback(2) //brussel
              } else {
                if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('antwerp') !== -1) {
                  successCallback(1)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('limburg') !== -1) {
                  successCallback(3)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('oost') !== -1) {
                  successCallback(4)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('west') !== -1) {
                  successCallback(5)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('vlaams-brabant') !== -1) {
                  successCallback(6)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('waals-brabant') !== -1) {
                  successCallback(7)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('henegouwen') !== -1) {
                  successCallback(8)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('luik') !== -1) {
                  successCallback(9)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('luxemburg') !== -1) {
                  successCallback(10)
                }
                else if (res.adminareas.admin6.name_nl.toLowerCase().indexOf('namen') !== -1) {
                  successCallback(11)
                } else {
                  successCallback(12)
                }
              }
            }
          })
        },
          (err) => {
            console.log(err)
          },
          { maximumAge: 3000, timeout: 5000, enableHighAccuracy: true })
      }
    },
    _inputFilter(newFile, oldFile, prevent) {
      if (newFile && !oldFile) {
        // Before adding a file
        // Filter system files or hide files
        if (/(\/|^)(Thumbs\.db|desktop\.ini|\..+)$/.test(newFile.name)) {
          return prevent()
        }
        // Filter php html js file
        if (/\.(php5?|html?|jsx?)$/i.test(newFile.name)) {
          return prevent()
        }
        // Create a blob field
        newFile.blob = ''
        let URL = window.URL || window.webkitURL
        if (URL && URL.createObjectURL) {
          newFile.blob = URL.createObjectURL(newFile.file)
        }
        // Thumbnails
        newFile.thumb = ''
        if (newFile.blob && newFile.type.substr(0, 6) === 'image/') {
          newFile.thumb = newFile.blob
        }
      }
    },
    _showMessage(message) {
      this._vm.$toast(message)
    },
    _getExtension(name) {
      return name.split('.')[name.split('.').length - 1]
    },
    _bytesToSize(bytes) {
      if (bytes) {
        let sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        if (bytes == 0) return '0 Byte';
        let i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
        return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
      }
    },
    _limitStr(string, limit) {
      let str = string;

      if (typeof str === 'string' && str.length > limit) {
        str = str.slice(0, limit) + '...';
      }

      return str;
    },
    _contentTypeIsImage(contentType) {
      if (contentType !== undefined && contentType.indexOf('image/') > -1) {
        return true
      }
    },

    _isJsonString(str) {
      try {
        JSON.parse(str);
      } catch (e) {
        return false;
      }
      return true;
    },

    _selectInputField(veld, scrollIntoView, delay) {
      if (delay === undefined) {
        delay = 500
      }
      console.log(veld + ' selecteren')
      setTimeout(function () {
        if (veld !== undefined && $('#' + veld) !== undefined && $('#' + veld).get(0) !== undefined) {
          // $('#' + veld).animate({ scrollTop: topPos + 'px' }, 'fast')
          var elmnt = document.getElementById(veld)
          if (scrollIntoView) {
            elmnt.scrollIntoView()
          }
          elmnt.focus()
          elmnt.select()
          if (navigator.userAgent.match(/(iPad|iPhone|iPod)/i)) {
            var oudType = elmnt.type
            elmnt.type = 'text'
            elmnt.setSelectionRange(0, elmnt.value.length)
            elmnt.type = oudType
          }
        }
      }, delay)
    },

    _getScreenName(menuItem) {
      if (this.$store.state.userInfo.isLeerkracht) {
        return menuItem.screenNameLeerkracht;
      } else if (this.$store.state.userInfo.isLeerling) {
        return menuItem.screenNameLeerling;
      } else if (this.$store.state.userInfo.isOuder) {
        return menuItem.screenNameOuder;
      }
    },

    // Screen rights only exists for teachers
    _userHasRightForThisScreen(menuItem) {
      let screenName = this._getScreenName(menuItem)
      return this._userHasRightForThisScreenName(screenName)
    },

    _userHasRightForThisScreenName(screenName) {
      let defaultValue = this.$store.state.userInfo.loggedInUserInformation.rights.defaults
      let screenRights = this.$store.state.userInfo.loggedInUserInformation.rights.screens
      let toBeComparedBitwiseValue = null
      if (typeof screenRights[screenName] === 'undefined') {
        toBeComparedBitwiseValue = defaultValue
      } else {
        toBeComparedBitwiseValue = screenRights[screenName]
      }
      return (toBeComparedBitwiseValue & 1) !== 0
    },

    // Wis@d screen rights do not exist for students or parent, set by administrator in server.ini en coming through if set in "menu"
    _leerlingOfOuderHasRightForThisScreen(menuItem) {
      var screenName = this._getScreenName(menuItem)
      if (screenName === '') {
        return false
      } else {
        var menu = this.$store.state.userInfo.loggedInUserInformation.menu
        for (var x = 0; x < menu.Items.length; x++) {
          var hoofdmenuItem = menu.Items[x];
          if (hoofdmenuItem.Form === screenName) {
            return true
          }
          if (hoofdmenuItem.Items !== undefined) {
            for (var x2 = 0; x2 < hoofdmenuItem.Items.length; x2++) {
              var submenuItem = hoofdmenuItem.Items[x2];
              if (submenuItem.Form === screenName) {
                return true
              }
              if (submenuItem.Items !== undefined) {
                for (var x3 = 0; x3 < submenuItem.Items.length; x3++) {
                  var subsubmenuItem = submenuItem.Items[x3];
                  if (subsubmenuItem.Form === screenName) {
                    return true
                  }
                }
              }
            }
          }
        }
      }
    },

    _isAndroidVersionStartingWith(versionNumber) {
      try {
        return navigator.userAgent.split('Android ')[1].indexOf(versionNumber + '') === 0
      } catch (e) {
        return false
      }
    },

    _extractFormRights(o) {
      return {
        open: (0 !== (o & 1)),
        create: (0 !== (o & 2)),
        update: (0 !== (o & 4)),
        destroy: (0 !== (o & 8))
      };
    },

    _extractGridRights(o) {
      return {
        disableAdd: (0 === (o & 2)),
        disableEdit: (0 === (o & 4)),
        disableDelete: (0 === (o & 8))
      };
    },

    _setTempValue(couple) {
      let temp = JSON.parse(sessionStorage.temp)
      temp[couple.name] = couple.value
      sessionStorage.setItem('temp', JSON.stringify(temp))
    },

    _clearTempValue(varName) {
      let temp = JSON.parse(sessionStorage.temp)
      delete temp[varName]
      sessionStorage.setItem('temp', JSON.stringify(temp))
    },

    _getTemp() {
      return JSON.parse(sessionStorage.temp)
    },

    _clearTempCompletely() {
      sessionStorage.setItem('temp', JSON.stringify({}))
    },

    _getTempValue(varName) {
      let temp = this._getTemp()
      if (typeof temp[varName] === 'undefined') {
        return false
      }
      return temp[varName]
    },

    _getFormRights(state, fn, gridformat) {
      var o = 0;
      if (!_.isEmpty(state.userInfo.loggedInUserInformation.rights)) {
        if (_.isNumber(state.userInfo.loggedInUserInformation.rights.screens[fn])) {
          o = state.userInfo.loggedInUserInformation.rights.screens[fn];
        } else {
          o = state.userInfo.loggedInUserInformation.rights.defaults;
        }
      }
      if (gridformat) {
        return this._extractGridRights(o);
      } else {
        return this._extractFormRights(o);
      }
    },

    _allowFormOperation(state, fn, op) {
      var r = this._getFormRights(state, fn, false);
      switch (op) {
        case 'read':
          return r.open;
        case 'edit':
          return r.update;
        case 'add':
          return r.create;
        case 'delete':
          return r.destroy;
        default:
          return r[op];
      }
    },

    _allowFormOpen(state, fn) {
      return this._getFormRights(state, fn, false).open;
    },

    // Rechten per kast in aparte array bewaren
    _rechtenPerKastArray(dsUserKastenScherm, rechtenOpKasten) {

      var vorigeKast = '';

      for (var i = 0; i < dsUserKastenScherm.length; i++) {
        var huidigDocument = dsUserKastenScherm[i]
        var huidigeKastCode = huidigDocument.K_CODE;

        if (vorigeKast !== huidigeKastCode) {

          var rechtenArray = {};
          rechtenArray['K_CODE'] = huidigeKastCode;
          rechtenArray["enableOpen"] = false;
          rechtenArray["enableAdd"] = false;
          rechtenArray["enableEdit"] = false;
          rechtenArray["enableDelete"] = false;
          rechtenArray['K_ID'] = huidigDocument.K_ID;
          rechtenArray['K_VELD'] = huidigDocument.K_VELD;
          rechtenArray['OMSCHRIJVING'] = huidigDocument.OMSCHRIJVING;

          // nieuwe kast aan array toevoegen
          rechtenOpKasten.push(rechtenArray);
        }

        // bestaande kast controleren of er extra rechten geactiveerd moeten worden
        this._standaardRechtenBestaandRechtUpdaten(rechtenOpKasten, huidigDocument.KR_RECHTEN);

        vorigeKast = huidigeKastCode;
      }
      console.log('_rechtenPerKastArray')
    },

    _standaardRechtenBestaandRechtUpdaten(rechtenOpKasten, KR_RECHTEN) {
      var vorigZelfdeRecht = rechtenOpKasten[rechtenOpKasten.length - 1];
      if (vorigZelfdeRecht.enableOpen === false && this._openBeschikbaar(KR_RECHTEN)) {
        vorigZelfdeRecht.enableOpen = true;
      }
      if (vorigZelfdeRecht.enableEdit === false && this._editBeschikbaar(KR_RECHTEN)) {
        vorigZelfdeRecht.enableEdit = true;
      }
      if (vorigZelfdeRecht.enableAdd === false && this._addBeschikbaar(KR_RECHTEN)) {
        vorigZelfdeRecht.enableAdd = true;
      }
      if (vorigZelfdeRecht.enableDelete === false && this._deleteBeschikbaar(KR_RECHTEN)) {
        vorigZelfdeRecht.enableDelete = true;
      }
    },


    /*
    Zie wisad 'Extra - profiel - Kasten rechten'
    KR_RECHTEN = 0 geen rechten
    KR_RECHTEN = 1 openen
    KR_RECHTEN = 2 bewerken (niet mogelijk zonder openen?)
    KR_RECHTEN = 3 openen + bewerken
    KR_RECHTEN = 4 toevoegen (niet mogelijk zonder openen?)
    KR_RECHTEN = 5 openen + toevoegen
    KR_RECHTEN = 6 bewerken + toevoegen  (niet mogelijk zonder openen?)
    KR_RECHTEN = 7 openen + bewerken + toevoegen
    KR_RECHTEN = 8 verwijderen   (niet mogelijk zonder openen?)
    KR_RECHTEN = 9 openen + verwijderen
    KR_RECHTEN = 10 bewerken + verwijderen  (niet mogelijk zonder openen?)
    KR_RECHTEN = 11 openen + bewerken + verwijderen
    KR_RECHTEN = 12 toevoegen + verwijderen  (niet mogelijk zonder openen?)
    KR_RECHTEN = 13 openen + toevoegen + verwijderen
    KR_RECHTEN = 14 bewerken + toevoegen + verwijderen  (niet mogelijk zonder openen?)
    KR_RECHTEN = 15 openen + bewerken + toevoegen + verwijderen
     */

    _openBeschikbaar(KR_RECHTEN) {
      if (KR_RECHTEN === 1 || KR_RECHTEN === 3 || KR_RECHTEN === 5 || KR_RECHTEN === 7 || KR_RECHTEN === 9 || KR_RECHTEN === 11 || KR_RECHTEN ===
        13 || KR_RECHTEN === 15) {
        return true;
      } else
        return false;
    },

    _editBeschikbaar(KR_RECHTEN) {
      if (KR_RECHTEN === 2 || KR_RECHTEN === 3 || KR_RECHTEN === 6 || KR_RECHTEN === 7 || KR_RECHTEN === 10 || KR_RECHTEN === 11 || KR_RECHTEN ===
        14 || KR_RECHTEN === 15) {
        return true;
      } else
        return false;
    },

    _addBeschikbaar(KR_RECHTEN) {
      if (KR_RECHTEN === 4 || KR_RECHTEN === 5 || KR_RECHTEN === 6 || KR_RECHTEN === 7 || KR_RECHTEN === 12 || KR_RECHTEN === 13 || KR_RECHTEN ===
        14 || KR_RECHTEN === 15) {
        return true;
      } else
        return false;
    },

    _deleteBeschikbaar(KR_RECHTEN) {
      if (KR_RECHTEN === 8 || KR_RECHTEN === 9 || KR_RECHTEN === 10 || KR_RECHTEN === 11 || KR_RECHTEN === 12 || KR_RECHTEN === 13 || KR_RECHTEN ===
        14 || KR_RECHTEN === 15) {
        return true;
      } else
        return false;
    },

    // Toevoegen component onzichtbaar maken indien er op geen enkele kast 'Openen' rechten zijn
    _toevoegenTonenOfNiet(toevoegenTonen, kasten, rechtenOpKasten) {
      for (var x = 0; x < rechtenOpKasten.length; x++) {
        if (rechtenOpKasten[x].enableAdd === true) {
          var huidigeKast = rechtenOpKasten[x];
          kasten.push([huidigeKast.K_ID, huidigeKast.OMSCHRIJVING]);
          this.toevoegenTonen = true;
        }
      }
    },

    _getBaseURL(dit) {
      return dit.$parent.$store.state.userInfo.loggedInConnectionObject.serverLocation
    },

    _getDocumentURL(docID, dit) {
      var r = this._getBaseURL(dit) + '/bin/filemanager.cgi/Doc/get'
      if (docID > 0) {
        r += '?D_ID=' + docID
      }
      return r
    },

    _getFileUploadURL(dit) {
      return this._getBaseURL(dit) + '/bin/filemanager.cgi/upload/put'
    },

    _getFileUploadDocumentkastURL(dit) {
      return this._getBaseURL(dit) + '/bin/filemanager.cgi/Doc/put'
    },

    _removeFileUploadDocumentkastURL(docID, dit) {
      var r = this._getBaseURL(dit) + '/bin/filemanager.cgi/Doc/remove'
      if (docID > 0) {
        r += '?D_ID=' + docID
      }
      return r
    },

    _typeComboSelecteren(list, id, veld, idName, eersteNietDefaultSelecteren) {
      if ((!eersteNietDefaultSelecteren) && isNaN(parseInt(id))) { // default eerste = Aanwezig selecteren
        veld = list[0]
      } else {
        for (let x = 0; x < list.length; x++) {
          let item = list[x]
          if (item[idName] + '' === id + '') {
            veld = item
          }
        }
      }
      return veld
    },

    _isAndroidOrIOS() {
      if (navigator.userAgent.match(/android/i) || navigator.userAgent.match(/(iPad|iPhone|iPod)/i)) {
        return true
      } else {
        return false
      }
    },

    _isIOS() {
      if (navigator.userAgent.match(/(iPad|iPhone|iPod)/i)) {
        return true
      } else {
        return false
      }
    },

    _isAndroid() {
      let useragent = navigator.userAgent.toLowerCase()
      if (useragent.indexOf('android') !== -1) {
        return true
      } else {
        return false
      }
    },

    _round(value, precision) {
      var multiplier = Math.pow(10, precision || 0)
      return Math.round(value * multiplier) / multiplier
    },

    _isAlphaNumeric: function (value) {
      var regExp = /^[A-Za-z0-9]+$/
      return (value.match(regExp))
    },

    _isAlphaNumericOrDot: function (value) {
      var regExp = /^[A-Za-z0-9.]+$/
      return (value.match(regExp))
    },

    _isValidCalculation: function (value) {
      var regExp = /^[*/+\-0-9(). ]+$/
      return (value.match(regExp))
    },

    _typeString(array, typeArray, joinText, toonLeesMachtigingNiveau) {
      var stringLijst = []
      for (var x = 0; x < array.length; x++) {
        var rec = array[x]
        for (var y = 0; y < typeArray.length; y++) {
          var type = typeArray[y]
          var recType = rec[type]
          if (type === 'Leesniveau' || type === 'Machtigingsniveau') {
            if (toonLeesMachtigingNiveau) {
              recType = '(' + recType + ')'
              stringLijst.push(recType)
            }
          } else {
            stringLijst.push(recType)
          }
        }
      }
      return stringLijst.join(joinText)
    },

    /*

    1ste bit actief => telkens "1" deel van de optelling
    0000 0001 = 1  (1)
    0000 0011 = 3  (2+1)
    0000 0101 = 5  (4+1)
    0000 0111 = 7  (4+2+1)
    0000 1001 = 9  (8+1)
    0000 1011 = 11 (8+2+1)
    ...

    2de bit actief => telkens "2" deel van de optelling
    0000 0010 = 2  (2)
    0000 0011 = 3  (2+1)
    0000 0110 = 6  (4+2)
    0000 0111 = 7  (4+2+1)
    0000 1010 = 10 (8+2)
    0000 1011 = 11 (8+2+1)
    0000 1110 = 14 (8+4+2)
    0000 1111 = 15 (8+4+2+1)
    ...

    3de bit actief => telkens "4" deel van de optelling
    0000 0100 = 4  (4)
    0000 0101 = 5  (4+1)
    0000 0110 = 6  (4+2)
    0000 0111 = 7  (4+2+1)
    0000 1100 = 12 (8+4)
    0000 1101 = 13 (8+4+2+1)
    0000 1110 = 14 (8+4+2)
    0000 1111 = 15 (8+4+2+1)
    ...

    Testcase starten met willekeurg decimaal getal 17 = 0001 0001 en daarbij derde bit activeren
    basicOperations._bitSet(17, 3) = 25  => klopt want 2a3 = 8 => 17 + 8 = 25 = 0001 0101
    basicOperations._bitTest(25, 3) = true
    basicOperations._bitClear(25, 3) = 17 => klopt want 2a3 = 8 => 25 - 8 = 17 = 0001 0001
    basicOperations._bitTest(17, 3) = false

    Dus binair ToetsFlags in puntenboekje:
    Bit 1 = doorgestuurd naar Wis@d => decimale waarden 1,3,5,7,9,11
    Bit 2 = vrije ingave formule => decimale waarde 1,3,6,7,10,11,14,15
    Bit 3 = Toch geen subformules berekenen
    ...

    Dus decimaal ToetsFlags db waarde in puntenboekje:
    ToetsFlags 1 = enkel doorgestuurd naar Wis@d actief => bit 0 opzetten ???
    ToetsFlags 2 = enkel weging formule actief
    ToetsFlags 3 = doorgestuurd en weging formule actief
    ToetsFlags 4 = sub formulesberekenen
    ToetsFlags 5 = doorgestuurd naar wis@d en geen sub formules berekenen actief
    ToetsFlags 6 = weging formule en toch geen sub formules berekenen actief
    ToetsFlags 7 = doorgestuurd naar wis@d en weging formule en geen sub formules actief
    ...

    basicOperations._bitSet(0, 0) = 1 => de eerste bit zetten of leegmaken doe je met 0 ipv 1 !!!!!!
    basicOperations._bitSet(0, 1) = 2
    basicOperations._bitSet(0, 2) = 4
    basicOperations._bitSet(0, 3) = 8

    */

    _bitTest: function (num, bit) { // eerste vlagje start bij 0 !!!
      return ((num >> bit) % 2 != 0)
    },

    _bitSet: function (num, bit) { // eerste vlagje start bij 0 !!!
      return num | 1 << bit;
    },

    _bitClear: function (num, bit) { // eerste vlagje start bij 0 !!!
      return num & ~(1 << bit);
    },

    _bitToggle: function (num, bit) { // eerste bit start bij 0 !!!
      return this.bit_test(num, bit) ? this.bit_clear(num, bit) : this.bit_set(num, bit);
    },

    _debounce(method, delay, dit) {
      clearTimeout(method._tId)
      method._tId = setTimeout(function () {
        method(dit)
      }, delay, dit)
    },
    _goTo: function (url) {
      url = url.charAt(0) === '/' ? url : '/' + url
      this.$router.push(url)
    },
    _goBack: function (custom) {
      this.$router.go(typeof custom === 'undefined' ? -1 : custom)
    },
    _isEmpty(field) {
      if (typeof field === 'undefined' || field === null || field === '') {
        return true
      }
    },
    _scrollTo(id) {
      setTimeout(
        function (id) {
          // herscrollen zonder component reload fix: eerst naar boven scrollen en dan pas herpostioneren
          $('#lijstje').stop().animate({
            scrollTop: 0
          }, 0, function () {
            var off = $(id).offset()
            if (off !== undefined) {
              let offset = off.top - 150
              $('#lijstje').scrollTop(offset) // .animate({ scrollTop: offset }, 300)
            }
          });

        },
        100,
        id
      )
    },
    _isInt(value) {
      var x
      if (isNaN(value)) {
        return false
      }
      x = parseFloat(value)
      return (x | 0) === x
    },
    _isNumber(n) {
      return !isNaN(parseFloat(n)) && isFinite(n)
    },
    _clone(obj) {
      if (Object(obj) !== obj) return obj
      if (typeof obj.toJSON === 'function') {
        return obj.toJSON()
      }
      var type = toString.call(obj).slice(8, -1)
      if (type in this._CLONE) {
        return this._CLONE[type].call(obj, this._clone)
      }
      var copy = {}
      var keys = Object.keys(obj)
      for (var i = 0, len = keys.length; i < len; i++) {
        var key = keys[i]
        copy[key] = this._clone(obj[key])
      }
      return copy
    },
    _actionOnMenuButton(menubar, buttonId, action, showHide) {
      if (menubar !== undefined && buttonId !== '') {
        let button = _.find(menubar, {
          id: buttonId
        })
        if (button !== undefined) {
          button[action] = showHide
        }
      } else {
        console.log('menu component niet gevonden')
      }
    },
    _openWebsite(url) {
      if (typeof cordova !== 'undefined') {
        console.log(cordova)
        console.log(window.open)
      }
      console.log(url)
      console.log('url ->')
      if (!url.startsWith('https://') && !url.startsWith('http://')) {
        url = 'https://' + url
      }
      console.log(url)
      window.open(url, '_system', 'location=no,toolbar=no,hardwareback=no,closebuttoncaption=Burada,footer=yes')
      // open(url, '_blank', 'location=no,toolbar=no,hardwareback=no,closebuttoncaption=Annuleren,footer=yes')
    },
    _goToAddress(address) {
      console.log('Opening website...')
      console.log(address)
      let baseUrl = 'https://www.google.com/maps/search/?api=1&query='
      let query = encodeURIComponent(address.trim())
      this._openWebsite(baseUrl + query)
    },
    _setUserPreference2(prefs, key, value) {
      console.log('setUserPreference')
      if (prefs !== undefined) {
        let waardes = JSON.parse(prefs.Value)
        waardes[key] = value
        prefs.Value = JSON.stringify(waardes)
      }
      return prefs
    },
    _findUserPreference(prefs, section, key) {
      if (prefs !== undefined) {
        for (let x = 0; x < prefs.length; x++) {
          let pref = prefs[x]
          if (pref.Section === section && pref.Name === key) {
            return pref
          }
        }
      }
      return -1
    },
    _setUserPreferenceOverAllPrefs(prefs, section, key, variable, value) {
      if (prefs !== undefined) {
        for (let x = 0; x < prefs.length; x++) {
          let pref = prefs[x]
          if (pref.Section === section && pref.Name === key) {
            let waardes = JSON.parse(pref.Value)
            waardes[variable] = value
            pref.Value = JSON.stringify(waardes)
            break
          }
        }
      }
      return prefs
    },

    _checkFotoBestaatOpFtp(imageUrl) {
      var http = new XMLHttpRequest()
      http.open('HEAD', imageUrl, false)
      http.send()
      return http.status !== 404
    },

    _loadLeerlingFoto(leerling, showFotos, leerlingID, rootState, dit) {
      if (showFotos) {
        var hexString = (parseInt(leerling[leerlingID])).toString(16).toLowerCase()
        var pad = '00000000'
        var ans = pad.substring(0, pad.length - hexString.length) + hexString + '.png'
        var volledigPad = rootState.userInfo.loggedInUserInformation.SessionConfig.FotoURL + 'leerling/small/' + ans
        var volledigPadLarge = rootState.userInfo.loggedInUserInformation.SessionConfig.FotoURL + 'leerling/medium/' + ans
        // if (this._checkFotoBestaatOpFtp(volledigPad)) {
        leerling.LL_FOTOURL = volledigPad
        leerling.LL_FOTOURL_MEDIUM = volledigPadLarge
        leerling.LL_FOTOURL_ORIGINEEL = ''
        /*if (!(_.isEmpty(leerling.LL_FOTOID))) { // Niet gebruiken, filemanager.cgi kan de grote hoeveelheid data niet altijd aan..
          leerling.LL_FOTOURL_ORIGINEEL = this._getDocumentURL(parseInt(leerling.LL_FOTOID), dit)
        }*/
      } else {
        leerling.LL_FOTOURL = './static/pics/no_photo.png'
      }
      if (!(_.isEmpty(leerling.punten))) {
        for (let x = 0; x < leerling.punten.length; x++) {
          let punt = leerling.punten[x]
          punt.LL_FOTOURL = leerling.LL_FOTOURL
          punt.LL_FOTOURL_MEDIUM = volledigPadLarge
          punt.LL_FOTOURL_ORIGINEEL = ''
          /*if (!(_.isEmpty(punt.LL_FOTOID))) { // Niet gebruiken, filemanager.cgi kan de grote hoeveelheid data niet altijd aan..
            punt.LL_FOTOURL_ORIGINEEL = this._getDocumentURL(parseInt(punt.LL_FOTOID), dit)
          }*/
        }
      }
      leerling.fotoExists = true
      return leerling
    },

    _loadLeerlingFotos(list, showFotos, leerlingID, rootState, dit) {
      for (let v = 0; v < list.length; v++) {
        let leerling = list[v]
        leerling = this._loadLeerlingFoto(leerling, showFotos, leerlingID, rootState, dit)
      }
      return list
    },

    _fotoSmallNietOpgehaald(list, singleRecord, leerlingID, id) {
      console.log('fotoNietOpgehaald:' + id)
      if (!(_.isEmpty(list))) {
        list.map(function (ll) {
          if (ll[leerlingID] === id) {
            ll.fotoExists = false
            // ll.LL_FOTOURL = ll.LL_FOTOURL_ORIGINEEL // Niet gebruiken, filemanager.cgi kan de grote hoeveelheid data niet altijd aan..
          }
        })
      } else {
        singleRecord.fotoExists = false
        //singleRecord.LL_FOTOURL = singleRecord.LL_FOTOURL_ORIGINEEL // Niet gebruiken, filemanager.cgi kan de grote hoeveelheid data niet altijd aan..
      }
    },

    /*
    // Niet gebruiken, filemanager.cgi kan de grote hoeveelheid data niet aan..
    _fotoOrigineelOokNietOpgehaald(list, singleRecord, leerlingID, id) {
      console.log('_fotoOrigineelOokNietOpgehaald:' + id)
      if (!(_.isEmpty(list))) {
        list.map(function (ll) {
          if (ll[leerlingID] === id) {
            ll.LL_FOTOURL_ORIGINEEL = ''
          }
        })
      } else {
        singleRecord.LL_FOTOURL_ORIGINEEL = ''
      }
    }, */


    _updateUserPreference(toBeSentObject) {
      var dezeDit = toBeSentObject.dit
      dezeDit.$store.dispatch('updateUserPreference', {
        toBeSentObject: toBeSentObject
      })
    },

    _insertUserPreference(toBeSentObject) {
      var dezeDit = toBeSentObject.dit
      dezeDit.$store.dispatch('insertUserPreference', {
        toBeSentObject: toBeSentObject
      })
    },

    _checkUserPrefsInsertOrUpdateIfNeeded(module, dit, screenName, screenID, section, key, value, specialResource) {
      var gevondenInPrefs = false
      var prefs = dit.$store.state.userpreferences
      if (module === 'wPuntenboekje') {
        prefs = dit.$store.state[module].userpreferences // komen van puntenboek databank en state
      }
      if (section === 'FLAGS') {
        if (value === true) {
          value = '1'
        } else {
          value = '0'
        }
      }
      if (prefs !== undefined && prefs.length > 0) {
        for (let x = 0; x < prefs.length; x++) {
          let pref = prefs[x]
          if (pref.SchermNaam === screenName && pref.Section === section && pref.Name === key) {
            gevondenInPrefs = true
            if (pref.Value !== value) {
              pref.Value = value
              this._updateUserPreference({
                module: module,
                dit: dit,
                updateRec: pref,
                specialResource: specialResource
              })
            } else {
              console.log('userpreference niet gewijzigd')
            }
          }
        }
      }

      if (!gevondenInPrefs) {
        if (!(section === 'FLAGS' && (!value))) { // niet onnodig gedeactiveerde vlagjes aanmaken
          this._insertUserPreference({
            module: module,
            dit: dit,
            newRec: {
              Section: section,
              Name: key,
              SchermNaam: screenName,
              SchermID: screenID,
              UserID: dit.$root.$store.state.userInfo.loggedInUserInformation.UserData.userid,
              Value: value
            },
            specialResource: specialResource
          })
        }
      }
    },

    _getUserPreference(dit, screenName, section, key) {
      var prefs = dit.$store.state.userpreferences
      if (prefs !== undefined && prefs.length > 0) {
        for (let x = 0; x < prefs.length; x++) {
          let pref = prefs[x]
          if (pref.SchermNaam === screenName && pref.Section === section && pref.Name === key) {
            return pref
          }
        }
      }
      return null
    },

    _getUserPreferenceValue(dit, screenName, section, key) {
      var pref = this._getUserPreference(dit, screenName, section, key)
      if (pref !== null) {
        if (pref.Value + '' === '1') {
          return true
        } else if (pref.Value + '' === '0') {
          return false
        } else {
          return pref.Value
        }
      }
    }



  }
}