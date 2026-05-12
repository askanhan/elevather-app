<template>
    <div class="goals-page">

<!-- Back button -->
<header class="goals-header">
  <button class="goals-back" @click="goBack">← Back</button>
  <h1 class="goals-title">My Goals</h1>
</header>

<!-- Mission -->
<section class="goals-card">
  <div class="goals-card-head">
    <span class="goals-h2">My Mission</span>
  </div>
  <textarea
    v-model="mission"
    class="goals-mission-input"
    placeholder="Write your personal mission in one sentence…"
    rows="3"
    maxlength="500"
    @blur="saveMission"
  ></textarea>
  <div class="goals-mission-hint">This shapes your experience in the app.</div>
</section>

<!-- Selected goals -->
<section v-if="myGoals.length" class="goals-card">
  <div class="goals-card-head">
    <span class="goals-h2">My Goals</span>
    <span class="goals-count">{{ myGoals.length }} selected</span>
  </div>

  <div class="goals-my-list">
    <div v-for="g in myGoals" :key="g.id" class="goals-my-item">
      <div class="goals-my-top">
        <span class="goals-my-icon">{{ g.icon }}</span>
        <span class="goals-my-title">{{ g.title }}</span>
        <button class="goals-remove" @click="removeGoal(g.goal_id)">✕</button>
      </div>
      <div class="goals-status-row">
        <button
          v-for="s in statuses"
          :key="s.value"
          class="goals-status-btn"
          :class="{ active: g.status === s.value, [s.value]: true }"
          @click="changeStatus(g.id, s.value)"
        >
          {{ s.label }}
        </button>
      </div>
    </div>
  </div>
</section>

<!-- Browse goals -->
<section class="goals-card">
  <div class="goals-card-head">
    <span class="goals-h2">Browse Goals</span>
  </div>

  <!-- Category filter -->
  <div class="goals-cats">
    <button
      class="goals-cat-btn"
      :class="{ active: selectedCategory === 'all' }"
      @click="selectedCategory = 'all'"
    >All</button>
    <button
      v-for="cat in categories"
      :key="cat"
      class="goals-cat-btn"
      :class="{ active: selectedCategory === cat }"
      @click="selectedCategory = cat"
    >{{ cat }}</button>
  </div>

  <!-- Goals list -->
  <div class="goals-browse-list">
    <button
      v-for="g in filteredGoals"
      :key="g.id"
      class="goals-browse-item"
      :class="{ selected: isSelected(g.id) }"
      @click="toggleGoal(g.id)"
    >
      <span class="goals-browse-icon">{{ g.icon }}</span>
      <div class="goals-browse-text">
        <span class="goals-browse-title">{{ g.title }}</span>
        <span class="goals-browse-desc">{{ g.description }}</span>
      </div>
      <span class="goals-browse-check">{{ isSelected(g.id) ? '✓' : '+' }}</span>
    </button>
  </div>
</section>

</div>
</template>

<script>
import axios from 'axios'
import AppConfig from '@/config/app.config.js'

const api = axios.create({
  baseURL: AppConfig.API_BASE_URL,
  withCredentials: false,
})

api.interceptors.request.use((config) => {
  if (window.__ACCESS_TOKEN__) {
    config.headers = config.headers || {}
    config.headers.Authorization = `Bearer ${window.__ACCESS_TOKEN__}`
  }
  return config
})

export default {
  name: 'Goals',

  data() {
    return {
      mission: '',
      allGoals: [],
      myGoals: [],
      selectedCategory: 'all',
      statuses: [
        { value: 'working_on_it', label: 'Working on it' },
        { value: 'almost_done', label: 'Almost done' },
        { value: 'finished', label: 'Finished' },
      ],
    }
  },

  computed: {
    userId() {
      const u = this.$store.state.user
      return u?.id || this.$store.state.myProfile?.fk_user_id || 1
    },

    categories() {
      const cats = [...new Set(this.allGoals.map((g) => g.category).filter(Boolean))]
      return cats
    },

    filteredGoals() {
      if (this.selectedCategory === 'all') return this.allGoals
      return this.allGoals.filter((g) => g.category === this.selectedCategory)
    },

    selectedGoalIds() {
      return new Set(this.myGoals.map((g) => g.goal_id))
    },
  },

  async mounted() {
    await this.loadData()
  },

  methods: {
    async loadData() {
      try {
        const [goalsRes, myGoalsRes, missionRes] = await Promise.all([
          api.get('/goals/'),
          api.get(`/user/${this.userId}/goals/`),
          api.get(`/user/${this.userId}/mission/`),
        ])
        this.allGoals = goalsRes.data
        this.myGoals = myGoalsRes.data
        this.mission = missionRes.data.mission || ''
      } catch (e) {
        console.error('Error loading goals:', e)
      }
    },

    isSelected(goalId) {
      return this.selectedGoalIds.has(goalId)
    },

    async toggleGoal(goalId) {
      try {
        await api.post('/user/goals/toggle/', {
          user_id: this.userId,
          goal_id: goalId,
        })
        const { data } = await api.get(`/user/${this.userId}/goals/`)
        this.myGoals = data
      } catch (e) {
        console.error('Error toggling goal:', e)
      }
    },

    async removeGoal(goalId) {
      await this.toggleGoal(goalId)
    },

    async changeStatus(userGoalId, status) {
      try {
        await api.patch(`/user/goals/${userGoalId}/status/`, { status })
        const target = this.myGoals.find((g) => g.id === userGoalId)
        if (target) target.status = status
      } catch (e) {
        console.error('Error updating status:', e)
      }
    },

    async saveMission() {
      try {
        await api.put(`/user/${this.userId}/mission/update/`, {
          mission: this.mission,
        })
      } catch (e) {
        console.error('Error saving mission:', e)
      }
    },

    goBack() {
      this.$router.back()
    },
  },
}
</script>

