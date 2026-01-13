const IS_PROD = true
// const IS_PROD = false

export default {
  IS_PROD,

  API_BASE_URL: IS_PROD
    ? 'https://api.burada.be/'
    : 'http://127.0.0.1:8000/',

  WEB_BASE_URL: IS_PROD
    ? 'https://burada.be/'
    : 'http://127.0.0.1:8080/',
}