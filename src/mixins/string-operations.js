/* global module */
module.exports = {
  methods: {

    _escapeRegExp(str) {
      // eslint-disable-next-line
      return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
    },

    formatWithXdecimals(value, X) {
      return parseFloat(parseFloat(value).toFixed(X))
    },

    _replaceAll(str, find, replace) {
      return str.replace(new RegExp(this._escapeRegExp(find), 'g'), replace);
    },

    _removeSpecialChars(text) {
      return text.replace(/[^\w\s]/gi, '')
    },
    _isAlphanumeric(str) {
      return (
        str.length === 0 ||
        str.replace(/[^a-zA-Z0-9]/gi, '').length === str.length
      )
    },

    _containsAlphabetic(str) {
      return (
        /[a-z]/.test(str.toLowerCase())
      )
    },

    _isAlphabetic(str) {
      return (
        str.length === 0 || str.replace(/[^a-zA-Z]/gi, '').length === str.length
      )
    },
    _isString(str) {
      return typeof str === 'string'
    },
    _capitalizeFirstLetter(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase()
    },
    _capitalizeFirstLetters(str) {
      if (this._isString(str)) {
        return str
          .split(' ')
          .map(this._capitalizeFirstLetter)
          .join(' ')
      }
      return ''
    },
    _isEmptyOrUngiven(str) {
      return (typeof str === 'undefined' || str === null || str === '' || str === 'undefined' || str === 'null')
    }
  }
}
