<template>

    <div class="ref-page">

        <header class="ref-header">
            <button class="ref-back" @click="goBack">← Back</button>
            <h1 class="ref-title">My Reflections</h1>
        </header>

        <!-- New reflection -->
        <section class="ref-card ref-new">
            <div class="ref-card-head">
                <span class="ref-h2">New reflection</span>
            </div>

            <input v-model="newTitle" class="ref-input" type="text" placeholder="Title (optional)" maxlength="255" />

            <textarea v-model="newContent" class="ref-textarea"
                placeholder="What's on your mind? What did you learn today?" rows="4" maxlength="2000"></textarea>

            <div class="ref-new-bottom mb-3">
                <select v-model="newTrack" class="ref-select">
                    <option value="">No track</option>
                    <option v-for="cat in categories" :key="cat.id" :value="cat.title">
                        {{ cat.title }}
                    </option>
                </select>
            </div>

            <button class="ref-save-btn" :disabled="!newContent.trim() || saving" @click="create">
                {{ saving ? 'Saving…' : 'Save' }}
            </button>
        </section>

        <!-- Empty state -->
        <div v-if="!loading && !reflections.length" class="ref-empty">
            <p>No reflections yet. Write your first one above.</p>
        </div>

        <!-- Reflections list -->
        <section v-for="r in reflections" :key="r.id" class="ref-card ref-item">

            <!-- View mode -->
            <template v-if="editingId !== r.id">
                <div class="ref-item-top">
                    <span class="ref-chip" v-if="r.track">{{ r.track }}</span>
                    <span class="ref-chip ref-date">{{ formatDate(r.created_at) }}</span>
                    <div class="ref-item-actions">
                        <button class="ref-action-btn" @click="startEdit(r)">✎</button>
                        <button class="ref-action-btn ref-delete" @click="remove(r.id)">✕</button>
                    </div>
                </div>
                <div class="ref-item-title">{{ r.title }}</div>
                <div class="ref-item-body">{{ r.content }}</div>
            </template>

            <!-- Edit mode -->
            <template v-else>
                <input v-model="editTitle" class="ref-input" type="text" placeholder="Title" />
                <textarea v-model="editContent" class="ref-textarea" rows="4"></textarea>
                <select v-model="editTrack" class="ref-select">
                    <option value="">No track</option>
                    <option v-for="cat in categories" :key="cat.id" :value="cat.title">
                        {{ cat.title }}
                    </option>
                </select>
                <div class="ref-edit-actions">
                    <button class="ref-cancel-btn" @click="cancelEdit">Cancel</button>
                    <button class="ref-save-btn" :disabled="!editContent.trim()" @click="saveEdit(r.id)">Save</button>
                </div>
            </template>
        </section>

        <!-- Load more -->
        <div v-if="reflections.length < total" class="ref-load-more">
            <button class="ref-load-btn" @click="loadMore">Load more</button>
        </div>

        <!-- Loading -->
        <div v-if="loading" class="ref-loading">Loading…</div>

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
    name: 'Reflections',

    data() {
        return {
            reflections: [],
            total: 0,
            loading: false,
            saving: false,
            newTitle: '',
            newContent: '',
            newTrack: '',
            editingId: null,
            editTitle: '',
            editContent: '',
            editTrack: '',
            limit: 20,
        }
    },

    computed: {
        userId() {
            const u = this.$store.state.user
            return u?.id || this.$store.state.myProfile?.fk_user_id || 1
        },

        categories() {
            return this.$store.state.journeyCategories || []
        },
    },

    async mounted() {
        await this.$store.dispatch('fetchJourneyData').catch(() => { })
        await this.load()
    },

    methods: {
        async load() {
            this.loading = true
            try {
                const { data } = await api.get(`/user/${this.userId}/reflections/`, {
                    params: { limit: this.limit, offset: 0 },
                })
                this.reflections = data.reflections
                this.total = data.total
            } catch (e) {
                console.error('Error loading reflections:', e)
            } finally {
                this.loading = false
            }
        },

        async loadMore() {
            this.loading = true
            try {
                const { data } = await api.get(`/user/${this.userId}/reflections/`, {
                    params: { limit: this.limit, offset: this.reflections.length },
                })
                this.reflections.push(...data.reflections)
                this.total = data.total
            } catch (e) {
                console.error('Error loading more:', e)
            } finally {
                this.loading = false
            }
        },

        async create() {
            if (!this.newContent.trim()) return
            this.saving = true
            try {
                await api.post('/reflections/create/', {
                    user_id: this.userId,
                    title: this.newTitle.trim() || '',
                    content: this.newContent.trim(),
                    track: this.newTrack || null,
                })
                this.newTitle = ''
                this.newContent = ''
                this.newTrack = ''
                await this.load()
            } catch (e) {
                console.error('Error creating reflection:', e)
            } finally {
                this.saving = false
            }
        },

        startEdit(r) {
            this.editingId = r.id
            this.editTitle = r.title
            this.editContent = r.content
            this.editTrack = r.track || ''
        },

        cancelEdit() {
            this.editingId = null
        },

        async saveEdit(id) {
            try {
                await api.put(`/reflections/${id}/update/`, {
                    title: this.editTitle.trim(),
                    content: this.editContent.trim(),
                    track: this.editTrack || null,
                })
                this.editingId = null
                await this.load()
            } catch (e) {
                console.error('Error updating reflection:', e)
            }
        },

        async remove(id) {
            if (!confirm('Delete this reflection?')) return
            try {
                await api.delete(`/reflections/${id}/delete/`, {
                    params: { user_id: this.userId },
                })
                await this.load()
            } catch (e) {
                console.error('Error deleting reflection:', e)
            }
        },

        formatDate(dateStr) {
            if (!dateStr) return ''
            const d = new Date(dateStr)
            const now = new Date()
            const diffMs = now - d
            const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))

            if (diffDays === 0) return 'Today'
            if (diffDays === 1) return 'Yesterday'
            if (diffDays < 7) return `${diffDays} days ago`
            if (diffDays < 30) return `${Math.floor(diffDays / 7)}w ago`
            return d.toLocaleDateString()
        },

        goBack() {
            this.$router.back()
        },
    },
}
</script>
<style>
.ref-page {
    min-height: 100vh;
    background: #f7f8fa;
    padding: 16px 16px 100px;
    max-width: 500px;
    margin: 0 auto;
}

