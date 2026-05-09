<template>
  <div class="audio-button-wrapper">
    <button class="audio-button" :class="[`state-${state}`, { loading: isLoading }]" @click="handleClick"
      :aria-label="`Play audio for ${ownerType} ${ownerId}`" :title="buttonTitle" :disabled="isLoading">
      <!-- Replaced the hardcoded emoji with a dynamic computed property -->
      <span class="audio-icon">{{ currentIcon }}</span>
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
        paused: 'Click to resume'
      }
      return titles[this.state] || 'Play audio'
    },
    key() {
      return `${this.ownerType}-${this.ownerId}`
    }, currentIcon() {
      const icons = {
        idle: '🔊',      // Or standard '🔊'
        loading: '⏳',    // Shows while fetching from backend
        playing: '🔊⏸️',    // Pause icon when it's actively playing
        paused: '🔊▶️'      // Play icon when it's ready to resume
      }
      return icons[this.state] || '🔊'
    }
  },
  methods: {
    async handleClick() {
      try {
        if (this.state === 'idle') {
          await this.loadAndPlay()
        } else if (this.state === 'playing') {
          this.pauseAudio()
        } else if (this.state === 'paused') {
          // MODIFIED: Just resume playing, don't stop and reload!
          this.resumeAudio()
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

        this.audioUrl = await audioService.loadAudio(this.ownerType, this.ownerId)

        audioService.setSourceAndPlay(this.audioUrl)
        this.state = 'playing'

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

    // ADDED: New method just for resuming
    resumeAudio() {
      audioService.play()
      this.state = 'playing'
      this.startPolling()
    },

    startPolling() {
      this.stopPolling()
      this.pollInterval = setInterval(() => {
        const serviceState = audioService.getCurrentState()
        const activeKey = audioService.getCurrentKey() // Check who is currently using the service

        // MODIFIED: If service is idle OR another button hijacked the audio, reset this button
        if (serviceState === 'idle' || activeKey !== this.key) {
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
      this.$store.commit('SHOW_MESSAGE', {
        type: 'error',
        message: 'Audio unavailable. Please try again.'
      })
    }
  },
  beforeDestroy() {
    this.stopPolling()
    // Optional: Only stop the global audio if THIS specific button was the one playing it
    if (audioService.getCurrentKey() === this.key) {
      audioService.stop()
    }
  }
}
</script>