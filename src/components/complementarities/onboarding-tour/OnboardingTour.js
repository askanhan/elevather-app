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

export default {
  setup() {
    // State - créé DANS setup()
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
      localStorage.setItem('elevateher_onboarding_completed', 'true')
      isVisible.value = false
    }

    const checkAndShowOnboarding = () => {
      const hasCompletedOnboarding = localStorage.getItem('elevateher_onboarding_completed')
      if (!hasCompletedOnboarding) {
        isVisible.value = true
      }
    }

    const resetOnboarding = () => {
      localStorage.removeItem('elevateher_onboarding_completed')
      currentStep.value = 0
      isVisible.value = true
    }

    // Lifecycle
    onMounted(() => {
      checkAndShowOnboarding()
    })

    // Return everything pour le template
    return {
      isVisible,
      currentStep,
      steps,
      currentStepData,
      getCurrentIcon,
      nextStep,
      previousStep,
      goToStep,
      completeOnboarding,
      resetOnboarding
    }
  }
}
