'use strict'
const { merge } = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  GOOGLE_CLIENT_ID: '"XXX.apps.googleusercontent.com"',
  API_BASE_URL: '"http://127.0.0.1:8000/"',
  IS_PROD: false
})
