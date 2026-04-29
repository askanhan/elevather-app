// Utiliser la variable d'environnement si disponible, sinon false pour développement
const IS_PROD = true //process.env.NODE_ENV === 'production'

export default {
  IS_PROD,

  API_BASE_URL: IS_PROD
    ? 'https://app.elevather.eu/'
    : 'http://127.0.0.1:8000/',

  WEB_BASE_URL: IS_PROD
    ? 'https://elevather.eu/'
    : 'http://127.0.0.1:8080/',
}