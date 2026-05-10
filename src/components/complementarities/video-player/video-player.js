export default {
  name: 'VideoPlayer',
  props: {
    source: {
      type: String,
      default: ''
    },
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
  computed: {
    // 1. Detect if the source string belongs to YouTube
    isYouTube() {
      if (!this.source) return false;
      return this.source.includes('youtube.com') || this.source.includes('youtu.be');
    },

    // 2. Extract the ID and build the embed iframe link
    youtubeEmbedUrl() {
      if (!this.isYouTube) return '';
      
      // Regex'i YouTube Shorts linklerini de yakalayacak şekilde biraz geliştirdim
      const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=|\/shorts\/)([^#&?]*).*/;
      const match = this.source.match(regExp);
      const videoId = (match && match[2].length === 11) ? match[2] : null;

      if (videoId) {
        // Mevcut domaini alıyoruz (Capacitor'da genellikle http://localhost olur)
        const currentOrigin = window.location.origin;

        // youtube-nocookie.com kullanımı iframe hatalarını büyük ölçüde azaltır
        // origin parametresi Capacitor ve web güvenliği için çok önemlidir
        let url = `https://www.youtube-nocookie.com/embed/${videoId}?rel=0&playsinline=1&modestbranding=1&origin=${encodeURIComponent(currentOrigin)}`;
        
        if (this.playNow) url += '&autoplay=1';
        
        // Autoplay kuralları gereği, ses açıkken otomatik oynatmaya tarayıcılar izin vermeyebilir, 
        // bu yüzden sessiz (mute=1) başlatmak her zaman daha güvenlidir.
        if (this.isMuted) url += '&mute=1';
        
        url += `&loop=1&playlist=${videoId}`; 
        
        return url;
      }
      return '';
    },
  },
  created() {
    this.id = 'video-' + this.uniqueID;
  },
  methods: {
    getExtension(url) {
      if (!url) return '';
      return url.split('.').pop().split(/\#|\?/)[0];
    },
    playVideo() {
      if (this.isYouTube) return; // YouTube handles its own play state via iframe

      const video = this.$refs.myDiv;
      if (video) {
        if (video.paused) {
          video.play();
          this.videoPaused = false;
        } else {
          video.pause();
          this.videoPaused = true;
        }
      }
    },
    getExtension(name) {
      let res = name.split('.')[name.split('.').length - 1]
      res = res.toLowerCase()
      if (res === 'mov') {
        return 'mp4'
      } else {
        return res
      }
    },
    // playVideo() {
    //   if (this.thumbnailvideo) {
    //     console.log('vvvvvvvvvvvvvvvv')
    //     this.fullScreen = true
    //     console.log(this.fullScreen)
    //   }
    //   if (this.$refs.myDiv.paused) {
    //     this.$refs.myDiv.play();
    //     this.videoPaused = false
    //     // this.isMuted = true
    //   } else {
    //     this.$refs.myDiv.pause()
    //     this.videoPaused = true
    //   }
    // }
  }
}

