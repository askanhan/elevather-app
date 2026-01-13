<template>
    <div class="page">
        <!-- Topbar -->
        <div class="conv-topbar">
            <button class="conv-topbar__back" @click="$router.back()" aria-label="Back">
                <i class="fa fa-arrow-left"></i>
            </button>

            <div class="conv-topbar__title">
                <div class="conv-topbar__h1">
                    <span>{{ $t('components.conversations.title') }}</span>
                </div>
                <div class="conv-topbar__sub">
                    <span v-if="unreadCount">
                        <span>{{ $t('components.conversations.unread', {n: unreadCount}) }}</span>
                    </span>
                    <span v-else class="muted">
                        <span>{{ $t('components.conversations.upToDate') }}</span>
                    </span>
                </div>
            </div>

            <button class="conv-topbar__refresh" @click="loadConversations(true)" aria-label="Refresh">
  <i class="fa fa-sync"></i>
</button>
        </div>

        <!-- Search -->
        <div class="conv-search">
            <i class="fa fa-magnifying-glass conv-search__icon"></i>
            <input class="conv-search__input" type="text" v-model="query" :placeholder="searchPlaceholder" />
            <button v-if="query" class="conv-search__clear" @click="query = ''" aria-label="Clear">
                <i class="fa fa-xmark"></i>
            </button>
        </div>

        <!-- Body -->
        <div class="conv-body">
            <!-- Loading skeleton -->
            <div v-if="isLoading" class="conv-skeleton">
                <div v-for="n in 7" :key="n" class="sk-row">
                    <div class="sk-avatar"></div>
                    <div class="sk-lines">
                        <div class="sk-line sk-line--title"></div>
                        <div class="sk-line sk-line--sub"></div>
                    </div>
                    <div class="sk-pill"></div>
                </div>
            </div>

            <!-- Empty -->
            <div v-else-if="!filteredConversations.length" class="conv-empty">
                <div class="conv-empty__icon">
                    <i class="fa fa-comments"></i>
                </div>
                <div class="conv-empty__title">
                    <span>{{ $t('components.conversations.emptyTitle') }}</span>
                </div>
                <div class="conv-empty__sub">
                    <span>{{ $t('components.conversations.emptySub') }}</span>
                </div>
            </div>

            <!-- List -->
            <div v-else class="conv-list">
                <button v-for="c in filteredConversations" :key="cKey(c)" class="conv-item"
                    :class="{ 'is-unread': !!c.has_unread }" @click="openConversation(c)" type="button">
                    <div class="conv-item__avatar">
                        <ProfileAvatar :name="otherName(c)" :photo-url="otherPhoto(c)" :clickable="false" size="44" />
                        <span v-if="c.has_unread" class="conv-item__dot" />
                    </div>

                    <div class="conv-item__main">
                        <div class="conv-item__top">
                            <div class="conv-item__name">
                                {{ otherName(c) }}
                            </div>
                            <div class="conv-item__time">
                                {{ lastTime(c) }}
                            </div>
                        </div>

                        <div class="conv-item__bottom">
                            <div class="conv-item__snippet">
                                <span v-if="isFromMe(c)" class="me-prefix">
                                    <span>{{ $t('components.conversations.you') }}</span>
                                </span>
                                {{ lastText(c) }}
                            </div>

                            <div v-if="c.has_unread" class="conv-item__badge">
                                <span>{{ $t('components.conversations.new') }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="conv-item__chev">
                        <i class="fa fa-angle-right"></i>
                    </div>
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import ProfileAvatar from '@/components/complementarities/ProfileAvatar.vue'
import basicOperations from '@/mixins/basic-operations'
import UIText from '@/mixins/ui-text.js'

export default {
    name: 'Conversations',
    components: { ProfileAvatar },
    mixins: [basicOperations, UIText],

    data() {
        return {
            isLoading: false,
            query: '',
        }
    },

    computed: {
        conversations() {
            return this.$store?.state?.allConversations || []
        },
        lang() {
            return this.$store?.state?.lang
        },

        myProfileId() {
            return this.$store?.state?.profile?.p_id ?? this.$store?.state?.myProfile?.id ?? 0
        },

        unreadCount() {
            return (this.conversations || []).reduce((acc, c) => acc + (c?.has_unread ? 1 : 0), 0)
        },

        searchPlaceholder() {
            return this.$t('components.conversations.searchPlaceholder')
        },

        filteredConversations() {
            const q = (this.query || '').trim().toLowerCase()
            if (!q) return this.conversations || []

            return (this.conversations || []).filter((c) => {
                const name = (this.otherName(c) || '').toLowerCase()
                const msg = (this.lastText(c) || '').toLowerCase()
                return name.includes(q) || msg.includes(q)
            })
        },
    },

    created() {
        this.loadConversations()
    },

    methods: {
        // ---- Fetch ----
        async loadConversations() {
            this.$store.dispatch('getAllConversations')
        },

        // ---- Mapping helpers (matches your backend shape) ----
        cKey(c) {
            // stable key if possible
            return c?.other_profile?.id ?? c?.other_profile_id ?? c?.last_message?.id ?? Math.random()
        },

        otherId(c) {
            return c?.other_profile?.id ?? null
        },

        otherName(c) {
            const p = c?.other_profile || {}
            return (
                p.full_name ||
                [p.name, p.lastname].filter(Boolean).join(' ') ||
                p.username ||
                'Kullanıcı'
            )
        },

        otherPhoto(c) {
            const p = c?.other_profile || {}
            const raw = p.profile_photo || ""
            return p.profile_photo
        },

        lastText(c) {
            const lm = c?.last_message
            return (lm?.content || '').trim() || '...'
        },

        lastTime(c) {
            const d = c?.last_message?.pm_date
            if (!d) return ''
            // moment is already used in your project; keeping same style
            return new moment(d).fromNow()
        },

        isFromMe(c) {
            const lm = c?.last_message
            if (typeof lm?.is_from_me === 'boolean') return lm.is_from_me
            // fallback guess
            return String(lm?.from_profile) === String(this.myProfileId)
        },

        // ---- Navigation ----
        openConversation(c) {
            const profileID = this.otherId(c)
            if (!profileID) return

            // if you want to pass the other_profile too, you can add params/profile,
            // but keeping it simple to avoid huge route payloads.
            this.$router.push({ name: 'chat', params: { profileID } })
        },
    },
}
</script>

<style scoped>
.conv-page {
    min-height: 100vh;
    background: #f6f7fb;
    padding-bottom: 16px;
}

.conv-topbar {
    position: sticky;
    top: 0;
    z-index: 10;
    display: grid;
    grid-template-columns: 44px 1fr 44px;
    align-items: center;
    gap: 8px;
    padding: 10px 12px;
    background: rgba(246, 247, 251, 0.92);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(17, 24, 39, 0.06);
}

.conv-topbar__back,
.conv-topbar__refresh {
    width: 40px;
    height: 40px;
    border-radius: 12px;
    border: 1px solid rgba(17, 24, 39, 0.08);
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #111827;
    cursor: pointer;
}

.conv-topbar__title {
    min-width: 0;
}

.conv-topbar__h1 {
    font-size: 14px;
    font-weight: 800;
    color: #0f172a;
    letter-spacing: -0.2px;
    line-height: 1.1;
}

.conv-topbar__sub {
    margin-top: 2px;
    font-size: 12px;
    color: rgba(15, 23, 42, 0.62);
}

.muted {
    color: rgba(15, 23, 42, 0.5);
}

.conv-search {
    margin: 12px 12px 8px;
    background: #fff;
    border: 1px solid rgba(17, 24, 39, 0.08);
    border-radius: 14px;
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    box-shadow: 0 10px 26px rgba(15, 23, 42, 0.05);
}

.conv-search__icon {
    color: rgba(15, 23, 42, 0.45);
    font-size: 14px;
}

.conv-search__input {
    flex: 1;
    border: 0;
    outline: none;
    font-size: 13px;
    color: #0f172a;
    background: transparent;
    min-width: 0;
}

.conv-search__clear {
    border: 0;
    background: transparent;
    color: rgba(15, 23, 42, 0.45);
    cursor: pointer;
    padding: 6px;
    border-radius: 10px;
}

.conv-body {
    padding: 6px 12px 0;
}

.conv-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.conv-item {
    width: 100%;
    border: 1px solid rgba(17, 24, 39, 0.08);
    background: #fff;
    border-radius: 16px;
    padding: 12px;
    display: grid;
    grid-template-columns: 52px 1fr 18px;
    gap: 10px;
    align-items: center;
    text-align: left;
    box-shadow: 0 14px 40px rgba(15, 23, 42, 0.06);
    cursor: pointer;
    transition: transform .12s ease, box-shadow .12s ease;
}

.conv-item:active {
    transform: scale(0.99);
    box-shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
}

.conv-item.is-unread {
    border-color: rgba(59, 130, 246, 0.25);
    box-shadow: 0 14px 40px rgba(59, 130, 246, 0.08);
}

.conv-item__avatar {
    position: relative;
    width: 52px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.conv-item__dot {
    position: absolute;
    right: 5px;
    bottom: 6px;
    width: 10px;
    height: 10px;
    border-radius: 999px;
    background: #3b82f6;
    border: 2px solid #fff;
}

.conv-item__main {
    min-width: 0;
}

.conv-item__top {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
}

.conv-item__name {
    font-size: 14px;
    font-weight: 800;
    color: #0f172a;
    letter-spacing: -0.2px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.conv-item__time {
    font-size: 11px;
    color: rgba(15, 23, 42, 0.55);
    white-space: nowrap;
}

.conv-item__bottom {
    margin-top: 4px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
}

.conv-item__snippet {
    font-size: 12.5px;
    color: rgba(15, 23, 42, 0.70);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    min-width: 0;
}

.me-prefix {
    font-weight: 700;
    color: rgba(15, 23, 42, 0.75);
    margin-right: 6px;
}

.conv-item__badge {
    font-size: 11px;
    font-weight: 800;
    color: #1d4ed8;
    background: rgba(59, 130, 246, 0.10);
    border: 1px solid rgba(59, 130, 246, 0.18);
    padding: 4px 10px;
    border-radius: 999px;
    white-space: nowrap;
}

.conv-item__chev {
    color: rgba(15, 23, 42, 0.35);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
}

/* Empty */
.conv-empty {
    margin: 24px 6px 0;
    padding: 26px 16px;
    border-radius: 18px;
    border: 1px dashed rgba(17, 24, 39, 0.14);
    background: rgba(255, 255, 255, 0.7);
    text-align: center;
}

.conv-empty__icon {
    width: 54px;
    height: 54px;
    border-radius: 16px;
    margin: 0 auto 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(15, 23, 42, 0.06);
    color: rgba(15, 23, 42, 0.65);
    font-size: 20px;
}

.conv-empty__title {
    font-weight: 900;
    color: #0f172a;
    font-size: 14px;
}

.conv-empty__sub {
    margin-top: 6px;
    font-size: 12px;
    color: rgba(15, 23, 42, 0.60);
    line-height: 1.35;
}

/* Skeleton */
.conv-skeleton {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding-top: 6px;
}

.sk-row {
    display: grid;
    grid-template-columns: 52px 1fr 50px;
    gap: 10px;
    align-items: center;
    background: #fff;
    border: 1px solid rgba(17, 24, 39, 0.08);
    border-radius: 16px;
    padding: 12px;
    box-shadow: 0 14px 40px rgba(15, 23, 42, 0.06);
}

.sk-avatar {
    width: 44px;
    height: 44px;
    border-radius: 999px;
    background: linear-gradient(90deg, rgba(15, 23, 42, 0.06), rgba(15, 23, 42, 0.10), rgba(15, 23, 42, 0.06));
    background-size: 200% 100%;
    animation: shimmer 1.1s infinite linear;
}

.sk-lines {
    display: flex;
    flex-direction: column;
    gap: 8px;
    min-width: 0;
}

.sk-line {
    height: 10px;
    border-radius: 999px;
    background: linear-gradient(90deg, rgba(15, 23, 42, 0.06), rgba(15, 23, 42, 0.10), rgba(15, 23, 42, 0.06));
    background-size: 200% 100%;
    animation: shimmer 1.1s infinite linear;
}

.sk-line--title {
    width: 62%;
}

.sk-line--sub {
    width: 92%;
    height: 9px;
    opacity: 0.9;
}

.sk-pill {
    width: 44px;
    height: 18px;
    border-radius: 999px;
    background: linear-gradient(90deg, rgba(15, 23, 42, 0.06), rgba(15, 23, 42, 0.10), rgba(15, 23, 42, 0.06));
    background-size: 200% 100%;
    animation: shimmer 1.1s infinite linear;
}

@keyframes shimmer {
    0% {
        background-position: 200% 0;
    }

    100% {
        background-position: -200% 0;
    }
}
</style>