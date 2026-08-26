import { reactive } from 'vue'

const STORAGE_KEY = 'FONT_SCALE_LEVEL'
const MIN_LEVEL = -2
const MAX_LEVEL = 2
const LEVEL_CLASS_NAMES = ['font-scale-xs', 'font-scale-sm', '', 'font-scale-lg', 'font-scale-xl']

function readStoredLevel() {
  const stored = parseInt(localStorage.getItem(STORAGE_KEY), 10)
  if (Number.isNaN(stored)) return 0
  return Math.min(MAX_LEVEL, Math.max(MIN_LEVEL, stored))
}

const state = reactive({
  level: readStoredLevel()
})

function setLevel(level) {
  state.level = Math.min(MAX_LEVEL, Math.max(MIN_LEVEL, level))
  localStorage.setItem(STORAGE_KEY, state.level)
}

export const fontScaleState = state

export const canIncreaseFontScale = () => state.level < MAX_LEVEL
export const canDecreaseFontScale = () => state.level > MIN_LEVEL

export function increaseFontScale() {
  setLevel(state.level + 1)
}

export function decreaseFontScale() {
  setLevel(state.level - 1)
}

export function fontScaleClass() {
  return LEVEL_CLASS_NAMES[state.level - MIN_LEVEL]
}
