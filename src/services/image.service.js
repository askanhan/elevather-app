/**
 * Service pour gérer les URLs des images
 * Support for local assets and HTTPS URLs
 */
export default class ImageService {
  constructor() {
    // Base path for images - using static folder which is public
    this.basePath = '/static/img/courses_images/'
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

    // Directly construct and return the image URL
    return this.basePath + justFilename
  }

  /**
   * Get placeholder image (SVG data URI)
   * @returns {string} - SVG data URI for placeholder
   */
  getPlaceholder() {
    return 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="400" height="300"%3E%3Crect fill="%23ddd" width="400" height="300"/%3E%3Ctext x="50%25" y="50%25" dominant-baseline="middle" text-anchor="middle" font-family="Segoe UI,Arial" font-size="18" fill="%23999"%3ENo image available%3C/text%3E%3C/svg%3E'
  }
}