<style scoped>
.goals-page {
  min-height: 100vh;
  background: #f7f8fa;
  padding: 16px 16px 100px;
  max-width: 500px;
  margin: 0 auto;
}

.goals-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
}

.goals-back {
  background: none;
  border: none;
  font-size: 15px;
  color: #6b7280;
  cursor: pointer;
  padding: 0;
}

.goals-title {
  font-size: 22px;
  font-weight: 700;
  margin: 0;
}

/* Cards */
.goals-card {
  background: #fff;
  border-radius: 14px;
  padding: 18px 16px;
  margin-bottom: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.goals-card-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.goals-h2 {
  font-size: 16px;
  font-weight: 700;
}

.goals-count {
  font-size: 13px;
  color: #6b7280;
}

/* Mission */
.goals-mission-input {
  width: 100%;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 12px;
  font-size: 15px;
  resize: none;
  outline: none;
  font-family: inherit;
  box-sizing: border-box;
  transition: border-color 0.2s;
}

.goals-mission-input:focus {
  border-color: #2563eb;
}

.goals-mission-hint {
  font-size: 12px;
  color: #9ca3af;
  margin-top: 6px;
}

/* My goals list */
.goals-my-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.goals-my-item {
  background: #f9fafb;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 12px;
}

.goals-my-top {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
}

.goals-my-icon {
  font-size: 20px;
}

.goals-my-title {
  flex: 1;
  font-size: 14px;
  font-weight: 600;
}

.goals-remove {
  background: none;
  border: none;
  color: #9ca3af;
  font-size: 16px;
  cursor: pointer;
  padding: 2px 6px;
  border-radius: 6px;
}

.goals-remove:hover {
  background: #fee2e2;
  color: #ef4444;
}

/* Status buttons */
.goals-status-row {
  display: flex;
  gap: 6px;
}

.goals-status-btn {
  flex: 1;
  padding: 6px 4px;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  background: #fff;
  font-size: 11px;
  font-weight: 500;
  color: #6b7280;
  cursor: pointer;
  transition: all 0.15s;
}

.goals-status-btn.active.working_on_it {
  background: #fef3c7;
  border-color: #f59e0b;
  color: #92400e;
}

.goals-status-btn.active.almost_done {
  background: #dbeafe;
  border-color: #3b82f6;
  color: #1e40af;
}

.goals-status-btn.active.finished {
  background: #d1fae5;
  border-color: #10b981;
  color: #065f46;
}

/* Category filter */
.goals-cats {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding-bottom: 12px;
  -webkit-overflow-scrolling: touch;
}

.goals-cat-btn {
  flex-shrink: 0;
  padding: 6px 14px;
  border-radius: 20px;
  border: 1px solid #e5e7eb;
  background: #fff;
  font-size: 13px;
  color: #374151;
  cursor: pointer;
  transition: all 0.15s;
}

.goals-cat-btn.active {
  background: #2563eb;
  border-color: #2563eb;
  color: #fff;
}

/* Browse goals list */
.goals-browse-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.goals-browse-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px;
  border-radius: 12px;
  border: 1px solid #e5e7eb;
  background: #fff;
  cursor: pointer;
  text-align: left;
  transition: all 0.15s;
  width: 100%;
}

.goals-browse-item:active {
  transform: scale(0.98);
}

.goals-browse-item.selected {
  border-color: #2563eb;
  background: #eff6ff;
}

.goals-browse-icon {
  font-size: 24px;
  flex-shrink: 0;
}

.goals-browse-text {
  flex: 1;
  min-width: 0;
}

.goals-browse-title {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #111827;
}

.goals-browse-desc {
  display: block;
  font-size: 12px;
  color: #6b7280;
  margin-top: 2px;
  line-height: 1.3;
}

.goals-browse-check {
  flex-shrink: 0;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: grid;
  place-items: center;
  font-size: 16px;
  font-weight: 700;
  color: #9ca3af;
  border: 2px solid #e5e7eb;
  background: #fff;
}

.goals-browse-item.selected .goals-browse-check {
  background: #2563eb;
  border-color: #2563eb;
  color: #fff;
}
</style>