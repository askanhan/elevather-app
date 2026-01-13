import Vue from 'vue'
import bao from '@/mixins/basic-operations.js'
var basicOperations = bao.methods
Vue.filter('bit3Active', (num) => {
  if (basicOperations._bitTest(num, 3)) {
    return 'Ja'
  } else {
    return 'Nee'
  }
})
