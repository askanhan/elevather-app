<template>
  <!-- Invisible audio player wrapper -->
  <!-- Audio element is managed by audioService singleton -->
  <div class="audio-player-wrapper" style="display: none;"></div>
</template>

<script>
import audioService from './audioService.js'

export default {
  name: 'AudioPlayer',
  mounted() {
    // Ensure audio service is initialized
    audioService.getAudioElement()
  },
  beforeDestroy() {
    // Cleanup when component is destroyed
    audioService.cleanup()
  }
}
</script>

<style scoped>
/* No visible styles - this is a hidden wrapper */
</style>
