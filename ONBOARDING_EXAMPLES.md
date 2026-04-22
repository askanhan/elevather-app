# Example: How to Integrate OnboardingTour in App.vue

## Simple Integration Example

```vue
<template>
  <div id="app" class="app-container">
    <!-- OnboardingTour Component - Add this line -->
    <OnboardingTour ref="onboarding" />
    
    <!-- Your existing app structure -->
    <header v-if="showHeader">
      <!-- Your header content -->
    </header>
    
    <main>
      <router-view />
    </main>
    
    <footer v-if="showFooter">
      <!-- Your footer content -->
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import OnboardingTour from '@/components/utils/OnboardingTour.vue'

const onboarding = ref(null)
const showHeader = ref(true)
const showFooter = ref(true)

// Optional: Method to reset onboarding (for testing)
const testResetOnboarding = () => {
  if (onboarding.value) {
    onboarding.value.resetOnboarding()
  }
}

// Optional: Check if user is new (for other features)
const isNewUser = () => {
  return !localStorage.getItem('elevateher_onboarding_completed')
}
</script>

<style scoped>
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.app-container {
  flex: 1;
}
</style>
```

## Advanced Integration with Dev Mode

If you want to provide a button to reset the onboarding (useful during development):

```vue
<template>
  <div id="app">
    <OnboardingTour ref="onboarding" />
    
    <!-- Dev toolbar (only in development) -->
    <div v-if="isDevelopment" class="dev-toolbar">
      <button @click="resetOnboarding" class="dev-btn">
        Reset Onboarding
      </button>
    </div>
    
    <router-view />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import OnboardingTour from '@/components/utils/OnboardingTour.vue'

const onboarding = ref(null)
const isDevelopment = process.env.NODE_ENV === 'development'

const resetOnboarding = () => {
  onboarding.value?.resetOnboarding()
}
</script>

<style scoped>
.dev-toolbar {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 8999;
  background: #1e293b;
  padding: 12px 16px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.dev-btn {
  background: #ef4444;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 12px;
  cursor: pointer;
  font-weight: 600;
}

.dev-btn:hover {
  background: #dc2626;
}
</style>
```

## Global Registration in main.js

If you prefer to register OnboardingTour globally:

```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
import './main.css'

const app = createApp(App)

// Register OnboardingTour globally
app.component('OnboardingTour', OnboardingTour)

app.use(router)
app.mount('#app')
```

Then in any component:

```vue
<template>
  <div>
    <!-- Use without importing -->
    <OnboardingTour />
    
    <!-- Your content -->
    <router-view />
  </div>
</template>
```

## Using in Specific Routes

If you want the onboarding to appear only on specific routes:

```vue
<template>
  <div id="app">
    <!-- Show onboarding only on home route -->
    <OnboardingTour v-if="$route.name === 'home'" />
    
    <router-view />
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'
import OnboardingTour from '@/components/utils/OnboardingTour.vue'

const route = useRoute()
</script>
```

## Listening to Onboarding Events

You can extend the component to emit events:

```javascript
// In OnboardingTour.vue, add:
const emit = defineEmits(['completed', 'skipped'])

const completeOnboarding = () => {
  localStorage.setItem('elevateher_onboarding_completed', 'true')
  emit('completed')
  isVisible.value = false
}
```

Then in App.vue:

```vue
<template>
  <OnboardingTour 
    @completed="handleOnboardingCompleted"
    @skipped="handleOnboardingSkipped"
  />
</template>

<script setup>
const handleOnboardingCompleted = () => {
  console.log('User completed onboarding')
  // Trigger analytics, adjust UI, etc.
}

const handleOnboardingSkipped = () => {
  console.log('User skipped onboarding')
}
</script>
```

---

**Choose the integration method that best fits your application structure!**
