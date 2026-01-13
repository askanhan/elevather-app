// https://eslint.org/docs/user-guide/configuring

module.exports = {
  root: true,
  globals: {
    "_": true,
    "lodash": true,
    "jquery": true,
    "moment": true,
    "localforage": true,
    "$": true,
    "CONNECTIES": true,
    "cordova": true,
    "require": true,
  	"StatusBar": true
  },
  parserOptions: {
    parser: 'babel-eslint',
    "ecmaFeatures": {
      "experimentalObjectRestSpread": true
    }
  },
  env: {
    browser: true,
  },
  extends: [
    // https://github.com/vuejs/eslint-plugin-vue#priority-a-essential-error-prevention
    // consider switching to `plugin:vue/strongly-recommended` or `plugin:vue/recommended` for stricter rules.
    'plugin:vue/strongly-recommended',
    // https://github.com/standard/standard/blob/master/docs/RULES-en.md
    //'standard' // VS Code herstarten+wachten
    'eslint:recommended'
  ],
  // required to lint *.vue files
  plugins: [
    'vue'
  ],
  // add your custom rules here
  rules: {
    "no-console": 0,
    "no-unused-vars": 0,
    // allow async-await
    'generator-star-spacing': 'off',
    'new-cap': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
  }
}
