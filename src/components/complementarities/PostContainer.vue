<template>
    <div class="page post-container-page" :class="special ? 'post-with-special' : ''">
        <div class="pc-wrap">
            <!-- PROMOTED HEADER CARD -->
            <div v-if="special" class="pc-promoted">
                <div class="pc-promoted-top">
                    <div class="pc-badge">
                        <i class="fas fa-bullhorn"></i>
                        <span>Öne Çıkan</span>
                    </div>

                    <button type="button" class="pc-close" @click="goBack" aria-label="Kapat">
                        <i class="fas fa-times"></i>
                    </button>
                </div>

                <div class="pc-promoted-body">
                    <div class="pc-promoted-media">
                        <img :src="specialImage" class="pc-img" alt="" />
                    </div>

                    <div class="pc-promoted-text">
                        <div class="pc-title">
                            {{ special.story_top_text || special.image_text || "Sponsorlu içerik" }}
                        </div>

                        <div v-if="special.story_bottom_text" class="pc-subtitle">
                            {{ special.story_bottom_text }}
                        </div>

                        <div class="pc-meta" v-if="special.image_text || special.fk_profile_id || special.fk_post_id">
                            <span v-if="special.image_text" class="pc-chip">
                                <i class="fas fa-tag"></i> {{ special.image_text }}
                            </span>

                            <span v-if="special.fk_post_id" class="pc-chip">
                                <i class="fas fa-file-alt"></i> Post #{{ special.fk_post_id }}
                            </span>

                            <span v-if="special.fk_profile_id" class="pc-chip">
                                <i class="fas fa-user"></i> Profil #{{ special.fk_profile_id }}
                            </span>
                        </div>

                        <!-- CTA -->
                        <button v-if="special?.action_button_text" type="button" class="pc-cta"
                            :disabled="!special?.action_url" @click="openSpecialLink()">
                            <span>{{ special.action_button_text }}</span>
                            <i class="fas fa-arrow-right"></i>
                        </button>

                        <!-- action_url görünür -->
                        <div v-if="special?.action_url" class="pc-link" role="button" tabindex="0"
                            @click="openSpecialLink()" @keydown.enter.prevent="openSpecialLink()">
                            <i class="fas fa-link"></i>
                            <span class="pc-link-text">{{ shortUrl(special.action_url) }}</span>
                        </div>
                    </div>
                </div>

                <div class="pc-promoted-foot">
                    <span class="pc-disclaimer">
                        Bu içerik öne çıkarılmıştır.
                    </span>
                </div>
            </div>

            <!-- POST AREA -->
            <div class="posts-list">
                <div v-if="loading" class="pc-status">
                    <span class="pc-spinner"></span>
                    Yükleniyor…
                </div>

                <div v-else-if="error" class="pc-status pc-status--error">
                    <i class="fas fa-triangle-exclamation"></i>
                    <span>{{ error }}</span>
                </div>

                <PostCard v-else v-for="post in filteredPosts" :key="post.id" :post="post" />
            </div>
        </div>
    </div>
</template>

<script>
import PostCard from "@/components/complementarities/PostCard.vue"

export default {
    name: "PostContainer",
    components: { PostCard },

    data() {
        return {
            loading: false,
            error: "",
            localPost: null,
        }
    },

    computed: {
        postId() {
            const raw = this.$route?.params?.postID
            const id = Number(raw)
            return Number.isFinite(id) ? id : null
        },

        // PartnerRail’den params ile gelen obje
        special() {
            if (this.$route?.params?.specialPostId == null) return null
            return this.$store.state.comingUps?.find(
                (x) => String(x.id) === String(this.$route?.params?.specialPostId)
            ) || null
        },

        specialImage() {
            const s = this.special?.image_url
            if (!s) return "/static/img/add_photo.png"
            const url = String(s)
            if (url.startsWith("http://") || url.startsWith("https://")) return url
            if (url.startsWith("/")) return this.$store.state.serverLocation + url
            return url
        },

        filteredPosts() {
            return this.localPost ? [this.localPost] : []
        },
    },

    created() {
        this.ensurePost()
    },

    watch: {
        "$route.params.postID"() {
            this.ensurePost()
        },
    },

    methods: {
        openSpecialLink() {
            const url = this.special?.action_url
            if (!url) return
            window.open(url, "_blank", "noopener,noreferrer")
        },

        shortUrl(url) {
            try {
                const u = new URL(url)
                const host = u.hostname.replace(/^www\./, "")
                const path = u.pathname && u.pathname !== "/" ? u.pathname : ""
                return host + path
            } catch {
                return String(url).replace(/^https?:\/\//, "").slice(0, 42)
            }
        },
        goBack() {
            // history varsa dön, yoksa home
            if (window.history.length > 1) this.$router.back()
            else this.$router.push({ name: "home" })
        },

        shortUrl(u) {
            try {
                const x = new URL(u)
                return x.host + x.pathname
            } catch {
                return String(u).slice(0, 40) + (String(u).length > 40 ? "…" : "")
            }
        },

        // CTA tıklaması: aynı routing kuralını burada da uygula
        handleCta() {
            const item = this.special
            if (!item) return

            if (item.fk_post_id) {
                // zaten post ekranındayız ama başka post olabilir
                this.$router.push({ name: "postcontainer", params: { postID: item.fk_post_id, special: item } })
                return
            }

            if (item.fk_business_id) {
                this.$router.push({ name: "business", params: { businessID: item.fk_business_id } })
                return
            }

            if (item.fk_profile_id) {
                this.$router.push({ name: "profile", params: { profileID: item.fk_profile_id } })
                return
            }

            if (item.action_url) {
                window.open(item.action_url, "_blank", "noopener,noreferrer")
            }
        },

        async ensurePost() {
            this.error = ""
            this.localPost = null

            if (!this.postId) {
                this.error = "Geçersiz gönderi."
                return
            }

            this.loading = true
            try {
                const res = await this.$store.dispatch("fetchPostById", this.postId)

                const post =
                    (res && res.data && (res.data.post || res.data)) ||
                    res

                if (!post || !post.id) {
                    this.error = "Gönderi bulunamadı."
                } else {
                    this.localPost = post
                }
            } catch (e) {
                console.error(e)
                this.error = "Gönderi yüklenemedi."
            } finally {
                this.loading = false
            }
        },
    },
}
</script>

<style scoped>
.post-container-page {
    padding-top: 12px;
    padding-left: 12px;
    padding-right: 12px;
}

.pc-wrap {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

/* promoted card */
.pc-promoted {
    border-radius: 18px;
    overflow: hidden;
    background: #ffffff;
    box-shadow: 0 10px 28px rgba(15, 23, 42, 0.10);
    border: 1px solid rgba(37, 99, 235, 0.18);
}

:global(body.dark-mode) .pc-promoted {
    background: #111827;
    border-color: rgba(59, 130, 246, 0.25);
    box-shadow: 0 14px 34px rgba(0, 0, 0, 0.55);
}

.pc-promoted-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 12px;
    background: linear-gradient(90deg, rgba(37, 99, 235, 0.10), rgba(37, 99, 235, 0.02));
    border-bottom: 1px solid rgba(37, 99, 235, 0.18);
}

:global(body.dark-mode) .pc-promoted-top {
    border-bottom-color: rgba(37, 99, 235, 0.25);
}

.pc-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 6px 10px;
    border-radius: 999px;
    background: rgba(37, 99, 235, 0.14);
    color: #1d4ed8;
    font-weight: 800;
    font-size: 12px;
}

