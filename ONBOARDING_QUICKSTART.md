# OnboardingTour - Quick Start Cheatsheet

## ⚡ Quick Integration (30 seconds)

### Option 1: Global Component (Recommended)
```javascript
// main.js
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
app.component('OnboardingTour', OnboardingTour)
```

```vue
<!-- App.vue -->
<template>
  <div>
    <OnboardingTour />
    <router-view />
  </div>
</template>
```

### Option 2: Local Import
```vue
<!-- App.vue -->
<template>
  <div>
    <OnboardingTour ref="onboarding" />
    <router-view />
  </div>
</template>

<script setup>
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
</script>
```

---

## 🧪 Testing

### View the Onboarding
```javascript
// In browser console or component method
localStorage.removeItem('elevateher_onboarding_completed')
location.reload()
```

### Reset via Component
```javascript
// Component ref
onboarding.value?.resetOnboarding()
```

---

## 🎨 The 5 Steps at a Glance

| Step | Title | Focus |
|------|-------|-------|
| 1 | Daily Power Check | 3 daily reflection questions |
| 2 | Learning Courses | Category-based progressive learning |
| 3 | Real-Life Simulations | Interactive scenarios + feedback |
| 4 | Share Your Story | Social sharing (1/day) + validation |
| 5 | Track Your Progress | Category progress + scores |

---

## 🎯 Features Checklist

- ✅ Vue 3 Composition API
- ✅ localStorage persistence
- ✅ 5 engaging steps
- ✅ Smooth animations (fade + slide)
- ✅ Mobile responsive
- ✅ Pagination dots
- ✅ Back/Next/Get Started buttons
- ✅ Skip option
- ✅ Professional design (#475569, #94a3b8)
- ✅ Blur backdrop overlay
- ✅ 5 SVG icons
- ✅ Accessible (ARIA labels, semantic HTML)

---

## 🎨 Color Palette

```css
Primary:      #475569  (Slate 700)
Secondary:    #94a3b8  (Slate 400)
Overlay:      #1e293b  (Slate 900)
Background:   #ffffff  (White)
Subtle:       #f8fafc  (Slate 50)
Text Dark:    #1e293b  (Slate 900)
Text Light:   #64748b  (Slate 500)
```

---

## 📱 Responsive Breakpoints

```javascript
Desktop (> 480px):    420px max-width, 40px padding
Tablet (≤ 480px):     100% width, 32px padding  
Mobile (≤ 360px):     100% width, 24px padding, stacked buttons
```

---

## 💾 localStorage Reference

**Key**: `elevateher_onboarding_completed`
**Value**: `'true'`
**Check**: `localStorage.getItem('elevateher_onboarding_completed')`
**Clear**: `localStorage.removeItem('elevateher_onboarding_completed')`

---

## 🚀 Performance

- Component size: ~5KB gzipped
- No external dependencies
- CSS animations (GPU accelerated)
- Efficient Vue 3 reactivity
- Inline SVG icons

---

## 📂 File Location

```
src/components/utils/OnboardingTour.vue
```

---

## 🔧 Customization Quick Links

### Change a Step
Edit the `steps` array in `OnboardingTour.vue`:
```javascript
const steps = ref([
  {
    id: 'home',
    title: 'Your Title',
    description: 'Your description',
    highlights: ['Point 1', 'Point 2']
  }
  // ...
])
```

### Change Colors
Update CSS variables in component styles

### Change Text Strings
Edit step titles and descriptions in `steps` array

### Disable Skip Button
Remove `<button class="btn-skip">` from template

---

## ❓ Troubleshooting

| Issue | Solution |
|-------|----------|
| Not showing? | Check: `localStorage.removeItem('elevateher_onboarding_completed')` |
| Styles not applied? | Verify scoped styles are working, check z-index conflicts |
| Animations not smooth? | Check browser supports backdrop-filter, verify CSS enabled |
| Not imported? | Add to main.js or App.vue import |

---

## 📚 Documentation Files

- **This file**: Quick reference
- `ONBOARDING_DOCUMENTATION.md`: Full feature breakdown
- `ONBOARDING_INTEGRATION_GUIDE.md`: Integration methods
- `ONBOARDING_EXAMPLES.md`: Code examples
- `src/components/utils/OnboardingTour.vue`: Component source

---

## 🎓 Key Exports/Methods

```javascript
// Component exposes these methods:
resetOnboarding()     // Reset tour (for testing)
isVisible             // Visibility state (ref)
```

---

## ✨ What Users Will See

1. **Page loads** → Overlay appears with blur background
2. **Step 1** → Daily Power Check (home icon)
3. **User clicks Next** → Smooth slide to Step 2
4. **Pagination dots** → Show progress, clickable for jumping
5. **Step 5** → Get Started button appears
6. **User clicks Get Started** → Tour closes, stored in localStorage

---

## 📞 Support

For issues or customizations:
1. Check `ONBOARDING_DOCUMENTATION.md` for detailed specs
2. Review component source comments
3. Test with localStorage cleared
4. Verify Vue 3 Composition API compatibility

---

**Ready to go!** 🚀 Just import and use!
