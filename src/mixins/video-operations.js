import VideoService from '@/services/video.service.js'

const videoService = new VideoService()

export default {
  methods: {
    /**
     * Get resolved video URL
     * @param {string|object} videoInput - video source
     * @param {string} fallback - fallback filename
     * @returns {string} - resolved URL
     */
    getVideoUrl(videoInput, fallback = null) {
      return videoService.getVideoUrl(videoInput, fallback)
    }
  }
}
