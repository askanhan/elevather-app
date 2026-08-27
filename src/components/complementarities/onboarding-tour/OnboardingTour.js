import { ref, computed, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useI18n } from 'vue-i18n'

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
    const route = useRoute()
    const { t } = useI18n()

    // State - créé DANS setup()
    const isVisible = ref(false)
    const currentStep = ref(0)

    // Onboarding steps - copy (title/description/highlights) lives in the
    // i18n messages under components.onboardingTour.steps.<id>
    const steps = ref([
      { id: 'home', highlightsCount: 3 },
      { id: 'track', highlightsCount: 4 },
      { id: 'simulator', highlightsCount: 3 },
      { id: 'stories', highlightsCount: 4 },
      { id: 'profile', highlightsCount: 3 }
    ])

    // Computed property for current step data
    const currentStepData = computed(() => {
      const step = steps.value[currentStep.value]
      const base = `components.onboardingTour.steps.${step.id}`
      return {
        id: step.id,
        title: t(`${base}.title`),
        description: t(`${base}.description`),
        highlights: Array.from({ length: step.highlightsCount }, (_, i) => t(`${base}.highlights.${i}`))
      }
    })

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

    // Lifecycle - only offer the tour once the user actually lands on the
    // home page (i.e. after login), not on app boot while still on
    // splash/login screens.
    watch(
      () => route.name,
      (name) => {
        if (name === 'home') {
          checkAndShowOnboarding()
        }
      },
      { immediate: true }
    )

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
