<template>
  <div class="partner-rail" v-if="items.length">
    <button v-for="item in items" :key="item.id" type="button" class="partner-pill" @click="onClickItem(item)"
      :title="item.story_top_text || item.image_text || ''">
      <div class="partner-avatar-wrap">
        <img :src="item._img" alt="" class="partner-avatar" referrerpolicy="no-referrer" crossorigin="anonymous"
          loading="lazy" decoding="async" @error="onImgError($event, item)" />
        <span v-if="item._badge" class="partner-badge">{{ item._badge }}</span>
      </div>

      <span class="partner-label">
        {{ item.story_top_text || item.image_text || $t('components.partnerRail.defaultLabel') }}
      </span>

      <span v-if="item.story_bottom_text" class="partner-subtitle">
        {{ item.story_bottom_text }}
      </span>
    </button>
  </div>
</template>

<script>
export default {
  name: "PartnerRail",

  computed: {
    rawItems() {
      // ✅ store’da neredeyse onu kullan
      const arr = this.$store.state.comingUps || [];
      return Array.isArray(arr) ? arr : [];
    },

    items() {
      return this.rawItems
        .map((x) => {
          const img = this.normalizeImg(x.image_url);
          return {
            ...x,
            _img: img,
            _badge: this.computeBadge(x),
          };
        })
        // en yeniler üstte istersen:
        .slice()
        .sort((a, b) => (Number(a.id) || 0) - (Number(b.id) || 0));
    },
  },

  methods: {
    normalizeImg(url) {
      if (!url) return "/static/img/add_photo.png";
      const s = String(url).trim();

      if (s.startsWith("http://") || s.startsWith("https://")) return s;

      // burada double slash olmasın diye:
      const base = String(this.$store.state.serverLocation || "").replace(/\/+$/, "");
      if (s.startsWith("/")) return base + s;

      return s;
    },

    onImgError(e, item) {
      const img = e?.target;
      if (!img) return;

      // 1 kere retry (cache bust)
      if (!img.dataset.retry) {
        img.dataset.retry = "1";
        const src = img.getAttribute("src") || "";
        const sep = src.includes("?") ? "&" : "?";
        img.src = src + sep + "cb=" + Date.now();
        return;
      }

      // fallback
      img.src = "/static/img/add_photo.png";
    },

    computeBadge(item) {
      // İstersen daha akıllı kurallar:
      // image_text “Etkinlik” ise rozet Etkinlik vs.
      const t = (item.image_text || "").toLowerCase();
      if (t.includes("etkinlik")) return this.$t('components.partnerRail.badges.event');
      if (t.includes("webshop")) return this.$t('components.partnerRail.badges.webshop');
      if (t.includes("başvur") || t.includes("basvur")) return this.$t('components.partnerRail.badges.apply');
      return item.image_text || "";
    },

    onClickItem(item) {

      if (item.fk_post_id) {
        this.$router.push({ name: "postcontainer", params: { postID: item.fk_post_id, specialPostId: item.id } })
        return
      }


      if (item.fk_business_id) {
        this.$router.push({ name: "business", params: { businessID: item.fk_business_id } });
        return;
      }

      if (item.fk_profile_id) {
        this.$router.push({ name: "profile", params: { profileID: item.fk_profile_id } });
        return;
      }

      if (item.action_url) {
        // dış link: aynı sekme istersen location, yeni sekme istersen window.open
        window.open(item.action_url, "_blank", "noopener,noreferrer");
        return;
      }

      this.$router.push({ name: "highlightrequest" });
    },
  },
};
</script>

<style scoped>
:global(body.dark-mode) .partner-rail {
  background: #111827;
  border-bottom-color: #1f2937;
}

.partner-rail {
  display: flex;
  overflow-x: auto;
  gap: 14px;
  padding: 12px 12px;
  width: 100%;
  box-sizing: border-box;

  background: #ffffff;
  border-bottom: 1px solid #e5e7eb;

  -webkit-overflow-scrolling: touch;

  /* ✅ 3 taneyi düzgün dağıt */
  justify-content: space-between;
}

.partner-pill {
  /* ✅ 3’ü eşit genişlikte */
  flex: 1 1 0;
  min-width: 0;

  /* width: 33% KALDIR */
  border: 0;
  background: transparent;
  padding: 0;
  cursor: pointer;
  text-align: center;
}

.partner-avatar-wrap {
  position: relative;
  display: inline-block;
}

.partner-avatar {
  width: 74px;
  height: 74px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #2563eb;
  box-shadow: 0 4px 10px rgba(37, 99, 235, 0.25);
  background: #f3f4f6;
}

.partner-badge {
  position: absolute;
  bottom: -4px;
  right: -6px;
  font-size: 10px;
  padding: 3px 7px;
  border-radius: 999px;
  background: #111827;
  color: #f9fafb;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.35);
}

.partner-label {
  margin-top: 7px;
  display: block;
  font-size: 0.92rem;
  font-weight: 700;
  color: #111827;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.partner-subtitle {
  margin-top: 2px;
  display: block;
  font-size: 0.78rem;
  color: #6b7280;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.partner-cta {
  margin-top: 6px;
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 6px 10px;
  border-radius: 999px;
  background: rgba(37, 99, 235, 0.1);
  color: #2563eb;
  white-space: nowrap;
}

:global(body.dark-mode) .partner-label {
  color: #e5e7eb;
}

:global(body.dark-mode) .partner-subtitle {
  color: #9ca3af;
}

:global(body.dark-mode) .partner-cta {
  background: rgba(37, 99, 235, 0.18);
  color: #93c5fd;
}

.partner-rail::-webkit-scrollbar {
  display: none;
}
</style>