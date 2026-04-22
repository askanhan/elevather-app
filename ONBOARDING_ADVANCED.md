# OnboardingTour - Advanced Customization Guide

## 🎨 Extending the Component

### Add Event Emissions

```vue
<!-- Modify OnboardingTour.vue -->
<script setup>
const emit = defineEmits(['completed', 'skipped', 'step-changed'])

const nextStep = () => {
  if (currentStep.value < steps.value.length - 1) {
    currentStep.value++
    emit('step-changed', currentStep.value)
  }
}

const completeOnboarding = () => {
  localStorage.setItem('elevateher_onboarding_completed', 'true')
  emit('completed')
  isVisible.value = false
}
</script>
```

### Use in Parent Component

```vue
<template>
  <div>
    <OnboardingTour 
      ref="onboarding"
      @completed="handleCompleted"
      @skipped="handleSkipped"
      @step-changed="handleStepChanged"
    />
  </div>
</template>

<script setup>
const handleCompleted = () => {
  console.log('Onboarding completed!')
  // Trigger analytics
  // Update user profile
  // Navigate to next section
}

const handleSkipped = () => {
  console.log('User skipped onboarding')
}

const handleStepChanged = (stepIndex) => {
  console.log('User on step:', stepIndex)
}
</script>
```

---

## 🔐 Adding Step Locking/Prerequisites

```javascript
// Modify steps to include prerequisites
const steps = ref([
  {
    id: 'home',
    title: 'Daily Power Check',
    description: '...',
    highlights: [...],
    requiredFeatureFlag: 'show_home_tour'  // New field
  },
  // ... more steps
])

// Filter visible steps
const visibleSteps = computed(() => 
  steps.value.filter(step => 
    !step.requiredFeatureFlag || 
    isFeatureEnabled(step.requiredFeatureFlag)
  )
)
```

---

## 🌍 Internationalization (i18n)

### Setup with Vue i18n

```javascript
// In your i18n messages
const messages = {
  en: {
    onboarding: {
      home: {
        title: 'Daily Power Check',
        description: 'Every day, take a moment...',
        highlights: [...]
      },
      track: { ... },
      // ... more steps
    }
  },
  fr: {
    onboarding: {
      home: {
        title: 'Bilan Quotidien',
        description: 'Chaque jour, prenez un moment...',
        highlights: [...]
      }
      // ... translated steps
    }
  }
}
```

### Modify Component for i18n

```vue
<script setup>
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

const steps = computed(() => [
  {
    id: 'home',
    title: t('onboarding.home.title'),
    description: t('onboarding.home.description'),
    highlights: t('onboarding.home.highlights')
  },
  // ... use i18n for all steps
])
</script>
```

---

## 📊 Analytics Integration

```javascript
// Add analytics tracking
const trackEvent = (eventName, data) => {
  // Firebase, Mixpanel, Google Analytics, etc.
  if (window.gtag) {
    window.gtag('event', eventName, data)
  }
}

const nextStep = () => {
  if (currentStep.value < steps.value.length - 1) {
    currentStep.value++
    trackEvent('onboarding_next_step', {
      from_step: currentStep.value - 1,
      to_step: currentStep.value
    })
  }
}

const completeOnboarding = () => {
  trackEvent('onboarding_completed', {
    total_steps: steps.value.length,
    timestamp: Date.now()
  })
  localStorage.setItem('elevateher_onboarding_completed', 'true')
  isVisible.value = false
}
```

---

## 🎭 Animation Variants

### Add Slide-In Animation Option

```vue
<script setup>
const animationType = ref('slide-fade') // or 'fade' or 'scale'

const getAnimationClass = () => {
  return `animation-${animationType.value}`
}
</script>

<template>
  <transition :name="animationType">
    <div :key="currentStep" class="onboarding-content">
      <!-- content -->
    </div>
  </transition>
</template>

<style scoped>
/* Scale animation */
.scale-enter-active,
.scale-leave-active {
  transition: all 0.4s ease;
}

.scale-enter-from {
  transform: scale(0.95);
  opacity: 0;
}

.scale-leave-to {
  transform: scale(1.05);
  opacity: 0;
}
</style>
```

---

## 🎯 Conditional Steps

```javascript
// Show different steps based on user data
const steps = computed(() => {
  const baseSteps = [
    { id: 'home', title: 'Daily Power Check', ... },
    { id: 'track', title: 'Learning Courses', ... }
  ]
  
  // Add premium feature tour only if user is premium
  if (user.value?.isPremium) {
    baseSteps.push({
      id: 'premium-feature',
      title: 'Premium Features',
      description: 'Unlock advanced analytics...'
    })
  }
  
  return baseSteps
})
```

---

## 🔊 Sound Effects (Optional)

