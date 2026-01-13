'use strict'
module.exports = {
  compilerOptions: {
    compatConfig: {
      MODE: 2
    }
  },
  transformAssetUrls: {
    video: ['src', 'poster'],
    source: 'src',
    img: ['src'],
    image: 'xlink:href'
  }
}
