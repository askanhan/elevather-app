import Vue from 'vue'
//import icons from '@/mixins/icons.js'
Vue.filter('getJaarvorderingsplannenMainLogo', (publisher) => {
  switch (publisher) {
    case 'vanIn':
      return './static/pics/' + 'van-in-logo.png';
    case 'LLinkID':
      return './static/pics/' + 'LLinkID-logo.png';
  }
})

Vue.filter('getJaarvorderingsplannenMainLogoFontAwesome', (publisher) => {
  switch (publisher) {
    case 'custom':
      return 'fal fa-university' //icons.JAARVORDERINGSPLANNEN;
  }
})


Vue.filter('getJaarvorderingsplannenIcon', (publisher) => {
  switch (publisher) {
    case 'vanIn':
      return './static/pics/' + 'van-in-icon.png';
    case 'LLinkID':
      return './static/pics/' + 'llinkid-icon.png';
  }
})