:global(body.dark-mode) .pc-badge {
    color: #bfdbfe;
    background: rgba(37, 99, 235, 0.18);
}

.pc-close {
    border: 0;
    background: transparent;
    color: #64748b;
    width: 34px;
    height: 34px;
    border-radius: 999px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

.pc-close:active {
    transform: scale(0.96);
}

:global(body.dark-mode) .pc-close {
    color: #9ca3af;
}

.pc-promoted-body {
    display: flex;
    gap: 12px;
    padding: 12px;
}

.pc-promoted-media {
    flex: 0 0 92px;
    width: 92px;
    height: 92px;
    border-radius: 16px;
    overflow: hidden;
    background: #f1f5f9;
    border: 1px solid rgba(15, 23, 42, 0.08);
}

:global(body.dark-mode) .pc-promoted-media {
    background: #0b1220;
    border-color: rgba(255, 255, 255, 0.08);
}

.pc-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.pc-promoted-text {
    flex: 1;
    min-width: 0;
}

.pc-title {
    font-weight: 900;
    font-size: 15px;
    color: #0f172a;
    line-height: 1.2;
}

:global(body.dark-mode) .pc-title {
    color: #e5e7eb;
}

.pc-subtitle {
    margin-top: 4px;
    font-size: 12px;
    color: #64748b;
    font-weight: 700;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

:global(body.dark-mode) .pc-subtitle {
    color: #9ca3af;
}

.pc-meta {
    margin-top: 8px;
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
}

.pc-chip {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 8px;
    border-radius: 999px;
    font-size: 11px;
    font-weight: 800;
    color: #0f172a;
    background: rgba(15, 23, 42, 0.04);
}

:global(body.dark-mode) .pc-chip {
    color: #e5e7eb;
    background: rgba(255, 255, 255, 0.06);
}

.pc-cta {
    margin-top: 10px;
    width: 100%;
    border: 0;
    border-radius: 14px;
    padding: 10px 12px;
    cursor: pointer;
    background: #2563eb;
    color: #ffffff;
    font-weight: 900;
    display: inline-flex;
    align-items: center;
    justify-content: space-between;
}

.pc-cta:active {
    transform: scale(0.99);
}

.pc-link {
    margin-top: 8px;
    display: flex;
    gap: 8px;
    align-items: center;
    font-size: 12px;
    color: #64748b;
}

:global(body.dark-mode) .pc-link {
    color: #9ca3af;
}

.pc-link-text {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.pc-promoted-foot {
    padding: 9px 12px 12px;
    border-top: 1px dashed rgba(15, 23, 42, 0.12);
}

:global(body.dark-mode) .pc-promoted-foot {
    border-top-color: rgba(255, 255, 255, 0.10);
}

.pc-disclaimer {
    font-size: 11px;
    font-weight: 700;
    color: #94a3b8;
}

/* Post list */
.posts-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

/* Status */
.pc-status {
    padding: 14px 12px;
    border-radius: 14px;
    background: #fff;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
    color: #0f172a;
    font-size: 14px;
    font-weight: 700;
    display: inline-flex;
    gap: 10px;
    align-items: center;
}

:global(body.dark-mode) .pc-status {
    background: #111827;
    color: #e5e7eb;
    box-shadow: 0 12px 26px rgba(0, 0, 0, 0.55);
}

.pc-status--error {
    color: #dc2626;
}

.pc-spinner {
    width: 18px;
    height: 18px;
    border-radius: 999px;
    border: 2px solid rgba(100, 116, 139, 0.25);
    border-top-color: rgba(37, 99, 235, 0.85);
    animation: pcspin 0.8s linear infinite;
}

@keyframes pcspin {
    to {
        transform: rotate(360deg);
    }
}

.post-with-special {
    padding-top: 12px !important;
}
</style>