# OnboardingTour Component - Feature Breakdown

## 📋 Overview

**File**: `src/components/utils/OnboardingTour.vue`
**Type**: Vue 3 Composition API Component
**Purpose**: Interactive onboarding tour for first-time users
**Storage**: localStorage persistence

## 🎯 The 5 Onboarding Steps

### 1️⃣ Daily Power Check (Home)
- **Icon**: Home icon
- **Title**: "Daily Power Check"
- **Message**: Introduces the 3 daily questions that help users measure their current state
- **Highlights**:
  - Measure your current state
  - Build self-awareness
  - Start your journey with intention

### 2️⃣ Learning Courses (Track)
- **Icon**: Book icon
- **Title**: "Learning Courses"
- **Message**: Explains how courses are organized by categories and progressively unlocked
- **Highlights**:
  - Organized by categories
  - Daily progression system
  - Courses unlock at your pace
  - Use filters to find what you need

### 3️⃣ Real-Life Simulations (Simulator)
- **Icon**: Gamepad icon
- **Title**: "Real-Life Simulations"
- **Message**: Describes mini-games with personalized feedback
- **Highlights**:
  - Interactive learning scenarios
  - Get instant personalized feedback
  - Apply what you've learned

### 4️⃣ Share Your Story (Stories)
- **Icon**: Message Circle icon
- **Title**: "Share Your Story"
- **Message**: Social sharing, 1 story per day limit, pending validation tab
- **Highlights**:
  - Read inspiring stories
  - Share your progress
  - Track stories awaiting validation
  - Build meaningful connections

### 5️⃣ Track Your Progress (Profile)
- **Icon**: Trending Up icon
- **Title**: "Track Your Progress"
- **Message**: Progress visualization by categories and simulator scores
- **Highlights**:
  - View progress by category
  - Monitor simulation results
  - Celebrate your milestones

## 🎨 Design System

### Colors
- **Primary**: `#475569` (Slate 700) - Main actions & icons
- **Secondary**: `#94a3b8` (Slate 400) - Secondary elements
- **Background**: `#1e293b` (Slate 900, 60% opacity) - Overlay
- **Surface**: `#ffffff` (White) - Container
- **Subtle**: `#f8fafc` (Slate 50) - Highlights background

### Typography
- **Title**: 24px / 600 weight / Line height 1.3
- **Description**: 15px / 400 weight / Line height 1.6
- **Highlights**: 14px / 400 weight / Line height 1.5

### Spacing
- Container padding: 40px 28px (32px bottom for mobile)
- Gap between sections: 32px
- Border radius: 20px (container), 12px (highlights), 10px (buttons)

### Effects
- **Backdrop**: 4px blur with 60% overlay
- **Shadow**: 0 20px 60px rgba(0,0,0,0.3)
- **Transitions**: 0.3s - 0.4s ease

## 🔧 Technical Features

### State Management
```javascript
- currentStep: ref(0)           // Current step index
- isVisible: ref(false)         // Visibility toggle
- steps: ref([...])             // Step data array
```

### Key Methods
- `nextStep()` - Move to next step
- `previousStep()` - Move to previous step
- `goToStep(index)` - Jump to specific step
- `completeOnboarding()` - Mark as complete & hide
- `resetOnboarding()` - Reset for testing/reset

### Lifecycle
- Component checks localStorage on mount
- If `elevateher_onboarding_completed` exists, onboarding is hidden
- User completion marks localStorage with `true` value

## 📱 Responsive Breakpoints

### Desktop (> 480px)
- Container: 420px max-width
- Full padding: 40px 28px 32px
- Title: 24px
- Description: 15px

### Tablet (≤ 480px)
- Container: 100% width
- Padding: 32px 20px 28px
- Title: 20px
- Description: 14px

### Mobile (≤ 360px)
- Padding: 24px 16px 20px
- Actions stack vertically
- Reduced gaps & sizing

## 🎬 Animations

### Fade (Overlay)
- 0.3s ease in/out
- Smooth appearance/disappearance

### Slide-Fade (Content)
- 0.4s ease in/out
- Enters from right (+20px x), exits left (-20px x)
- Combined with opacity

### Button Interactions
- Hover: Slight lift (-2px) + shadow enhancement
- Active: Return to baseline
- Smooth 0.3s transitions

## ✨ UI Components

### Pagination Dots
- Inactive: 8px circle, `#cbd5e1`
- Active: 24px rounded-rect, `#475569`
- Clickable for navigation
- Smooth transitions

### Buttons
- **Primary**: Slate background with white text
- **Secondary**: Light background with border
- **Skip**: Text-only, minimal style
- Hover states: Color shift + slight elevation
- Active: Baseline movement

### Highlights List
- Grid layout with gaps
- Bullet indicator (6px dot)
- Soft background container
- Semantic list structure

## 🔒 localStorage Integration

**Key**: `elevateher_onboarding_completed`
**Value**: `'true'` (string)
**Scope**: Local to domain
**Persistence**: Until manually cleared or localStorage cleared

### Clearing (for testing)
```javascript
localStorage.removeItem('elevateher_onboarding_completed')
// or
localStorage.clear()
```

## 🚀 Performance Optimizations

- Inline SVG icons (no external requests)
- CSS animations (GPU accelerated)
- Computed properties for conditional rendering
- Efficient re-renders with Composition API
- Minimal DOM structure
- ~5KB gzipped component

## ♿ Accessibility

- Semantic HTML structure
- ARIA labels on interactive elements
- Keyboard navigable buttons
- Clear visual hierarchy
- High contrast colors (WCAG AA compliant)
- Focus states on buttons
- Proper heading levels

## 🔌 Integration Points

### Global Registration
```javascript
// main.js
app.component('OnboardingTour', OnboardingTour)
```

### Local Registration
```vue
import OnboardingTour from '@/components/utils/OnboardingTour.vue'
```

### Usage
```vue
<OnboardingTour ref="onboarding" />
```

## 🧪 Testing

### Reset Onboarding
```javascript
// In component
const onboarding = ref(null)
onboarding.value?.resetOnboarding()
```

### Check Completion Status
```javascript
const isCompleted = localStorage.getItem('elevateher_onboarding_completed') === 'true'
```

## 📊 Browser Support

- ✅ Chrome/Edge 88+
- ✅ Firefox 85+
- ✅ Safari 15+
- ✅ iOS Safari 15+
- ✅ Android Chrome 88+

**Note**: Graceful degradation if `backdrop-filter` not supported

## 🎓 Learning Resource

This component demonstrates:
- Vue 3 Composition API
- Reactive state management
- Computed properties
- Component lifecycle
- CSS animations & transitions
- Responsive design
- localStorage API
- SVG icons
- Accessibility best practices
