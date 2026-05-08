import ImageService from '@/services/image.service.js'

const imageService = new ImageService()

export default {
  methods: {
    /**
     * Get resolved image URL
     * @param {string|object} imageInput - image source
     * @param {string} fallback - fallback filename
     * @param {string} imageType - 'course' or 'simulator' (default: 'course')
     * @returns {string} - resolved URL
     */
    getImageUrl(imageInput, fallback = null, imageType = 'course') {
      return imageService.getImageUrl(imageInput, fallback, imageType)
    }
  }
}
