# Integration Guide - OnboardingTour Component

## Overview
The `OnboardingTour` component is an interactive onboarding experience for new users of ElevateHer. It displays once and stores the completion state in localStorage.

## Installation

### 1. Import in Your Main App Component

In your main App component (or layout component), import and register the OnboardingTour:

```vue
<template>
  <div id="app">
    <!-- Your existing app content -->
    <router-view />
    
    <!-- Add OnboardingTour at the root level -->
    <OnboardingTour ref="onboarding" />
  </div>
</template>

<script setup>
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
import { ref } from 'vue'

const onboarding = ref(null)

// Optional: expose reset method for testing/development
const resetOnboarding = () => {
  onboarding.value?.resetOnboarding()
}
</script>
```

### 2. Alternative: Global Registration (Recommended)

In your `main.js`:

```javascript
import { createApp } from 'vue'
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
import App from './App.vue'

const app = createApp(App)

app.component('OnboardingTour', OnboardingTour)
app.mount('#app')
```

Then use it anywhere without importing:

```vue
<template>
  <div>
    <!-- Your content -->
    <OnboardingTour />
  </div>
</template>
```

## Features

✅ **Composition API** - Modern Vue 3 setup
✅ **5 Guided Steps**:
   - Daily Power Check (Home)
   - Learning Courses (Track)
   - Real-Life Simulations (Simulator)
   - Share Your Story (Stories)
   - Track Your Progress (Profile)

✅ **localStorage Persistence** - Shows only once unless reset
✅ **Smooth Transitions** - Professional animations
✅ **Mobile Responsive** - Fully optimized for all screen sizes
✅ **Pagination Dots** - Visual step indicators
✅ **Navigation Controls** - Back/Next/Get Started buttons
✅ **Skip Option** - Users can skip the tour

## Styling

The component uses a modern design system with:
- Primary color: `#475569` (slate)
- Secondary color: `#94a3b8` (slate light)
- Clean white container with rounded corners
- Subtle blur backdrop effect
- Professional typography

## Customization

### Change Colors

Edit the CSS variables in `OnboardingTour.vue`:

```css
:root {
  --primary-color: #475569;  /* Change primary color */
  --secondary-color: #94a3b8; /* Change secondary color */
}
```

### Modify Step Content

Edit the `steps` array in the `<script setup>`:

```javascript
const steps = ref([
  {
    id: 'home',
    title: 'Your Custom Title',
    description: 'Your custom description',
    highlights: [
      'Highlight 1',
      'Highlight 2',
      'Highlight 3'
    ]
  },
  // ... more steps
])
```

### Add Custom Icons

Replace the SVG icons in the `<script setup>` section. Add your own components:

```javascript
const CustomIcon = {
  template: `<svg><!-- your SVG --></svg>`
}
```

## Testing

### Reset Onboarding for Testing

```javascript
// In your component
const onboarding = ref(null)

const testOnboarding = () => {
  onboarding.value?.resetOnboarding()
}
```

Or manually clear localStorage:

```javascript
localStorage.removeItem('elevateher_onboarding_completed')
```

## Browser Support

- Modern browsers with CSS Grid, Flexbox, and backdrop-filter support
- Mobile browsers (iOS Safari, Chrome Mobile)
- Falls back gracefully if backdrop-filter not supported

## localStorage Key

- **Key**: `elevateher_onboarding_completed`
- **Value**: `'true'` when completed
- This prevents the onboarding from showing more than once

## Accessibility

- Proper semantic HTML
- ARIA labels on pagination dots
- Keyboard navigable buttons
- Clear visual hierarchy

## Performance

- Lightweight component (~5KB gzipped)
- No external dependencies beyond Vue 3
- Efficient re-renders using Composition API
- Optimized CSS animations

## Troubleshooting

**Onboarding not showing?**
- Check if localStorage has `elevateher_onboarding_completed` set to `true`
- Clear it with: `localStorage.removeItem('elevateher_onboarding_completed')`
- Check browser console for errors

**Styles not applying?**
- Ensure CSS scoping is working in your Vue setup
- Verify z-index isn't conflicting with other elements (currently 9999)

**Animations not smooth?**
- Check browser support for `backdrop-filter`
- Verify CSS transitions are not disabled globally