```javascript
const playSound = (soundType) => {
  const sounds = {
    'next': new Audio('/sounds/next.mp3'),
    'complete': new Audio('/sounds/complete.mp3')
  }
  
  if (sounds[soundType]) {
    sounds[soundType].play()
  }
}

const nextStep = () => {
  playSound('next')
  if (currentStep.value < steps.value.length - 1) {
    currentStep.value++
  }
}

const completeOnboarding = () => {
  playSound('complete')
  // ... rest of logic
}
```

---

## 🌙 Dark Mode Support

```vue
<style scoped>
/* Light mode (default) */
.onboarding-overlay {
  /* existing styles */
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  .onboarding-container {
    background: #1e293b;
    color: #f1f5f9;
  }
  
  .onboarding-title {
    color: #f1f5f9;
  }
  
  .onboarding-description {
    color: #cbd5e1;
  }
  
  .onboarding-highlights {
    background: #0f172a;
    border: 1px solid #334155;
  }
  
  .btn-primary {
    background: #64748b;
  }
  
  .btn-secondary {
    background: #334155;
    color: #f1f5f9;
  }
}
</style>
```

---

## 🔗 Deep Linking to Specific Step

```javascript
// Navigate directly to a step via URL
const router = useRouter()

router.beforeEach((to, from, next) => {
  if (to.query.onboarding_step) {
    const stepIndex = parseInt(to.query.onboarding_step)
    // Show onboarding with specific step
    localStorage.removeItem('elevateher_onboarding_completed')
    currentStep.value = stepIndex
    isVisible.value = true
  }
  next()
})
```

Usage: `yourapp.com/?onboarding_step=2`

---

## 📝 Form Integration

```javascript
// Collect user preferences during onboarding
const userResponses = ref({
  interests: [],
  goals: [],
  experience: null
})

// Add to steps
const steps = ref([
  {
    id: 'home',
    title: 'Daily Power Check',
    description: '...',
    type: 'info' // standard info step
  },
  {
    id: 'preferences',
    title: 'Your Preferences',
    type: 'form', // form step
    fields: [
      { name: 'interests', type: 'checkbox', options: [...] },
      { name: 'goals', type: 'textarea' }
    ]
  }
  // ... more steps
])
```

---

## 🎬 Progress Video Integration

```javascript
// Add video tutorial to steps
const steps = ref([
  {
    id: 'home',
    title: 'Daily Power Check',
    description: '...',
    videoUrl: 'https://example.com/video.mp4',
    videoDuration: 45 // seconds
  }
])
```

```vue
<template>
  <video 
    v-if="currentStepData.videoUrl"
    :src="currentStepData.videoUrl"
    controls
    class="onboarding-video"
  ></video>
</template>

<style scoped>
.onboarding-video {
  width: 100%;
  max-width: 100%;
  border-radius: 12px;
  margin-bottom: 16px;
}
</style>
```

---

## 🔄 Version Control

```javascript
// Track onboarding version
const ONBOARDING_VERSION = '1.0'

const completeOnboarding = () => {
  localStorage.setItem('elevateher_onboarding_completed', 'true')
  localStorage.setItem('elevateher_onboarding_version', ONBOARDING_VERSION)
  localStorage.setItem('elevateher_onboarding_completed_at', new Date().toISOString())
  isVisible.value = false
}

// Show updated onboarding if version changed
const shouldShowUpdatedOnboarding = () => {
  const completedVersion = localStorage.getItem('elevateher_onboarding_version')
  return completedVersion !== ONBOARDING_VERSION
}
```

---

## 🧪 Testing Utilities

```javascript
// Cypress test example
describe('OnboardingTour', () => {
  beforeEach(() => {
    cy.visit('/')
    cy.window().then(win => {
      win.localStorage.removeItem('elevateher_onboarding_completed')
    })
  })

  it('should show onboarding on first visit', () => {
    cy.get('.onboarding-overlay').should('be.visible')
  })

  it('should navigate through steps', () => {
    cy.get('[class*="btn-primary"]').click()
    cy.get('.onboarding-title').should('contain', 'Learning Courses')
  })

  it('should complete onboarding', () => {
    for (let i = 0; i < 4; i++) {
      cy.get('[class*="btn-primary"]').click()
    }
    cy.get('[class*="btn-get-started"]').click()
    cy.get('.onboarding-overlay').should('not.exist')
  })
})
```

---

## 📦 Component Props (If Needed)

```javascript
// Modify component to accept props
const props = defineProps({
  autoStart: {
    type: Boolean,
    default: true
  },
  skipButton: {
    type: Boolean,
    default: true
  },
  animationSpeed: {
    type: String,
    enum: ['slow', 'normal', 'fast'],
    default: 'normal'
  },
  backgroundColor: {
    type: String,
    default: '#475569'
  },
  steps: {
    type: Array,
    default: () => []
  }
})
```

---

**These customizations can be implemented without modifying the core component logic!** Pick and choose what fits your needs. 🚀
