<template>
    <span class="change-lang" :class="variant" @click="open" role="button">
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

                    <a v-for="lang in languages" :key="lang.code" @click="select(lang.code)">
                        <span class="lang-left">
                            <img class="me-3 mt-n1" width="20" :src="flagSrc(lang.code)" alt="">
                            <span>{{ lang.label }}</span>
                        </span>
                        <i v-if="lang.code === currentLang" class="fa fa-check"></i>
                        <i v-else class="fa fa-angle-right"></i>
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
        staticBase: { type: String, default: "./static/img/" },

        // "pill": absolute-positioned floating badge (splash screen). "inline": static chip for embedding in page flow (e.g. profile header)
        variant: { type: String, default: "pill" }
    },

    data() {
        return {
            isOpen: false,
            languages: [
                { code: "en", label: "English" },
                { code: "de", label: "Deutsch" },
                { code: "nl", label: "Nederlands" },
                { code: "cs", label: "Čeština" },
                { code: "pl", label: "Polski" }
            ]
        }
    },

    computed: {
        currentLang() {
            return this.$store?.state?.lang || "en"
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
            return this.staticBase + lang + ".png"
        },

        applyLang(code) {
            const changed = code !== this.currentLang

            // Vuex
            this.$store.commit("CHANGE_LANGUAGE", code)

            // Persist
            try { authStore.setItem("lang", code) } catch (e) { }

            // Moment locale
            const momentLocale = { en: "en", de: "de", nl: "nl-be", cs: "cs", pl: "pl" }[code] || "en"
            try { this.moment?.locale?.(momentLocale) } catch (e) { }

            // Module/card/simulator content is fetched once per screen and cached
            // in the store - a reload is the simplest way to make every already-
            // loaded screen refetch it in the newly selected language.
            if (changed) {
                window.location.reload()
            }
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
    display: inline-block;
    border: 1px solid #4a89dc;
    padding: 0.2em 0.7em;
    border-radius: 1em;
    background-color: #4a89dc;
    color: white;
    cursor: pointer;
}

.change-lang.pill {
    display: block;
    right: 0.6em;
    position: absolute;
    top: 2.3em;
    z-index: 999;
}

.change-lang.inline {
    position: static;
    font-size: 0.85em;
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