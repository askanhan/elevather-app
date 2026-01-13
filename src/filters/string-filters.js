import strOperations from '@/mixins/string-operations.js'

export default {
  install(app) {
    app.config.globalProperties.$filters = {
      capitalizeFirstLetters(value) {
        return strOperations.methods._capitalizeFirstLetters(value)
      },
      capitalizeOnlyFirstLetters(value) {
        return strOperations.methods._capitalizeFirstLetter(value)
      },
      removeSpecialChars(value) {
        return strOperations.methods._removeSpecialChars(value)
      }
    }
  }
}
