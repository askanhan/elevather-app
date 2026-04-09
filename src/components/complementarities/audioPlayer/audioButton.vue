<template>
  <div class="audio-button-wrapper">
    <button
      class="audio-button"
      :class="[`state-${state}`, { loading: isLoading }]"
      @click="handleClick"
      :aria-label="`Play audio for ${ownerType} ${ownerId}`"
      :title="buttonTitle"
      :disabled="isLoading"
    >
      <span class="audio-icon">🔊</span>
    </button>
  </div>
</template>

<script>
import audioService from './audioService.js'
import { mapState } from 'vuex'

export default {
  name: 'AudioButton',
  props: {
    ownerType: {
      type: String,
      required: true,
      validator: (val) => ['card', 'step'].includes(val)
    },
    ownerId: {
      type: [String, Number],
      required: true
    }
  },
  data() {
    return {
      state: 'idle', // idle, loading, playing, paused
      isLoading: false,
      audioUrl: null,
      pollInterval: null
    }
  },
  computed: {
    ...mapState(['user']),
    buttonTitle() {
      const titles = {
        idle: 'Click to play audio',
        loading: 'Loading audio...',
        playing: 'Click to pause',
        paused: 'Click to resume or stop'
      }
      return titles[this.state] || 'Play audio'
    },
    key() {
      return `${this.ownerType}-${this.ownerId}`
    }
  },
  methods: {
    async handleClick() {
      try {
        if (this.state === 'idle') {
          // Transition: idle -> loading -> playing
          await this.loadAndPlay()
        } else if (this.state === 'playing') {
          // Transition: playing -> paused
          this.pauseAudio()
        } else if (this.state === 'paused') {
          // Transition: paused -> stop (reset) and play from start
          audioService.stop()
          await this.loadAndPlay()
        }
      } catch (error) {
        console.error('[AudioButton] Error:', error)
        this.showErrorToast()
        this.state = 'idle'
      }
    },

    async loadAndPlay() {
      try {
        this.isLoading = true
        this.state = 'loading'

        // Load audio (from cache or backend)
        this.audioUrl = await audioService.loadAudio(this.ownerType, this.ownerId)

        // Set source and play
        audioService.setSourceAndPlay(this.audioUrl)
        this.state = 'playing'

        // Poll state for UI sync
        this.startPolling()
      } catch (error) {
        this.isLoading = false
        this.state = 'idle'
        throw error
      } finally {
        this.isLoading = false
      }
    },

    pauseAudio() {
      audioService.pause()
      this.state = 'paused'
      this.stopPolling()
    },

    startPolling() {
      this.stopPolling()
      this.pollInterval = setInterval(() => {
        const serviceState = audioService.getCurrentState()
        if (serviceState === 'idle' && this.state === 'playing') {
          // Audio ended naturally
          this.state = 'idle'
          this.stopPolling()
        }
      }, 500)
    },

    stopPolling() {
      if (this.pollInterval) {
        clearInterval(this.pollInterval)
        this.pollInterval = null
      }
    },

    showErrorToast() {
      // Use existing toast system from the app
      this.$store.commit('SHOW_MESSAGE', {
        type: 'error',
        message: 'Audio unavailable. Please try again.'
      })
    }
  },
  beforeDestroy() {
    this.stopPolling()
    audioService.stop()
  }
}
</script>

<style scoped src="./audioPlayer.css"></style>
