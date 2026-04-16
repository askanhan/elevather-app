import ImageService from '@/services/image.service.js'

const imageService = new ImageService()

export default {
  methods: {
    /**
     * Get resolved image URL
     * @param {string|object} imageInput - image source
     * @param {string} fallback - fallback filename
     * @returns {string} - resolved URL
     */
    getImageUrl(imageInput, fallback = null) {
      return imageService.getImageUrl(imageInput, fallback)
    },

    /**
     * Get placeholder image URL
     * @returns {string} - placeholder image data URI
     */
    getPlaceholderImage() {
      return imageService.getPlaceholder()
    },

    /**
     * Check if image URL is valid
     * @param {string} url - URL to validate
     * @returns {boolean}
     */
    isValidImageUrl(url) {
      return imageService.isValidImageUrl(url)
    },

    /**
     * Find similar image by name
     * @param {string} searchName - filename to search
     * @returns {string|null} - similar image or null
     */
    findSimilarImage(searchName) {
      return imageService.findSimilarImage(searchName)
    }
  }
}
