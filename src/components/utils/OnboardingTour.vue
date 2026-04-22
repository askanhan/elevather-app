<template>
  <transition name="fade">
    <div v-if="isVisible" class="onboarding-overlay">
      <!-- Blurred background -->
      <div class="onboarding-blur-bg"></div>

      <!-- Tour content -->
      <div class="onboarding-container">
        <!-- Step content with fade transition -->
        <transition name="slide-fade" mode="out-in">
          <div :key="currentStep" class="onboarding-content">
            <!-- Step icon/visual -->
            <div class="onboarding-icon">
              <component :is="getCurrentIcon()" />
            </div>

            <!-- Step title -->
            <h2 class="onboarding-title">{{ currentStepData.title }}</h2>

            <!-- Step description -->
            <p class="onboarding-description">{{ currentStepData.description }}</p>

            <!-- Highlight features (if any) -->
            <ul v-if="currentStepData.highlights" class="onboarding-highlights">
              <li v-for="highlight in currentStepData.highlights" :key="highlight">
                <span class="highlight-dot"></span>
                {{ highlight }}
              </li>
            </ul>
          </div>
        </transition>

        <!-- Pagination dots -->
        <div class="onboarding-pagination">
          <button
            v-for="(step, index) in steps"
            :key="index"
            :class="['pagination-dot', { active: index === currentStep }]"
            @click="goToStep(index)"
            :aria-label="`Go to step ${index + 1}`"
          ></button>
        </div>

        <!-- Navigation buttons -->
        <div class="onboarding-actions">
          <button
            v-if="currentStep > 0"
            class="btn-secondary"
            @click="previousStep"
          >
            Back
          </button>

          <button
            v-if="currentStep < steps.length - 1"
            class="btn-primary"
            @click="nextStep"
          >
            Next
          </button>

          <button
            v-else
            class="btn-primary btn-get-started"
            @click="completeOnboarding"
          >
            Get Started
          </button>
        </div>

        <!-- Skip option (subtle) -->
        <button class="btn-skip" @click="completeOnboarding">
          Skip for now
        </button>
      </div>
    </div>
  </transition>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

// Icons components - simple SVG elements
const HomeIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>`
}

const BookIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>`
}

const GamepadIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="6" cy="12" r="1"></circle><circle cx="10" cy="8" r="1"></circle><circle cx="10" cy="16" r="1"></circle><path d="M12 13h8a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2h-8"></path><path d="M4 13a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h2"></path></svg>`
}

const MessageCircleIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>`
}

const TrendingUpIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 17"></polyline><polyline points="17 6 23 6 23 12"></polyline></svg>`
}

// State
const isVisible = ref(false)
const currentStep = ref(0)

// Onboarding steps with engaging copy
const steps = ref([
  {
    id: 'home',
    title: 'Daily Power Check',
    description: 'Every day, take a moment to answer 3 powerful questions. They help you track where you are right now and set the tone for your day.',
    highlights: [
      'Measure your current state',
      'Build self-awareness',
      'Start your journey with intention'
    ]
  },
  {
    id: 'track',
    title: 'Learning Courses',
    description: 'Explore courses organized by categories and designed just for you. Each course is unlocked day by day, keeping your learning journey smooth and manageable.',
    highlights: [
      'Organized by categories',
      'Daily progression system',
      'Courses unlock at your pace',
      'Use filters to find what you need'
    ]
  },
  {
    id: 'simulator',
    title: 'Real-Life Simulations',
    description: 'Put your skills to the test with engaging mini-games. Each simulation gives you personalized feedback to help you grow and learn from experience.',
    highlights: [
      'Interactive learning scenarios',
      'Get instant personalized feedback',
      'Apply what you\'ve learned'
    ]
  },
  {
    id: 'stories',
    title: 'Share Your Story',
    description: 'Connect with a community of empowered women. Read inspiring stories from others and share your own journey. Share one story per day and watch your impact grow.',
    highlights: [
      'Read inspiring stories',
      'Share your progress',
      'Track stories awaiting validation',
      'Build meaningful connections'
    ]
  },
  {
    id: 'profile',
    title: 'Track Your Progress',
    description: 'Visualize your growth across all categories. See how far you\'ve come, track your simulation scores, and celebrate your achievements.',
    highlights: [
      'View progress by category',
      'Monitor simulation results',
      'Celebrate your milestones'
    ]
  }
])

// Computed property for current step data
const currentStepData = computed(() => steps.value[currentStep.value])

// Methods
const getCurrentIcon = () => {
  const iconMap = {
    home: HomeIcon,
    track: BookIcon,
    simulator: GamepadIcon,
    stories: MessageCircleIcon,
    profile: TrendingUpIcon
  }
  return iconMap[currentStepData.value.id] || HomeIcon
}

const nextStep = () => {
  if (currentStep.value < steps.value.length - 1) {
    currentStep.value++
  }
}

const previousStep = () => {
  if (currentStep.value > 0) {
    currentStep.value--
  }
}

const goToStep = (index) => {
  currentStep.value = index
}

