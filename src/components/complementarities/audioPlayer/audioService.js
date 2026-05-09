/**
 * AudioService - Singleton for centralized audio management
 * Handles: state, caching, backend requests, playback control
 */

import axios from 'axios'
import AppConfig from '@/config/app.config.js'
import AudioConfig from '@/config/audio.config.js'

const audioCache = new Map() // Cache: `${ownerType}-${ownerId}` -> { url, timestamp }
let currentAudioElement = null
let currentAudioState = 'idle' // idle, loading, playing, paused
let currentKey = null // Current owner key for tracking

const CACHE_DURATION_MS = AudioConfig.CACHE_DURATION_MS || 86400000 // 24 hours

class AudioService {
  constructor() {
    if (AudioService.instance) {
      return AudioService.instance
    }
    AudioService.instance = this
  }

  /**
   * Get API instance (lazy-loaded to avoid circular dependencies)
   */
  getApiInstance() {
    try {
      return require('@/store/actions.js').api
    } catch (e) {
      // Fallback if actions.js not loaded yet
      return axios.create({
        baseURL: AppConfig.API_BASE_URL,
        withCredentials: false
      })
    }
  }

  /**
   * Load audio from backend or cache
   * @param {string} ownerType - Type: 'card' or 'step'
   * @param {number} ownerId - ID of the owner
   * @returns {Promise<string>} Object URL for the audio blob
   */
  async loadAudio(ownerType, ownerId) {
    const key = `${ownerType}-${ownerId}`
    
    // Check cache first
    if (audioCache.has(key)) {
      const cached = audioCache.get(key)
      if (Date.now() - cached.timestamp < CACHE_DURATION_MS) {
        console.log(`[AudioService] Using cached audio for ${key}`)
        return cached.url
      }
      audioCache.delete(key)
    }

    // Stop any currently playing audio
    if (currentAudioElement && currentKey !== key) {
      this.stop()
    }

    try {
      currentAudioState = 'loading'
      
      // Fetch audio blob directly from backend endpoint
      const response = await fetch(
        `${AppConfig.API_BASE_URL}/audio/fetch/${ownerType}/${ownerId}/`
      )
      
      if (!response.ok) {
        throw new Error(`Backend error: ${response.status} ${response.statusText}`)
      }

      // Get the blob directly from response
      const blob = await response.blob()
      if (!blob) {
        throw new Error('No audio blob in response')
      }

      // Create Object URL for the blob
      const audioUrl = URL.createObjectURL(blob)

      // Cache it
      audioCache.set(key, {
        url: audioUrl,
        timestamp: Date.now()
      })

      currentKey = key
      console.log(`[AudioService] Loaded audio for ${key}:`, audioUrl)
      return audioUrl
    } catch (error) {
      console.error(`[AudioService] Failed to load audio for ${key}:`, error)
      currentAudioState = 'idle'
      throw error
    }
  }

  /**
   * Create or get audio element
   */
  getAudioElement() {
    if (!currentAudioElement) {
      currentAudioElement = new Audio()
      currentAudioElement.addEventListener('ended', () => {
        currentAudioState = 'idle'
        currentKey = null
      })
      currentAudioElement.addEventListener('play', () => {
        currentAudioState = 'playing'
      })
      currentAudioElement.addEventListener('pause', () => {
        currentAudioState = 'paused'
      })
    }
    return currentAudioElement
  }

  /**
   * Play audio
   */
  play() {
    const audio = this.getAudioElement()
    if (audio.paused) {
      audio.play()
    }
  }

  /**
   * Pause audio
   */
  pause() {
    const audio = this.getAudioElement()
    if (!audio.paused) {
      audio.pause()
    }
  }

  /**
   * Stop audio and reset
   */
  stop() {
    const audio = this.getAudioElement()
    audio.pause()
    audio.currentTime = 0
    currentAudioState = 'idle'
    currentKey = null
  }

  /**
   * Set audio source and play
   */
  setSourceAndPlay(url) {
    const audio = this.getAudioElement()
    audio.src = url
    audio.play()
  }

  /**
   * Query: Is audio currently playing?
   */
  isPlaying() {
    return currentAudioState === 'playing'
  }

  /**
   * Query: Get current state
   */
  getCurrentState() {
    return currentAudioState
  }

  /**
   * Query: Get current playback time (seconds)
   */
  getCurrentTime() {
    return this.getAudioElement().currentTime || 0
  }

  /**
   * Query: Get total duration (seconds)
   */
  getDuration() {
    return this.getAudioElement().duration || 0
  }

  /**
   * Set playback volume (0-1)
   */
  setVolume(vol) {
    this.getAudioElement().volume = Math.max(0, Math.min(1, vol))
  }

  /**
   * Get playback volume
   */
  getVolume() {
    return this.getAudioElement().volume
  }

  /**
   * Set playback speed
   */
  setPlaybackRate(rate) {
    this.getAudioElement().playbackRate = rate
  }

  /**
   * Clear cache
   */
  clearCache() {
    audioCache.clear()
  }
  /**
   * Query: Get current state
   */
  getCurrentState() {
    return currentAudioState
  }

  // ---> ADD THIS NEW METHOD <---
  /**
   * Query: Get the key of the currently loaded audio
   */
  getCurrentKey() {
    return currentKey
  }

  /**
   * Cleanup - call on component destroy
   */
  cleanup() {
    this.stop()
    if (currentAudioElement) {
      currentAudioElement.removeEventListener('ended', null)
      currentAudioElement.removeEventListener('play', null)
      currentAudioElement.removeEventListener('pause', null)
    }
  }
}

export default new AudioService()
