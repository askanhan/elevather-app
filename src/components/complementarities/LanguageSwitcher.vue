<template>
    <span class="change-lang" @click="open" role="button">
        <span>
            <img class="me-3 mt-n1" width="20" :src="flagSrc(currentLang)" alt="">
            {{ $t(labelKey) }}
        </span>
    </span>

    <div v-if="isOpen" class="lang-modal-backdrop" @click.self="close">
        <div class="lang-modal">
            <div class="menu-title mt-n1">
                <h1>{{ $t(labelKey) }}</h1>
                <p class="color-theme opacity-70">{{ $t(subtitleKey) }}</p>
                <a class="close-menu" @click="close"><i class="fa fa-times"></i></a>
            </div>

            <div class="content mb-0 mt-0">
                <div class="divider mt-2 mb-0"></div>

                <div class="list-group list-custom-small ps-1">
                    <a @click="select('tr')">
                        <span class="lang-left">
                            <img class="me-3 mt-n1" width="20" :src="flagSrc('tr')">
                            <span>Türkçe</span>
                        </span>
                        <i class="fa fa-angle-right"></i>
                    </a>

                    <a @click="select('nl')">
                        <span class="lang-left">
                            <img class="me-3 mt-n1" width="20" :src="flagSrc('nl')">
                            <span>Nederlands</span>
                        </span>
                        <i class="fa fa-angle-right"></i>
                    </a>

                    <a @click="select('en')">
                        <span class="lang-left">
                            <img class="me-3 mt-n1" width="20" :src="flagSrc('en')">
                            <span>English</span>
                        </span>
                        <i class="fa fa-angle-right"></i>
                    </a>

                    <a @click="select('fr')">
                        <span class="lang-left">
                            <img class="me-3 mt-n1" width="20" :src="flagSrc('fr')">
                            <span>Français</span>
                        </span>
                        <i class="fa fa-angle-right"></i>
                    </a>
                </div>

                <div class="clear"></div>
            </div>
        </div>
    </div>
</template>

<script>
import { authStore } from "@/store/auth.js"

export default {
    name: "LanguageSwitcher",

    props: {
        // İstersen farklı yerde farklı başlık kullanırsın
        labelKey: { type: String, default: "pages.splash.languageSettings" },
        subtitleKey: { type: String, default: "pages.splash.selectLanguage" },

        // Flag resimleri için base path (senin kodla aynı default)
        staticBase: { type: String, default: "./static/img/" }
    },
    
    data() {
        return {
            isOpen: false
        }
    },

    computed: {
        currentLang() {
            return this.$store?.state?.lang || "tr"
        }
    },

    methods: {
        open() {
            this.isOpen = true
        },
        close() {
            this.isOpen = false
        },

        flagSrc(lang) {
            const file =
                lang === "tr" ? "Turkey.png" :
                    lang === "nl" ? "Netherlands.png" :
                    lang === "en" ? "English.png" :
                        "France.png"

            return this.staticBase + file
        },

        applyLang(code) {
            // Vuex
            this.$store.commit("CHANGE_LANGUAGE", code)

            // Persist
            try { authStore.setItem("lang", code) } catch (e) { }

            // Moment locale
            const momentLocale = { tr: "tr", nl: "nl-be", fr: "fr", en: "en" }[code] || "tr"
            try { this.moment?.locale?.(momentLocale) } catch (e) { }
        },

        select(code) {
            this.applyLang(code)
            this.close()
            this.$emit("changed", code)
        }
    }
}
</script>

<style scoped>
/* Senin mevcut class’larınla uyumlu kalsın diye minimal dokundum */
.lang-modal-backdrop {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, .35);
    z-index: 9999;
    display: grid;
    place-items: center;
    padding: 16px;
}

.lang-modal {
    width: 100%;
    max-width: 420px;
    background: #fff;
    border-radius: 14px;
    overflow: hidden;
}

.menu-title {
    position: relative;
    padding: 16px 16px 10px;
}

.close-menu {
    position: absolute;
    top: 12px;
    right: 12px;
    cursor: pointer;
}

.list-group a {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 8px;
    cursor: pointer;
}

.change-lang {
    display: block;
    right: 0.6em;
    position: absolute;
    top: 2.3em;
    border: 1px solid #4a89dc;
    padding: 0.2em 0.7em;
    border-radius: 1em;
    background-color: #4a89dc;
    color: white;
    z-index: 999;
}

.list-group a {
    display: flex;
    align-items: center;
    justify-content: space-between;
    /* ok sağda kalsın */
}

.lang-left {
    display: flex;
    align-items: center;
    gap: 12px;
    /* istersen 8px */
    min-width: 0;
}

.lang-left img {
    flex: 0 0 auto;
}

.lang-left span {
    white-space: nowrap;
}
</style>