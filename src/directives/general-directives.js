import { createApp } from 'vue'
import strOperations from '@/mixins/string-operations.js'

const app = createApp({})

// Directive: begin-met-hoofdletter
app.directive('begin-met-hoofdletter', {
  beforeMount(el) {
    let text = el.textContent
    el.textContent = strOperations.methods._capitalizeFirstLetters(text)
  }
})

// Directive: show-in-desktop-mode
const showInDesktopModeDirectiveFunction = (el, binding) => {
  let isDesktopModeOn = window.innerWidth > 800
  let showInDesktopMode = binding.value === true
  let showValue = binding.arg ? binding.arg : 'initial'
  if (isDesktopModeOn) {
    el.style.display = showInDesktopMode ? showValue : 'none'
  } else {
    el.style.display = showInDesktopMode ? 'none' : showValue
  }
}

app.directive('show-in-desktop-mode', {
  beforeMount: showInDesktopModeDirectiveFunction,
  updated: showInDesktopModeDirectiveFunction
})

// Directive: focus
app.directive('focus', {
  mounted(el) {
    el.focus()
  }
})

// Directive: long-press
app.directive('long-press', {
  beforeMount(el, binding) {
    if (typeof binding.value !== 'function') {
      console.warn(`[longpress:] provided expression '${binding.expression}' is not a function.`)
      return
    }

    let startX, startY, teller = 0, actieveTimer

    const myTimer = () => {
      teller += 100
    }

    const touchStart = (e) => {
      teller = 0
      clearInterval(actieveTimer)
      startX = e.touches[0].pageX
      startY = e.touches[0].pageY
      actieveTimer = setInterval(myTimer, 100)
    }

    const touchEnd = (e) => {
      if (teller > 500) {
        const endX = e.changedTouches[0].pageX
        const endY = e.changedTouches[0].pageY
        const afstandX = Math.abs(startX - endX)
        const afstandY = Math.abs(startY - endY)
        if (afstandX < 70 && afstandY < 60) {
          binding.value(e)
        }
      }
      teller = 0
      clearInterval(actieveTimer)
    }

    const touchCancel = () => {
      teller = 0
      clearInterval(actieveTimer)
    }

    el.addEventListener('touchstart', touchStart, { passive: true })
    el.addEventListener('touchend', touchEnd, { passive: true })
    el.addEventListener('touchcancel', touchCancel, { passive: true })
  }
})
