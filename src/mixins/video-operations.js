import VideoService from '@/services/video.service.js'

const videoService = new VideoService()

export default {
  methods: {
    /**
     * Get resolved video URL
     * @param {string|object} videoInput - video source
     * @param {string} fallback - fallback filename
     * @param {string} videoType - 'course' or 'simulator' context
     * @returns {string} - resolved URL
     */
    getVideoUrl(videoInput, fallback = null, videoType = 'course') {
      return videoService.getVideoUrl(videoInput, fallback, videoType)
    }
  }
}