const completeOnboarding = () => {
  // Mark onboarding as completed in localStorage
  localStorage.setItem('elevateher_onboarding_completed', 'true')
  isVisible.value = false
}

const checkAndShowOnboarding = () => {
  // Only show if not previously completed
  const hasCompletedOnboarding = localStorage.getItem('elevateher_onboarding_completed')
  if (!hasCompletedOnboarding) {
    isVisible.value = true
  }
}

// Lifecycle
onMounted(() => {
  checkAndShowOnboarding()
})

// Expose method to reset onboarding (for dev/testing)
const resetOnboarding = () => {
  localStorage.removeItem('elevateher_onboarding_completed')
  currentStep.value = 0
  isVisible.value = true
}

defineExpose({
  resetOnboarding,
  isVisible
})
</script>

<style scoped>
/* Overlay and backdrop */
.onboarding-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
  padding: 20px;
}

.onboarding-blur-bg {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(15, 23, 42, 0.6);
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

/* Main container */
.onboarding-container {
  position: relative;
  z-index: 10000;
  width: 100%;
  max-width: 420px;
  background: white;
  border-radius: 20px;
  padding: 40px 28px 32px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  gap: 32px;
}

/* Content section */
.onboarding-content {
  display: flex;
  flex-direction: column;
  gap: 20px;
  text-align: center;
}

/* Icon styling */
.onboarding-icon {
  display: flex;
  justify-content: center;
  margin-bottom: 8px;
}

.onboarding-icon svg {
  width: 64px;
  height: 64px;
  color: #475569;
  stroke-width: 1.5;
}

/* Typography */
.onboarding-title {
  font-size: 24px;
  font-weight: 600;
  color: #1e293b;
  margin: 0;
  line-height: 1.3;
}

.onboarding-description {
  font-size: 15px;
  color: #64748b;
  line-height: 1.6;
  margin: 0;
  font-weight: 400;
}

/* Highlights list */
.onboarding-highlights {
  list-style: none;
  padding: 16px;
  margin: 8px 0 0 0;
  background: #f8fafc;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.onboarding-highlights li {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  font-size: 14px;
  color: #475569;
  line-height: 1.5;
}

.highlight-dot {
  display: inline-block;
  width: 6px;
  height: 6px;
  background: #94a3b8;
  border-radius: 50%;
  flex-shrink: 0;
  margin-top: 6px;
}

/* Pagination dots */
.onboarding-pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
}

.pagination-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  border: none;
  background: #cbd5e1;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0;
}

.pagination-dot:hover {
  background: #94a3b8;
}

.pagination-dot.active {
  background: #475569;
  width: 24px;
  border-radius: 4px;
}

/* Action buttons */
.onboarding-actions {
  display: flex;
  gap: 12px;
  justify-content: space-between;
}

.btn-primary,
.btn-secondary {
  flex: 1;
  padding: 12px 20px;
  border: none;
  border-radius: 10px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  text-transform: capitalize;
}

.btn-primary {
  background: #475569;
  color: white;
}

.btn-primary:hover {
  background: #334155;
  transform: translateY(-2px);
  box-shadow: 0 8px 16px rgba(71, 85, 105, 0.3);
}

.btn-primary:active {
  transform: translateY(0);
}

.btn-secondary {
  background: #f1f5f9;
  color: #475569;
  border: 1px solid #e2e8f0;
}

.btn-secondary:hover {
  background: #e2e8f0;
}

.btn-get-started {
  flex: 1;
}

/* Skip button */
.btn-skip {
  background: none;
  border: none;
  color: #94a3b8;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  padding: 8px 0;
  transition: color 0.3s ease;
  text-transform: capitalize;
}

.btn-skip:hover {
  color: #64748b;
}

/* Animations */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.4s ease;
}

.slide-fade-enter-from {
  transform: translateX(20px);
  opacity: 0;
}

.slide-fade-leave-to {
  transform: translateX(-20px);
  opacity: 0;
}

/* Responsive design */
@media (max-width: 480px) {
  .onboarding-container {
    max-width: 100%;
    padding: 32px 20px 28px;
    gap: 24px;
  }

  .onboarding-title {
    font-size: 20px;
  }

  .onboarding-description {
    font-size: 14px;
  }

  .onboarding-highlights {
    padding: 12px;
    gap: 8px;
  }

  .onboarding-highlights li {
    font-size: 13px;
  }

  .btn-primary,
  .btn-secondary {
    padding: 11px 16px;
    font-size: 14px;
  }

  .onboarding-icon svg {
    width: 56px;
    height: 56px;
  }
}

@media (max-width: 360px) {
  .onboarding-container {
    padding: 24px 16px 20px;
    gap: 20px;
  }

  .onboarding-title {
    font-size: 18px;
  }

  .onboarding-description {
    font-size: 13px;
  }

  .onboarding-actions {
    flex-direction: column;
    gap: 10px;
  }

  .btn-primary,
  .btn-secondary {
    width: 100%;
  }
}
</style>
