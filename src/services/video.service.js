/**
 * Service pour gérer les URLs des vidéos
 * Support for local assets and HTTPS URLs
 */
export default class VideoService {
  constructor() {
    // Base path for videos - using static folder which is public
    this.basePath = '/static/videos/courses_videos/'
  }

  /**
   * Resolve video URL from various sources
   * @param {string|object} videoInput - video URL, filename, or object with video properties
   * @param {string} fallbackFilename - fallback filename if primary fails
   * @returns {string} - resolved video URL
   */
  getVideoUrl(videoInput, fallbackFilename = null) {
    // If it's an HTTPS URL, use it directly
    if (typeof videoInput === 'string' && videoInput.startsWith('http')) {
      return videoInput
    }

    // If it's a filename, try to find it in assets
    if (typeof videoInput === 'string' && videoInput.trim()) {
      return this.resolveLocalVideo(videoInput)
    }

    // If object with video properties, check various fields
    if (typeof videoInput === 'object' && videoInput) {
      if (videoInput.video_url && videoInput.video_url.startsWith('http')) {
        return videoInput.video_url
      }
      if (videoInput.video) {
        return this.resolveLocalVideo(videoInput.video)
      }
      if (videoInput.videoName) {
        return this.resolveLocalVideo(videoInput.videoName)
      }
    }

    // Use fallback if provided
    if (fallbackFilename) {
      return this.resolveLocalVideo(fallbackFilename)
    }

    // Return placeholder
    return this.getPlaceholder()
  }

  /**
   * Resolve local video from assets
   * @param {string} filename - video filename
   * @returns {string} - resolved asset URL
   */
  resolveLocalVideo(filename) {
    if (!filename || typeof filename !== 'string') {
      return this.getPlaceholder()
    }

    // Extract just the filename if it's a full path
    const justFilename = filename.split('/').pop()

    // Directly construct and return the video URL
    return this.basePath + justFilename
  }

  /**
   * Get placeholder video (SVG data URI)
   * @returns {string} - SVG data URI for placeholder
   */
  getPlaceholder() {
    return 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="400" height="300"%3E%3Crect fill="%23ddd" width="400" height="300"/%3E%3Ctext x="50%25" y="45%25" dominant-baseline="middle" text-anchor="middle" font-family="Segoe UI,Arial" font-size="18" fill="%23999"%3EVideo not available%3C/text%3E%3C/svg%3E'
  }
}
