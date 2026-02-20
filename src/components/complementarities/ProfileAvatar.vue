<template>
    <div class="vt-avatar" :class="{
        'vt-avatar--rounded': rounded,
        'vt-avatar--clickable': clickable,
        'vt-avatar--responsive': responsive
    }" :style="avatarStyle" @click="handleClick">
        <span v-if="!photoUrl" class="vt-avatar__initials" :style="initialsStyle">
            {{ initials }}
        </span>
    </div>
</template>

<script>

export default {
    name: 'ProfileAvatar',

    props: {
        name: { type: String, required: true },
        photoUrl: { type: String, default: null },

        // kare avatar boyutu
        size: { type: [Number, String], default: 90 },

        // responsive: width 100%, height = width olacak
        responsive: { type: Boolean, default: false },

        rounded: { type: Boolean, default: true },
        clickable: { type: Boolean, default: false }
    },

    computed: {
        sizePx() {
            if (this.responsive) return null
            const n = Number(this.size)
            return Number.isFinite(n) ? n : 90
        },

        realUrl() {
            return this.photoUrl.startsWith('http') ? this.photoUrl : this.$store.state.serverLocation + this.photoUrl
        },  

        avatarStyle() {
            // business.p_photo_link ? _pPhotoUrl(business.p_photo_link) : null
            
            let bg;
            if (this.photoUrl) {
                bg = this.photoUrl.startsWith('http') 
                    ? this.photoUrl 
                    : this.$store.state.serverLocation + this.photoUrl;
            } else {
                bg = genericLogo;
            }
            // responsive mod
            if (this.responsive) {
                return {
                    width: '100%',
                    backgroundImage: `url(${bg})`,
                    backgroundSize: 'cover',
                    backgroundPosition: 'center'
                }
            }

            // fixed size mod
            return {
                width: this.sizePx + 'px',
                height: this.sizePx + 'px',
                backgroundImage: `url(${bg})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center'
            }
        },

        initialsStyle() {
            if (this.responsive) {
                // responsive modda font-size'ı CSS'ten yöneteceğiz
                return {}
            }

            // fixed size mod
            return {
                fontSize: Math.round(this.sizePx * 0.38) + 'px'
            }
        },

        initials() {
            const name = (this.name || '').trim()
            if (!name) return '?'

            const p = name.split(/\s+/)
            if (p.length === 1) return p[0][0].toUpperCase()
            return (p[0][0] + p[1][0]).toUpperCase()
        }
    },

    methods: {
        handleClick() {
            if (this.clickable) this.$emit('click')
        }
    }
}
</script>

<style scoped>
.vt-avatar {
    position: relative;
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    display: flex;
    justify-content: center;
    align-items: center;
}

.vt-avatar--responsive {
    width: 100%;
    aspect-ratio: 1 / 1;
    /* kare */
}

.vt-avatar--rounded {
    border-radius: 50%;
}

.vt-avatar--clickable {
    cursor: pointer;
}

.vt-avatar__initials {
    /* ARTIK absolute değil, flex ile ortalanacak */
    font-weight: 700;
    letter-spacing: 1px;
    color: #ffffff;
    text-shadow:
        0 0 3px rgba(0, 0, 0, 0.65),
        0 2px 4px rgba(0, 0, 0, 0.55),
        0 0 10px rgba(0, 0, 0, 0.4);
    user-select: none;
    line-height: 1;
    font-size: 32px;
}

.vt-avatar--responsive .vt-avatar__initials {
    font-size: 3.1rem;
    /* biraz büyük dursun */
}
</style>