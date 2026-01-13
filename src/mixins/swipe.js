export default { // uniqueIdOfToBeSwipedElement and the functions _swipedLeft, _swipedRight are required to define ***
  data () {
    return {
      _swipe_xDown: null,
      _swipe_yDown: null
    }
  },
  mounted () {
    this._initializeSwipe(this.uniqueIdOfToBeSwipedElement)
  },
  methods: {
    _initializeSwipe (idOfElement) {
      let element = document.getElementById(idOfElement)
      if (element === null) {
        console.error('Swipe-Mixin: please define uniqueIdOfToBeSwipedElement var for Unique ID of your to be swiped element, in your data')
      } else {
        console.log('_initializeSwipe')
        element.addEventListener('touchstart', this._handleTouchStart, false)
        element.addEventListener('touchmove', this._handleTouchMove, false)
        this._swipe_xDown = null
        this._swipe_yDown = null
      }
    },
    _handleTouchMove (evt) {
      if (!this._swipe_xDown || !this._swipe_yDown) {
        return
      }

      let xUp = evt.touches[0].clientX
      let yUp = evt.touches[0].clientY

      let xDiff = this._swipe_xDown - xUp
      let yDiff = this._swipe_yDown - yUp
      let xDiffAbs = Math.abs(xDiff)
      let yDiffAbs = Math.abs(yDiff)
      let distance = xDiff - yDiff
      let distanceAbs = Math.abs(xDiffAbs - yDiffAbs)
      console.log('--')
      console.log(xDiff)
      console.log(xDiffAbs)
      console.log(yDiff)
      console.log(yDiffAbs)
      console.log(distance)
      console.log(distanceAbs)
      if (xDiffAbs > yDiffAbs && xDiffAbs > 5 && distanceAbs >= 4 && yDiffAbs <= 5) { /* most significant */
        if (xDiff > 0) {
          console.log('-------------------------------------------------------left swipe')
          this._swipedLeft()
        } else {
          console.log('-------------------------------------------------------right swipe')
          this._swipedRight()
        }
      }
      /* reset values */
      this._swipe_xDown = null
      this._swipe_yDown = null
    },
    _handleTouchStart (evt) {
      console.log('_handleTouchStart')

      function getTouches (evt) {
        return evt.touches || // browser API
          evt.originalEvent.touches // jQuery
      }
      this._swipe_xDown = getTouches(evt)[0].clientX
      this._swipe_yDown = getTouches(evt)[0].clientY
    },
    _swipedLeft () {
      console.error('Swipe-Mixin: Please define a _swipedLeft function inside your component')
    },
    _swipedRight () {
      console.error('Swipe-Mixin: Please define a _swipedRight function inside your component')
    }
  }
}
