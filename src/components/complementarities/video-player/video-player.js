import Vue from 'vue'
export default {
  name: 'VideoPlayer',
  props: {
    source: '',
    playNow: {
      type: Boolean,
      default: false
    },
    thumbnailvideo: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      uniqueID: parseInt(Math.random() * 1000000000),
      id: '',
      fullScreen: false,
      videoPaused: false,
      isMuted: false
    }
  },

  computed: { // cached and changed only if one of its dependencies is changed
  },
  created() {
    this.id = this.source + '-' + this.uniqueID
  },
  mounted() { },
  methods: {
    visibilityChanged(visible) {
      console.log('IS VISIBLEEEEEEEEEEEEEEEEEEE?')
      console.log('VIDEOOOOOOO')
      console.log(visible)
      if(visible){
        // this.playNow = true
        this.$refs.myDiv.play()
        this.videoPaused = false
      }
      if(!visible){
        this.$refs.myDiv.pause()
        this.videoPaused = true
        console.log('stop')
      }
    },
    getExtension(name) {
      let res = name.split('.')[name.split('.').length - 1]
      res = res.toLowerCase()
      if(res === 'mov'){
        return 'mp4'
      }else{
        return res
      }
    },
    playVideo() {
      if (this.thumbnailvideo) {
        console.log('vvvvvvvvvvvvvvvv')
        this.fullScreen = true
        console.log(this.fullScreen)
      }
      if (this.$refs.myDiv.paused) {
        this.$refs.myDiv.play();
        this.videoPaused = false
        // this.isMuted = true
      } else {
        this.$refs.myDiv.pause()
        this.videoPaused = true
      }
    }
  },
  watch: {}
}