/**
 * Service pour gérer les URLs des images
 * Support for local assets and HTTPS URLs
 */
export default class ImageService {
  constructor() {
    // Base path for images - using static folder which is public
    this.basePath = '/static/img/courses_images/'
    
    // Cache des images disponibles dans assets
    this.availableImages = [
      '1_AVITEUM_Day_9.png',
      '1_AVITEUM_image 1.png',
      '1_AVITEUM_image 1_Day 6.png',
      '1_AVITEUM_image 2.png',
      '1_AVITEUM_image 3.png',
      '1_AVITEUM_image 4.png',
      '1_AVITEUM_image 5.png',
      '1_AVITEUM_image 6.png',
      '1_AVITEUM_image 7.png',
      '1_AVITEUM_image 8.png',
      '3.png',
      '4.png',
      'AVITEUM_Day 13_BRAND_images.png',
      'AVITEUM_day 8_Meditation.png',
      'AVITEUM_image 1_Day 7_Breathwork.png',
      'Hannah_Arendt.jpg',
      'image_card1.png',
      'KANE_image01.png',
      'KANE_image02.png',
      'KANE_image03.png',
      'KANE_image04.png',
      'KANE_Image08.png',
      'KANE_Image_Day17_card2.png',
      'KANE_Image_Day17_card6.png',
      'KANE_Image_Day18_card4.png'
    ]
  }

  /**
   * Resolve image URL from various sources
   * @param {string|object} imageInput - image URL, filename, or object with image properties
   * @param {string} fallbackFilename - fallback filename if primary fails
   * @returns {string} - resolved image URL
   */
  getImageUrl(imageInput, fallbackFilename = null) {
    // If it's an HTTPS URL, use it directly
    if (typeof imageInput === 'string' && imageInput.startsWith('http')) {
      return imageInput
    }

    // If it's a filename, try to find it in assets
    if (typeof imageInput === 'string' && imageInput.trim()) {
      return this.resolveLocalImage(imageInput)
    }

    // If object with image properties, check various fields
    if (typeof imageInput === 'object' && imageInput) {
      if (imageInput.image_url && imageInput.image_url.startsWith('http')) {
        return imageInput.image_url
      }
      if (imageInput.image) {
        return this.resolveLocalImage(imageInput.image)
      }
      if (imageInput.thumbnail) {
        return this.resolveLocalImage(imageInput.thumbnail)
      }
      if (imageInput.imageName) {
        return this.resolveLocalImage(imageInput.imageName)
      }
    }

    // Use fallback if provided
    if (fallbackFilename) {
      return this.resolveLocalImage(fallbackFilename)
    }

    // Return placeholder
    return this.getPlaceholder()
  }

  /**
   * Resolve local image from assets
   * @param {string} filename - image filename
   * @returns {string} - resolved asset URL
   */
  resolveLocalImage(filename) {
    if (!filename || typeof filename !== 'string') {
      return this.getPlaceholder()
    }

    // Extract just the filename if it's a full path
    const justFilename = filename.split('/').pop()

    // Check if file exists in available images
    if (this.availableImages.includes(justFilename)) {
      return this.basePath + justFilename
    }

    // Try to find a similar image by comparing names
    const similarImage = this.findSimilarImage(justFilename)
    if (similarImage) {
      return this.basePath + similarImage
    }

    return this.getPlaceholder()
  }

  /**
   * Find a similar image based on filename
   * @param {string} searchName - filename to search for
   * @returns {string|null} - similar image or null
   */
  findSimilarImage(searchName) {
    if (!searchName) return null

    const searchLower = searchName.toLowerCase()

    // Exact match
    const exact = this.availableImages.find(img => img.toLowerCase() === searchLower)
    if (exact) return exact

    // Find by prefix
    const prefix = searchLower.split(/[\s_\-.]/).shift()
    if (prefix && prefix.length > 2) {
      const byPrefix = this.availableImages.find(img =>
        img.toLowerCase().startsWith(prefix)
      )
      if (byPrefix) return byPrefix
    }

    // Find by keyword
    const keywords = searchLower.split(/[\s_\-.]/).filter(w => w.length > 2)
    for (const keyword of keywords) {
      const byKeyword = this.availableImages.find(img =>
        img.toLowerCase().includes(keyword)
      )
      if (byKeyword) return byKeyword
    }

    return null
  }

  /**
   * Get placeholder image (SVG data URI)
   * @returns {string} - SVG data URI for placeholder
   */
  getPlaceholder() {
    return 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="400" height="300"%3E%3Crect fill="%23ddd" width="400" height="300"/%3E%3Ctext x="50%25" y="50%25" dominant-baseline="middle" text-anchor="middle" font-family="Segoe UI,Arial" font-size="18" fill="%23999"%3ENo image available%3C/text%3E%3C/svg%3E'
  }

  /**
   * Check if an image URL is valid/exists
   * @param {string} url - image URL to check
   * @returns {boolean}
   */
  isValidImageUrl(url) {
    if (!url) return false
    if (typeof url !== 'string') return false
    if (url.startsWith('data:')) return true
    if (url.startsWith('http')) return true
    if (this.availableImages.some(img => url.includes(img))) return true
    return false
  }
}
