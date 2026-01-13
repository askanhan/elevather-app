import { createI18n } from 'vue-i18n'
import tr from './locales/tr.json'
import nl from './locales/nl.json'
import fr from './locales/fr.json'
import en from './locales/en.json'

export const i18n = createI18n({
  legacy: false,
  globalInjection: true,
  locale: 'en',
  fallbackLocale: 'en',
  messages: { tr, nl, fr, en }
})