.ref-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 20px;
}

.ref-back {
    background: none;
    border: none;
    font-size: 15px;
    color: #6b7280;
    cursor: pointer;
    padding: 0;
}

.ref-title {
    font-size: 22px;
    font-weight: 700;
    margin: 0;
}

/* Cards */
.ref-card {
    background: #fff;
    border-radius: 14px;
    padding: 16px;
    margin-bottom: 12px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.ref-card-head {
    margin-bottom: 12px;
}

.ref-h2 {
    font-size: 16px;
    font-weight: 700;
}

/* New reflection form */
.ref-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    font-size: 15px;
    outline: none;
    box-sizing: border-box;
    margin-bottom: 8px;
    font-family: inherit;
}

.ref-input:focus {
    border-color: #2563eb;
}

.ref-textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    font-size: 15px;
    outline: none;
    resize: none;
    box-sizing: border-box;
    font-family: inherit;
    line-height: 1.5;
}

.ref-textarea:focus {
    border-color: #2563eb;
}

.ref-select {
    padding: 8px 12px;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    font-size: 13px;
    background: #fff;
    color: #374151;
    outline: none;
    font-family: inherit;
}

.ref-new-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
    gap: 10px;
}

.ref-save-btn {
    padding: 8px 20px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.ref-save-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.ref-save-btn:active:not(:disabled) {
    transform: translateY(1px);
}

/* Reflection item */
.ref-item-top {
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 8px;
    flex-wrap: wrap;
}

.ref-chip {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
    background: #eff6ff;
    color: #2563eb;
    border: 1px solid #dbeafe;
}

.ref-date {
    background: #f3f4f6;
    color: #6b7280;
    border-color: #e5e7eb;
}

.ref-item-actions {
    margin-left: auto;
    display: flex;
    gap: 4px;
}

.ref-action-btn {
    background: none;
    border: none;
    font-size: 16px;
    color: #9ca3af;
    cursor: pointer;
    padding: 2px 6px;
    border-radius: 6px;
}

.ref-action-btn:hover {
    background: #f3f4f6;
    color: #374151;
}

.ref-delete:hover {
    background: #fee2e2;
    color: #ef4444;
}

.ref-item-title {
    font-size: 15px;
    font-weight: 600;
    color: #111827;
    margin-bottom: 4px;
}

.ref-item-body {
    font-size: 14px;
    color: #4b5563;
    line-height: 1.5;
    white-space: pre-wrap;
}

/* Edit mode */
.ref-edit-actions {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    margin-top: 10px;
}

.ref-cancel-btn {
    padding: 8px 16px;
    background: #f3f4f6;
    color: #374151;
    border: none;
    border-radius: 10px;
    font-size: 14px;
    cursor: pointer;
}

/* Empty & loading */
.ref-empty {
    text-align: center;
    padding: 40px 16px;
    color: #9ca3af;
    font-size: 14px;
}

.ref-loading {
    text-align: center;
    padding: 20px;
    color: #9ca3af;
    font-size: 14px;
}

.ref-load-more {
    text-align: center;
    padding: 12px;
}

.ref-load-btn {
    padding: 10px 24px;
    background: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    font-size: 14px;
    color: #374151;
    cursor: pointer;
}

.ref-load-btn:active {
    background: #f3f4f6;
}
</style>