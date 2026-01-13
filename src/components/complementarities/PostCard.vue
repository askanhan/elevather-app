<template>
  <div class="post-card" ref="cardEl" v-if="localPost && !isHidden">
    <!-- Header -->
    <div class="post-header">
      <div class="post-header-left" @click="goToPublisher">
        <ProfileAvatar :name="localPost.name" :photo-url="localPost.p_photo" :clickable="false" size="40" />
        <div class="post-header-meta">
          <div class="post-username">{{ localPost.name }}</div>
          <div class="post-subtitle" v-if="subtitle">{{ subtitle }}</div>
        </div>
      </div>

      <!-- üç nokta + dropdown -->
      <div class="post-more-wrapper">
        <button type="button" class="icon-btn post-more-btn" @click.stop="toggleMoreMenu">
          <i class="fas fa-ellipsis-h"></i>
        </button>

        <transition name="fade">
          <div v-if="showMoreMenu" class="post-menu" @click.stop>
            <button v-if="canDeletePost" type="button" class="post-menu-item post-menu-item--danger"
              @click="confirmDeletePost">
              <i class="fas fa-trash-alt"></i>
              <span>{{ $t('components.postCard.menu.delete') }}</span>
            </button>

            <button type="button" class="post-menu-item" @click="hidePost">
              <i class="fas fa-eye-slash"></i>
              <span>{{ $t('components.postCard.menu.hide') }}</span>
            </button>

            <button type="button" class="post-menu-item" @click="openReportSheet">
              <i class="fas fa-flag"></i>
              <span>{{ $t('components.postCard.menu.report') }}</span>
            </button>

            <button type="button" class="post-menu-item post-menu-item--cancel" @click="closeMoreMenu">
              {{ $t('components.postCard.menu.cancel') }}
            </button>
          </div>
        </transition>
      </div>
    </div>

    <!-- Media (Swipe carousel: videos first, then photos) -->
    <div class="post-media" v-if="mediaItems.length" @dblclick="handleLike">
      <div class="media-carousel" @touchstart.passive="onTouchStart" @touchmove.passive="onTouchMove"
        @touchend="onTouchEnd">
        <div class="media-track" :style="{ transform: `translateX(-${activeMediaIndex * 100}%)` }">
          <div class="media-slide" v-for="(m, i) in mediaItems" :key="m.key">
            <div class="media-frame">
              <!-- VIDEO -->
              <video v-if="m.kind === 'video'" class="post-video" playsinline muted loop :data-idx="i"
                :ref="setVideoRef" :src="fileSrc(m.src)" @click="toggleVideo(i)"></video>

              <!-- PHOTO -->
              <img v-else class="post-image" :src="photoSrc(m.src)" alt="post" draggable="false"
                @click="openMediaModal(i)" />

              <!-- butonlar frame'in içinde kalsın -->
              <button v-if="m.kind === 'video' && i === activeMediaIndex" type="button" class="extend-video-btn"
                @click.stop="openMediaModal(i)">
                <i class="fas fa-expand"></i>
              </button>

              <button v-if="m.kind === 'video' && i === activeMediaIndex" type="button" class="video-sound-btn"
                @click.stop="toggleSound(i)">
                <i :class="isMuted ? 'fas fa-volume-mute' : 'fas fa-volume-up'"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- Dots -->
        <div class="media-dots" v-if="mediaItems.length > 1">
          <span v-for="(_, i) in mediaItems" :key="'dot_' + i" class="dot" :class="{ active: i === activeMediaIndex }"
            @click.stop="setActiveMedia(i)"></span>
        </div>
      </div>
    </div>

    <!-- Event info (under media) -->
    <div v-if="isEventPost && hasEventInfo" class="event-bar">
      <div class="event-chip" v-if="eventDayLabel">
        <i class="far fa-calendar"></i>
        <span>{{ eventDayLabel }}</span>
      </div>

      <div class="event-chip" v-if="eventTimeLabel">
        <i class="far fa-clock"></i>
        <span>{{ eventTimeLabel }}</span>
      </div>

      <div class="event-chip event-chip--loc" v-if="eventLocationLabel">
        <i class="fas fa-map-marker-alt"></i>
        <span>{{ eventLocationLabel }}</span>
      </div>
    </div>

    <!-- Body -->
    <div class="post-body">
      <!-- Actions -->
      <div class="post-actions">
        <div class="post-actions-left">
          <button type="button" class="icon-btn" :class="{ 'icon-btn--active': localPost.is_liked }"
            @click="handleLike">
            <i :class="localPost.is_liked ? 'fas fa-heart' : 'far fa-heart'"></i>
          </button>

          <button type="button" class="icon-btn" @click="toggleCommentInput">
            <i class="far fa-comment"></i>
          </button>

          <button type="button" class="icon-btn" @click="sharePost">
            <i class="far fa-paper-plane"></i>
          </button>
        </div>
        <div class="post-views" v-if="viewsCount !== null">
          <i class="far fa-eye"></i>
          <span>{{ viewsLabel }}</span>
        </div>

        <button type="button" class="icon-btn" :class="{ 'icon-btn--active': localPost.is_bookmarked }"
          @click="handleBookmark">
          <i :class="localPost.is_bookmarked ? 'fas fa-bookmark' : 'far fa-bookmark'"></i>
        </button>
      </div>

      <!-- Likes -->
      <div class="post-likes" v-if="localPost.like_count">
        {{ likesLabel }}
      </div>

      <!-- Caption -->
      <div class="post-caption" v-if="localPost.description">
        <span class="post-caption-user" @click="goToPublisher">{{ localPost.name }}</span>
        <span class="post-caption-text">{{ localPost.description }}</span>
      </div>

      <!-- Poll -->
      <div v-if="isQuestionnaire" class="poll">
        <div class="poll-top">
          <div class="poll-badge">
            <i class="fas fa-chart-pie"></i>
            <span>{{ $t('components.postCard.poll.badge') }}</span>
          </div>

          <div class="poll-meta" v-if="pollTotalVotes > 0">
            {{ $t('components.postCard.poll.votes', { n: pollTotalVotes }) }}
          </div>
        </div>

        <div class="poll-options">
          <button v-for="(poolChoice, i) in pollChoices" :key="'poll_' + i" type="button" class="poll-option" :class="{
            'poll-option--disabled': pollLocked,
            'poll-option--selected': pollSelectedIndex === i,
            'poll-option--results': showPollResults
          }" @click="votePoll(i)">
            <!-- bar (results mode) -->
            <div v-if="showPollResults" class="poll-bar">
              <div class="poll-bar__fill" :style="{ width: pollPercent(i) + '%' }"></div>
            </div>

            <div class="poll-row">
              <div class="poll-label">
                <span class="poll-label__text">{{ poolChoice.choice }}</span>
                <i v-if="showPollResults && pollSelectedIndex === i" class="fas fa-check poll-check"></i>
              </div>

              <div v-if="showPollResults" class="poll-stats">
                <span class="poll-percent">{{ pollPercent(i) }}%</span>
                <span class="poll-count">{{ pollCount(i) }}</span>
              </div>
            </div>
          </button>
        </div>

        <div class="poll-footer" v-if="!showPollResults">
          {{ $t('components.postCard.poll.footer') }}
        </div>
      </div>

      <!-- Comments list -->
      <div class="post-comments" v-if="localPost.comments && localPost.comments.length">
        <div class="post-comment" v-for="c in localPost.comments" :key="c.id">
          <div class="post-comment-main">
            <span class="comment-author comment-author--clickable" @click="goToCommentAuthor(c)">
              {{ commentAuthorName(c) }}
            </span>
            <span class="comment-text">{{ c.comment || c.text }}</span>
          </div>

          <button v-if="canDeleteComment(c)" type="button" class="comment-delete-btn" @click="deleteComment(c)">
            <i class="fas fa-trash-alt"></i>
          </button>
        </div>
      </div>

      <!-- Comment input -->
      <div class="post-comment-input" v-if="showCommentInput">
        <input type="text" v-model="newCommentText" class="comment-input"
          :placeholder="$t('components.postCard.comments.placeholder')" @keyup.enter="submitComment" />
        <button type="button" class="comment-send-btn" :disabled="!newCommentText.trim() || isCommentSending"
          @click="submitComment">
          {{ $t('components.postCard.comments.send') }}
        </button>
      </div>

      <!-- Meta (tarih) -->
      <div class="post-meta" v-if="localPost.post_date">
        {{ formattedDate }}
      </div>
    </div>

    <!-- ŞİKAYET SHEET -->
    <div v-if="showReportSheet" class="report-sheet-overlay" @click="closeReportSheet">
      <div class="report-sheet" @click.stop>
        <div class="report-title">{{ $t('components.postCard.report.title') }}</div>
        <div class="report-subtitle">{{ $t('components.postCard.report.subtitle') }}</div>

        <button v-for="r in reportReasons" :key="r.id" type="button" class="report-option" @click="submitReport(r)">
          {{ $t(r.key) }}
        </button>

        <button type="button" class="report-cancel" @click="closeReportSheet">{{ $t('components.postCard.report.cancel')
        }}</button>
      </div>
    </div>
  </div>
  <!-- MEDIA MODAL -->
  <transition name="mediafade">
    <div v-if="showMediaModal" class="media-modal" @click="closeMediaModal">
      <div class="media-modal__inner" @click.stop>
        <button type="button" class="media-modal__close" @click="closeMediaModal" aria-label="Kapat">
          <i class="fas fa-times"></i>
        </button>

        <div class="media-modal__carousel" @touchstart.passive="onModalTouchStart" @touchmove.passive="onModalTouchMove"
          @touchend="onModalTouchEnd">
          <div class="media-modal__track" :style="{ transform: `translateX(-${modalMediaIndex * 100}%)` }">
            <div class="media-modal__slide" v-for="(m, idx) in mediaItems" :key="'m_' + m.key">
              <!-- VIDEO -->
              <video v-if="m.kind === 'video'" class="media-modal__video" controls playsinline
                :src="fileSrc(m.src)"></video>

              <!-- PHOTO -->
              <img v-else class="media-modal__img" :src="photoSrc(m.src)" alt="media" draggable="false" />
            </div>
          </div>

          <div class="media-modal__dots" v-if="mediaItems.length > 1">
            <span v-for="(_, d) in mediaItems" :key="'md_' + d" class="dot" :class="{ active: d === modalMediaIndex }"
              @click.stop="setModalMedia(d)"></span>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import ProfileAvatar from "@/components/complementarities/ProfileAvatar.vue";
import { authStore } from "@/store/auth.js";

export default {
  name: "PostCard",
  components: { ProfileAvatar },

  props: {
    post: { type: Object, required: true },
  },

  data() {
    return {
      localPost: null,

      pollSelectedIndex: null,
      pollIsVoting: false,
      pollLocalAnswers: null, // optimistic + fallback

      showMediaModal: false,
      modalMediaIndex: 0,
      modalTouchStartX: 0,
      modalTouchDeltaX: 0,

      // media carousel
      activeMediaIndex: 0,
      touchStartX: 0,
      touchDeltaX: 0,

      // video
      isMuted: true,
      observer: null,
      isInView: false,
      userPaused: false,
      hasSentView: false,
      videoEls: [],

      // comments & actions
      showCommentInput: true,
      newCommentText: "",
      isLikeLoading: false,
      isBookmarkLoading: false,
      isCommentSending: false,

      // menu & report
      showMoreMenu: false,
      showReportSheet: false,
      reportReasons: [
        { id: 1, key: "components.postCard.report.reasons.spam" },
        { id: 2, key: "components.postCard.report.reasons.inappropriate" },
        { id: 3, key: "components.postCard.report.reasons.violence" },
        { id: 4, key: "components.postCard.report.reasons.misleading" },
        { id: 5, key: "components.postCard.report.reasons.other" },
      ],

      // hide
      isHidden: false,
    };
  },

  created() {
    this.syncFromProp(this.post);
    this.checkHiddenState();
  },

  watch: {
    post: {
      handler(newVal) {
        this.syncFromProp(newVal);
        this.checkHiddenState();
        this.activeMediaIndex = 0;
        this.$nextTick(() => this.playActiveVideoIfNeeded());
      },
      deep: false,
    },
    activeMediaIndex() {
      // slide değişince video kontrol
      this.$nextTick(() => this.playActiveVideoIfNeeded(true));
    },
  },

  mounted() {
    this.initObserver();
    document.addEventListener("click", this.handleDocumentClick);

    this.$nextTick(() => {
      this.collectVideoEls();
      this.applyMutedToAll();
      this.playActiveVideoIfNeeded(true);
    });
  },

  unmounted() {
    this.teardownObserver();
    document.removeEventListener("click", this.handleDocumentClick);
  },

  computed: {

    viewsCount() {
      const v = this.localPost?.nofviews;
      if (v === null || v === undefined) return null;
      const n = Number(v);
      return Number.isFinite(n) ? n : null;
    },
    viewsLabel() {
      const n = this.viewsCount;
      if (n === null) return "";
      return this.$t('components.postCard.views', { n: n });
    },

    deleteBlocked() {
      const likes = Number(this.localPost?.like_count || 0);
      const cc = Number(this.localPost?.comment_count || 0);
      const cl = Number(this.localPost?.comments?.length || 0);
      return (likes > 0) || (cc > 0) || (cl > 0);
    },

    isQuestionnaire() {
      return !!(this.localPost?.is_questionnaire && Array.isArray(this.localPost?.choices) && this.localPost.choices.length);
    },

    pollChoices() {
      const c = this.localPost?.choices;
      return Array.isArray(c) ? c : [];
    },

    // answers formatı ya [3,1,0] ya da [{votes:3}, ...] gelebilir diye tolerant davranalım
    pollAnswers() {
      const a = this.pollLocalAnswers ?? this.localPost?.answers ?? this.localPost?.poll_answers ?? null;
      if (!a) return [];
      if (Array.isArray(a) && typeof a[0] === "number") return a;
      if (Array.isArray(a) && typeof a[0] === "object") {
        return a.map(x => Number(x?.votes ?? x?.count ?? 0) || 0);
      }
      return [];
    },

    pollTotalVotes() {
      const arr = this.pollAnswers;
      if (!arr?.length) return 0;
      return arr.reduce((sum, n) => sum + (Number(n) || 0), 0);
    },

    showPollResults() {
      // answers geldiyse veya user vote yaptıysa sonuç göster
      return this.pollTotalVotes > 0 || this.pollSelectedIndex !== null;
    },

    pollLocked() {
      // istersen “sonuç açıldıktan sonra tekrar oy verme” gibi kilitle
      return this.pollIsVoting || this.pollSelectedIndex !== null;
    },

    currentProfile() {
      return this.$store.state.myProfile || null;
    },
    currentProfileId() {
      const p = this.currentProfile;
      return p?.id || p?.p_id || null;
    },
    myBusinesses() {
      return this.$store.state.myBusinesses || [];
    },

    // ---- MEDIA ITEMS: videos first, then photos
    mediaItems() {
      const v = Array.isArray(this.localPost?.videos) ? this.localPost.videos : [];
      const p = Array.isArray(this.localPost?.photos) ? this.localPost.photos : [];

      const videos = v.map((src, i) => ({ kind: "video", src, key: `v_${i}_${src}` }));
      const photos = p.map((src, i) => ({ kind: "photo", src, key: `p_${i}_${src}` }));
      return [...videos, ...photos];
    },

    likesLabel() {
      if (!this.localPost?.like_count) return "";
      return this.$t('components.postCard.likes', { n: this.localPost.like_count });
    },

    formattedDate() {
      if (!this.localPost?.post_date) return "";
      try {
        const d = new Date(this.localPost.post_date);
        return d.toLocaleDateString("tr-TR", { day: "2-digit", month: "short" });
      } catch (e) {
        return "";
      }
    },

    subtitle() {
      return this.formattedDate;
    },

    canDeletePost() {
      if (!this.localPost) return false;
      const ownerProfileId = this.localPost.fk_profile_id;
      const ownerBusinessId = this.localPost.fk_business_id;

      if (this.currentProfileId && ownerProfileId === this.currentProfileId) return true;
      if (ownerBusinessId && this.myBusinesses.length) return this.myBusinesses.some((b) => b.id === ownerBusinessId);
      return false;
    },

    // ---- EVENT
    isEventPost() {
      return String(this.localPost?.category) === "1";
    },
    eventFromDate() {
      return this.localPost?.event?.from_date || null;
    },
    eventUntilDate() {
      return this.localPost?.event?.until_date || null;
    },
    eventStartTime() {
      return this.localPost?.event?.start_time || null;
    },
    eventEndTime() {
      return this.localPost?.event?.end_time || null;
    },
    eventLocationLabel() {
      const raw = this.localPost?.event?.location;
      return raw ? String(raw).trim() : "";
    },
    eventDayLabel() {
      const a = this.formatDatePretty(this.eventFromDate);
      const b = this.formatDatePretty(this.eventUntilDate);

      if (a && b && a !== b) return `${a} • ${b}`;
      if (a) return a;
      if (b) return b;
      return "";
    },
    eventTimeLabel() {
      const a = this.formatTimePretty(this.eventStartTime);
      const b = this.formatTimePretty(this.eventEndTime);

      if (a && b) return `${a} - ${b}`;
      if (a) return a;
      if (b) return b;
      return "";
    },
    hasEventInfo() {
      return !!(this.eventDayLabel || this.eventTimeLabel || this.eventLocationLabel);
    },
  },

  methods: {

    goToCommentAuthor(c) {
      const id = c?.fk_profile_id || c?.profile_id || c?.author_id || c?.user_id;
      if (!id) return;
      this.$router.push({ name: "profile", params: { profileID: id } });
    },

    pollCount(i) {
      const arr = this.pollAnswers;
      return Number(arr?.[i] ?? 0) || 0;
    },

    pollPercent(i) {
      const total = this.pollTotalVotes;
      if (!total) return 0;
      const pct = Math.round((this.pollCount(i) / total) * 100);
      return Math.max(0, Math.min(100, pct));
    },

    async votePoll(i) {
      if (!this.isQuestionnaire) return;
      if (this.pollLocked) return;
      if (i < 0 || i >= this.pollChoices.length) return;

      this.pollIsVoting = true;

      // optimistic answers oluştur / kopyala
      const prevLocalSelected = this.pollSelectedIndex;
      const prevLocalAnswers = this.pollLocalAnswers ? [...this.pollLocalAnswers] : null;

      const base = this.pollAnswers.length
        ? [...this.pollAnswers]
        : new Array(this.pollChoices.length).fill(0);

      base[i] = (Number(base[i]) || 0) + 1;

      this.pollLocalAnswers = base;
      this.pollSelectedIndex = i;

      try {
        // Burayı backend aksiyonuna bağlarsın:
        // payload: postId + selected index (ya da choice id)
        await this.$store.dispatch("votePostPoll", {
          postId: this.localPost.id,
          choice_id: this.pollChoices[i]?.id ?? null,
        });

        // İstersen: backend cevap dönünce localPost.answers'ı güncelle
        // (dispatch cevabına göre)
      } catch (e) {
        // rollback
        this.pollSelectedIndex = prevLocalSelected;
        this.pollLocalAnswers = prevLocalAnswers;
        console.error("vote poll failed", e);
        this.$message?.error?.("Oy verilemedi. Tekrar dene.");
      } finally {
        this.pollIsVoting = false;
      }
    },


    openMediaModal(i) {
      this.modalMediaIndex = typeof i === "number" ? i : this.activeMediaIndex;
      this.showMediaModal = true;

      // arkadaki feed videoları dursun
      this.pauseAllVideos();

      // body scroll kilitle (mobilde güzel his)
      document.body.style.overflow = "hidden";
    },

    closeMediaModal() {
      this.showMediaModal = false;
      document.body.style.overflow = "";
    },

    setModalMedia(i) {
      const max = this.mediaItems.length - 1;
      this.modalMediaIndex = Math.max(0, Math.min(max, i));
    },

    onModalTouchStart(e) {
      if (!e?.touches?.length) return;
      this.modalTouchStartX = e.touches[0].clientX;
      this.modalTouchDeltaX = 0;
    },
    onModalTouchMove(e) {
      if (!e?.touches?.length) return;
      this.modalTouchDeltaX = e.touches[0].clientX - this.modalTouchStartX;
    },
    onModalTouchEnd() {
      if (this.mediaItems.length <= 1) return;

      const threshold = 40;
      if (this.modalTouchDeltaX > threshold) this.setModalMedia(this.modalMediaIndex - 1);
      else if (this.modalTouchDeltaX < -threshold) this.setModalMedia(this.modalMediaIndex + 1);

      this.modalTouchStartX = 0;
      this.modalTouchDeltaX = 0;
    },
    /* === prop -> local state === */
    syncFromProp(src) {
      if (!src) {
        this.localPost = null;
        return;
      }
      const clone = { ...src };
      clone.comments = Array.isArray(src.comments) ? [...src.comments] : [];
      this.localPost = clone;
    },

    /* === hide (authStore) === */
    async checkHiddenState() {
      if (!this.post?.id) return;
      try {
        const list = (await authStore.getItem("hidden_posts")) || [];
        this.isHidden = list.includes(this.post.id);
      } catch (e) {
        console.error("hidden_posts read failed", e);
      }
    },

    async hidePost() {
      if (!this.localPost?.id) return;

      const ok = window.confirm(
        this.$t('components.postCard.hideConfirm')
      );
      if (!ok) {
        this.closeMoreMenu();
        return;
      }

      this.isHidden = true;
      this.closeMoreMenu();

      try {
        const key = "hidden_posts";
        const raw = await authStore.getItem(key);
        const list = Array.isArray(raw) ? raw : [];

        if (!list.includes(this.localPost.id)) {
          list.push(this.localPost.id);
          await authStore.setItem(key, list);
        }
      } catch (e) {
        console.error("hidden_posts write failed", e);
      }
    },

    /* === viewport / autoplay / view === */
    initObserver() {
      if (!("IntersectionObserver" in window)) return;
      const target = this.$refs.cardEl;
      if (!target) return;

      this.observer = new IntersectionObserver(
        (entries) => {
          const entry = entries[0];
          const inView = entry.isIntersecting && entry.intersectionRatio >= 0.6;
          this.isInView = inView;

          // only active video plays
          if (this.isInView && !this.userPaused) this.playActiveVideoIfNeeded(true);
          else this.pauseAllVideos();

          if (this.isInView && !this.hasSentView) {
            this.hasSentView = true;
            this.sendViewEvent();
          }
        },
        { threshold: [0.0, 0.6, 1.0] }
      );

      this.observer.observe(target);
    },

    teardownObserver() {
      if (this.observer && this.$refs.cardEl) {
        this.observer.unobserve(this.$refs.cardEl);
        this.observer.disconnect();
        this.observer = null;
      }
    },

    sendViewEvent() {
      if (!this.localPost?.id) return;
      this.$store.dispatch("markPostViewed", this.localPost.id).catch((err) => console.error("view dispatch failed", err));
    },

    /* === media helpers === */
    photoSrc(p) {
      if (!p) return "";
      if (typeof p === "string" && p.startsWith("http")) return p;
      return this.$store.state.serverLocation + p;
    },
    fileSrc(p) {
      if (!p) return "";
      if (typeof p === "string" && p.startsWith("http")) return p;
      return this.$store.state.serverLocation + p;
    },

    // refs for multiple videos
    setVideoRef(el) {
      // Vue, mount/unmount sırasında null da gönderir => filtrele
      if (!el) return;
      // aynı elementi iki kez eklemeyelim
      if (!this.videoEls.includes(el)) this.videoEls.push(el);
    },
    collectVideoEls() {
      // template ref fonksiyonuyla zaten doluyor; burada sadece temizlik
      this.videoEls = (this.videoEls || []).filter(Boolean);
    },
    applyMutedToAll() {
      for (const v of this.videoEls) {
        v.muted = this.isMuted;
      }
    },
    pauseAllVideos() {
      for (const v of this.videoEls) {
        v.pause?.();
      }
    },
    getActiveVideoEl() {
      // aktif slide video mu?
      const item = this.mediaItems[this.activeMediaIndex];
      if (!item || item.kind !== "video") return null;

      // data-idx ile bul
      for (const v of this.videoEls) {
        if (String(v?.dataset?.idx) === String(this.activeMediaIndex)) return v;
      }
      return null;
    },
    playActiveVideoIfNeeded(force = false) {
      // görünür değilse hiç uğraşma
      if (!this.isInView && !force) return;

      this.collectVideoEls();
      this.applyMutedToAll();

      // diğer videoları kapat
      for (const v of this.videoEls) {
        if (String(v?.dataset?.idx) !== String(this.activeMediaIndex)) v.pause?.();
      }

      const activeV = this.getActiveVideoEl();
      if (!activeV) return;

      if (!this.userPaused) {
        activeV.play?.().catch(() => { });
      }
    },

    /* === swipe controls === */
    onTouchStart(e) {
      if (!e?.touches?.length) return;
      this.touchStartX = e.touches[0].clientX;
      this.touchDeltaX = 0;
    },
    onTouchMove(e) {
      if (!e?.touches?.length) return;
      this.touchDeltaX = e.touches[0].clientX - this.touchStartX;
    },
    onTouchEnd() {
      if (this.mediaItems.length <= 1) return;

      const threshold = 40; // px
      if (this.touchDeltaX > threshold) {
        this.setActiveMedia(this.activeMediaIndex - 1);
      } else if (this.touchDeltaX < -threshold) {
        this.setActiveMedia(this.activeMediaIndex + 1);
      }
      this.touchStartX = 0;
      this.touchDeltaX = 0;
    },
    setActiveMedia(i) {
      const max = this.mediaItems.length - 1;
      const next = Math.max(0, Math.min(max, i));
      if (next === this.activeMediaIndex) return;
      this.activeMediaIndex = next;
    },

    /* === video interactions === */
    toggleVideo(idx) {
      // sadece aktif slide’da tıklanınca toggle
      if (idx !== this.activeMediaIndex) return;

      const v = this.getActiveVideoEl();
      if (!v) return;

      if (v.paused) {
        v.play().catch(() => { });
        this.userPaused = false;
      } else {
        v.pause();
        this.userPaused = true;
      }
    },

    toggleSound(idx) {
      if (idx !== this.activeMediaIndex) return;

      const v = this.getActiveVideoEl();
      if (!v) return;

      this.isMuted = !this.isMuted;
      this.applyMutedToAll();

      if (!this.isMuted && v.paused) {
        v.play().catch(() => { });
        this.userPaused = false;
      }
    },

    /* === like / bookmark === */
    async handleLike() {
      if (!this.localPost?.id || this.isLikeLoading) return;
      this.isLikeLoading = true;

      const prevLiked = !!this.localPost.is_liked;
      const prevCount = this.localPost.like_count || 0;

      this.localPost.is_liked = !prevLiked;
      this.localPost.like_count = prevLiked ? Math.max(0, prevCount - 1) : prevCount + 1;

      try {
        await this.$store.dispatch("togglePostLike", { id: this.localPost.id });
      } catch (e) {
        this.localPost.is_liked = prevLiked;
        this.localPost.like_count = prevCount;
        console.error("toggle like failed", e);
      } finally {
        this.isLikeLoading = false;
      }
    },

    async handleBookmark() {
      if (!this.localPost?.id || this.isBookmarkLoading) return;
      this.isBookmarkLoading = true;

      const prev = !!this.localPost.is_bookmarked;
      this.localPost.is_bookmarked = !prev;

      try {
        await this.$store.dispatch("togglePostBookmark", { id: this.localPost.id });
      } catch (e) {
        this.localPost.is_bookmarked = prev;
        console.error("toggle bookmark failed", e);
      } finally {
        this.isBookmarkLoading = false;
      }
    },

    /* === comments === */
    toggleCommentInput() {
      if (this.showCommentInput) {
        this.$nextTick(() => {
          const el = this.$el.querySelector(".comment-input");
          el && el.focus();
        });
      }
    },

    commentAuthorName(c) {
      return c.author_name || c.profile_name || c.username || c.name || "Kullanıcı";
    },

    canDeleteComment(c) {
      if (!this.currentProfileId || !c) return false;
      const ownerId = c.fk_profile_id || c.profile_id || c.author_id || c.user_id;
      return ownerId && ownerId === this.currentProfileId;
    },

    async submitComment() {
      const text = this.newCommentText.trim();
      if (!text || !this.localPost?.id || this.isCommentSending) return;

      this.isCommentSending = true;
      try {
        const created = await this.$store.dispatch("createPostComment", {
          postId: this.localPost.id,
          text,
        });

        if (!this.localPost.comments) this.localPost.comments = [];

        if (created) {
          const normalized = {
            id: created.id,
            comment: created.comment || created.text || text,
            fk_profile_id: created.fk_profile_id || this.currentProfileId,
            author_name:
              created.author_name ||
              created.profile_name ||
              this.currentProfile?.username ||
              this.currentProfile?.p_username ||
              "Sen",
          };
          this.localPost.comments.push(normalized);
        } else {
          this.localPost.comments.push({
            id: Date.now(),
            comment: text,
            fk_profile_id: this.currentProfileId,
            author_name: this.currentProfile?.username || this.currentProfile?.p_username || "Sen",
          });
        }

        this.newCommentText = "";
      } catch (e) {
        console.error("create comment failed", e);
      } finally {
        this.isCommentSending = false;
      }
    },

    async deleteComment(c) {
      if (!c?.id) return;
      const confirmDel = window.confirm("Yorumu silmek istiyor musun?");
      if (!confirmDel) return;

      const prev = [...(this.localPost.comments || [])];
      this.localPost.comments = this.localPost.comments.filter((x) => x.id !== c.id);

      try {
        await this.$store.dispatch("deletePostComment", c.id);
      } catch (e) {
        console.error("delete comment failed", e);
        this.localPost.comments = prev;
      }
    },

    /* === share === */
    /* === share === */
    async sharePost() {
      if (!this.localPost?.id) return

      const id = this.localPost.id

      // Paylaşılacak TEK şey: web url
      const url = `https://burada.be/app/post/${id}`

      // Sadece title
      const title = (this.localPost.name || "Burada").toString().trim()

      try {
        // Capacitor Share varsa onu kullan
        if (window.Capacitor?.Plugins?.Share) {
          await window.Capacitor.Plugins.Share.share({
            title,
            url,     // ✅ sadece url
            // text koyma -> WhatsApp/Notes içine ekstra şey basmasın
          })
          return
        }

        // Web share API fallback
        if (navigator.share) {
          await navigator.share({ title, url })
          return
        }

        // Clipboard fallback
        if (navigator.clipboard) {
          await navigator.clipboard.writeText(url)
          this.$message?.success?.("Link panoya kopyalandı")
        } else {
          window.prompt("Kopyala:", url)
        }
      } catch (e) {
        console.error("share failed", e)
      }
    },

    /* === üç nokta menüsü / report === */
    toggleMoreMenu() {
      this.showMoreMenu = !this.showMoreMenu;
    },
    closeMoreMenu() {
      this.showMoreMenu = false;
    },
    handleDocumentClick(e) {
      if (!this.$el.contains(e.target)) this.showMoreMenu = false;
    },
    openReportSheet() {
      this.showReportSheet = true;
    },
    closeReportSheet() {
      this.showReportSheet = false;
    },

    confirmDeletePost() {
      if (!this.localPost?.id) return;

      if (this.deleteBlocked) {
        this.$message?.error?.("Beğeni veya yorum alan gönderiler silinemez.");
        if (!this.$message?.error) window.alert("Beğeni veya yorum alan gönderiler silinemez.");
        this.closeMoreMenu();
        return;
      }

      const ok = window.confirm("Bu gönderiyi silmek istiyor musun?");
      if (!ok) return;

      this.$store.dispatch("deletePost", this.localPost.id);
      this.$message?.success?.("Gönderiniz silindi");
      this.$store.commit("DELETE_POST", this.localPost.id);
      this.closeMoreMenu();
    },

    submitReport(reason) {
      this.$store.dispatch("reportPost", { post: this.localPost, reason: reason.id });
      this.$message?.success?.("Gönderi şikayetiniz alındı");
      this.showReportSheet = false;
      this.showMoreMenu = false;
    },

    /* === navigation === */
    goToPublisher() {
      const p = this.localPost;
      if (!p) return;

      if (p.link) {
        this.$router.push(p.link);
        return;
      }
      if (p.fk_business_id) {
        this.$router.push({ name: "business", params: { businessID: p.fk_business_id } });
        return;
      }
      if (p.fk_profile_id) {
        this.$router.push({ name: "profile", params: { profileID: p.fk_profile_id } });
      }
    },

    /* === event formatting === */
    formatDatePretty(s) {
      if (!s) return "";
      try {
        // accepts "YYYY-MM-DD"
        const d = new Date(s);
        if (isNaN(d.getTime())) return String(s);
        return d.toLocaleDateString("tr-TR", { day: "2-digit", month: "short" });
      } catch {
        return String(s);
      }
    },
    formatTimePretty(s) {
      if (!s) return "";
      // already "HH:mm" keep it
      return String(s).slice(0, 5);
    },
  },
};
</script>

<style scoped>
.post-card {
  position: relative;
  background: #ffffff;
  border-radius: 16px;
  overflow: hidden;
  margin-bottom: 16px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
}

/* Header */
.post-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 12px 6px;
}

.post-header-left {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.post-header-meta {
  display: flex;
  flex-direction: column;
}

.post-username {
  font-weight: 600;
  font-size: 14px;
  color: #111827;
}

.post-subtitle {
  font-size: 11px;
  color: #9ca3af;
}

/* Media */
.post-media {
  background: #000;
}

.media-carousel {
  position: relative;
  width: 100%;
  overflow: hidden;
  background: #000;
  touch-action: pan-y;
}

.media-track {
  display: flex;
  width: 100%;
  transition: transform 0.22s ease-out;
}

.media-slide {
  flex: 0 0 100%;
  width: 100%;
  background: #000;
}

/* FEED FRAME: instagram hissi */
.media-frame {
  width: 100%;
  aspect-ratio: 4 / 5;
  /* feed için en iyi genel oran */
  background: #000;
  overflow: hidden;
  position: relative;
}

/* asıl kritik: video ve image frame'i doldursun */
.post-image,
.post-video {
  width: 100%;
  height: 100%;
  display: block;
  background: #000;
  object-position: center;
  object-fit: cover;
  /* feed’de varsayılan: boşluk yok */
}

/* eski max-height'leri kaldır veya etkisizleştir */
.post-image {
  max-height: none;
}

.post-video {
  max-height: none;
}

.post-video-wrapper {
  display: none;
}

/* artık gerek yok, kullandıysan sil */



.post-video-wrapper {
  position: relative;
  background: #000;
}

/* Sound button */
.extend-video-btn {
  position: absolute;
  right: 6px;
  bottom: 8px;
  width: 32px;
  height: 32px;
  border-radius: 999px;
  border: none;
  background: rgba(0, 0, 0, 0.65);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 15px;
}

/* Sound button */
.video-sound-btn {
  position: absolute;
  right: 36px;
  bottom: 8px;
  width: 32px;
  height: 32px;
  border-radius: 999px;
  border: none;
  background: rgba(0, 0, 0, 0.65);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 15px;
}

.video-sound-btn:active {
  transform: scale(0.94);
}

/* Dots */
.media-dots {
  position: absolute;
  left: 50%;
  bottom: 10px;
  transform: translateX(-50%);
  display: flex;
  gap: 6px;
  padding: 6px 8px;
  border-radius: 999px;
  background: rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(6px);
}

.dot {
  width: 6px;
  height: 6px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.35);
}

.dot.active {
  background: rgba(255, 255, 255, 0.95);
}

/* Event bar (under media) */
.event-bar {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 10px 12px 0;
  background: #fff;
}

.event-chip {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 7px 10px;
  border-radius: 999px;
  border: 1px solid #eef2f7;
  background: #f8fafc;
  color: #0f172a;
  font-size: 12px;
  font-weight: 600;
  line-height: 1;
}

.event-chip i {
  font-size: 12px;
  opacity: 0.9;
}

.event-chip--loc {
  max-width: 100%;
}

.event-chip--loc span {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 260px;
}

/* Body */
.post-body {
  padding: 8px 12px 10px;
}

/* Actions */
.post-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 4px;
}

.post-actions-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.icon-btn {
  border: none;
  background: transparent;
  padding: 4px;
  cursor: pointer;
  font-size: 20px;
  color: #111827;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.icon-btn--active {
  color: #ef4444;
}

.icon-btn:active {
  transform: scale(0.94);
}

.post-more-btn {
  font-size: 18px;
}

/* Likes */
.post-likes {
  font-weight: 600;
  font-size: 13px;
  margin-bottom: 4px;
}

/* Caption */
.post-caption {
  font-size: 13px;
  line-height: 1.5;
  color: #111827;
  margin-bottom: 4px;
}

.post-caption-user {
  font-weight: 600;
  margin-right: 4px;
  cursor: pointer;
}

.post-caption-text {
  white-space: pre-wrap;
}

/* Comments */
.post-comments {
  margin-bottom: 4px;
}

.post-comment {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 6px;
  margin-bottom: 2px;
}

.post-comment-main {
  font-size: 13px;
  line-height: 1.4;
  color: #111827;
}

.comment-author {
  font-weight: 600;
  margin-right: 4px;
}

.comment-text {
  white-space: pre-wrap;
}

.comment-delete-btn {
  border: none;
  background: transparent;
  color: #9ca3af;
  cursor: pointer;
  padding: 2px 4px;
  font-size: 13px;
}

/* Comment input */
.post-comment-input {
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 4px 0;
}

.comment-input {
  flex: 1;
  border-radius: 999px;
  border: 1px solid #e5e7eb;
  padding: 6px 10px;
  font-size: 13px;
  outline: none;
}

.comment-input:focus {
  border-color: #2563eb;
  box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.15);
}

.comment-send-btn {
  border-radius: 999px;
  border: none;
  background: #2563eb;
  color: #fff;
  font-size: 12px;
  font-weight: 600;
  padding: 6px 10px;
  cursor: pointer;
}

.comment-send-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* Meta */
.post-meta {
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  color: #9ca3af;
  margin-top: 2px;
}

/* === üç nokta menüsü (dropdown) === */
.post-more-wrapper {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

/* Küçük fade animasyonu */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.15s ease-out, transform 0.15s ease-out;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(-4px);
}

/* Menü kutusu */
.post-menu {
  position: absolute;
  top: 32px;
  right: 0;
  min-width: 190px;
  background: #ffffff;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(15, 23, 42, 0.18);
  padding: 6px 0;
  z-index: 2000;
}

.post-menu-item {
  width: 100%;
  border: none;
  background: transparent;
  padding: 8px 12px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #111827;
  cursor: pointer;
  text-align: left;
}

.post-menu-item i {
  font-size: 14px;
}

.post-menu-item:hover {
  background: #f3f4f6;
}

.post-menu-item--danger {
  color: #dc2626;
}

.post-menu-item--cancel {
  justify-content: center;
  font-weight: 600;
}

/* === report sheet (alttan çıkan) === */
.report-sheet-overlay {
  position: fixed;
  inset: 0;
  background: rgba(15, 23, 42, 0.35);
  display: flex;
  justify-content: center;
  align-items: flex-end;
  z-index: 2100;
}

.report-sheet {
  width: 100%;
  max-width: 480px;
  background: #ffffff;
  border-radius: 16px 16px 0 0;
  padding: 12px 16px 16px;
  box-shadow: 0 -10px 30px rgba(15, 23, 42, 0.35);
}

.report-title {
  font-weight: 700;
  font-size: 15px;
  margin-bottom: 4px;
  color: #0f172a;
}

.report-subtitle {
  font-size: 12px;
  color: #6b7280;
  margin-bottom: 8px;
}

.report-option {
  width: 100%;
  border: none;
  background: #f3f4f6;
  border-radius: 10px;
  padding: 8px 10px;
  text-align: left;
  font-size: 13px;
  margin-bottom: 6px;
  cursor: pointer;
}

.report-option:hover {
  background: #e5e7eb;
}

.report-cancel {
  width: 100%;
  border: none;
  background: transparent;
  padding: 8px 0 0;
  font-size: 13px;
  font-weight: 600;
  color: #111827;
  cursor: pointer;
}


/* ===== Media Modal (fullscreen) ===== */
.mediafade-enter-active,
.mediafade-leave-active {
  transition: opacity 0.18s ease;
}

.mediafade-enter-from,
.mediafade-leave-to {
  opacity: 0;
}

.media-modal {
  position: fixed;
  inset: 0;
  z-index: 5000;
  background: rgba(0, 0, 0, 0.92);
  display: flex;
  align-items: center;
  justify-content: center;
}

.media-modal__inner {
  position: relative;
  width: 100%;
  height: 100%;
}

.media-modal__close {
  position: absolute;
  top: 12px;
  right: 12px;
  width: 40px;
  height: 40px;
  border-radius: 999px;
  border: none;
  background: rgba(255, 255, 255, 0.12);
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  z-index: 10;
}

.media-modal__carousel {
  width: 100%;
  height: 100%;
  overflow: hidden;
  touch-action: pan-y;
}

.media-modal__track {
  height: 100%;
  display: flex;
  transition: transform 0.22s ease-out;
}

.media-modal__slide {
  flex: 0 0 100%;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 52px 12px 22px;
  /* üstte close için yer */
  box-sizing: border-box;
}

.media-modal__img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.media-modal__video {
  width: 100%;
  height: 100%;
  object-fit: contain;
  background: #000;
}

.media-modal__dots {
  position: absolute;
  left: 50%;
  bottom: 16px;
  transform: translateX(-50%);
  display: flex;
  gap: 6px;
  padding: 6px 8px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(6px);
}

/* ===== Poll ===== */
.poll {
  margin-top: 10px;
  border: 1px solid #eef2f7;
  background: linear-gradient(180deg, #ffffff, #fbfdff);
  border-radius: 14px;
  padding: 10px;
  box-shadow: 0 8px 18px rgba(15, 23, 42, 0.04);
}

.poll-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.poll-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 10px;
  border-radius: 999px;
  background: #f1f5f9;
  color: #0f172a;
  font-size: 12px;
  font-weight: 700;
}

.poll-meta {
  font-size: 12px;
  color: #64748b;
  font-weight: 600;
}

.poll-options {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.poll-option {
  width: 100%;
  border: 1px solid #e5e7eb;
  background: #ffffff;
  border-radius: 12px;
  padding: 10px 10px;
  text-align: left;
  position: relative;
  overflow: hidden;
  cursor: pointer;
  transform: translateZ(0);
  transition: transform 0.12s ease, border-color 0.12s ease, box-shadow 0.12s ease;
}

.poll-option:active {
  transform: scale(0.99);
}

.poll-option:hover {
  border-color: #cbd5e1;
  box-shadow: 0 10px 20px rgba(15, 23, 42, 0.06);
}

.poll-option--disabled {
  cursor: default;
}

.poll-row {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.poll-label {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.poll-label__text {
  font-size: 13px;
  font-weight: 700;
  color: #0f172a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.poll-check {
  font-size: 12px;
  color: #16a34a;
}

.poll-stats {
  display: inline-flex;
  align-items: baseline;
  gap: 10px;
  flex-shrink: 0;
  font-variant-numeric: tabular-nums;
}

.poll-percent {
  font-size: 12px;
  font-weight: 800;
  color: #0f172a;
}

.poll-count {
  font-size: 12px;
  color: #64748b;
  font-weight: 700;
}

/* results bar */
.poll-bar {
  position: absolute;
  inset: 0;
  z-index: 1;
  background: #ffffff;
}

.poll-bar__fill {
  position: absolute;
  inset: 0 auto 0 0;
  width: 0%;
  background: linear-gradient(90deg, rgba(37, 99, 235, 0.18), rgba(37, 99, 235, 0.06));
  transition: width 420ms cubic-bezier(0.2, 0.9, 0.2, 1);
}

.poll-option--selected {
  border-color: rgba(37, 99, 235, 0.45);
}

/* small helper text */
.poll-footer {
  margin-top: 8px;
  font-size: 12px;
  color: #64748b;
  font-weight: 600;
}

.post-menu-item--disabled {
  opacity: 0.55;
  cursor: not-allowed;
}

.post-views {
  display: -webkit-inline-box;
    display: -ms-inline-flexbox;
    display: inline-flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    gap: 6px;
    padding: 0px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    /* background: #f8fafc; */
    color: #0f172a;
    font-size: 11px;
    font-weight: 800;
    margin: 6px 0 4px;
}

.post-views i {
  opacity: 0.85;
}

.comment-author--clickable {
  cursor: pointer;
}

.comment-author--clickable:hover {
  text-decoration: underline;
}

/* === TEXT BOOST (layout bozmadan) === */

/* İsim ve tarih biraz daha net */
.post-username {
  font-weight: 700;
  letter-spacing: 0.01em;
}

.post-subtitle {
  color: #6b7280; /* biraz daha koyu */
  font-weight: 600;
}

/* Likes yazısı daha “okunur” */
.post-likes {
  color: #0f172a;
  font-weight: 700;
}

/* Caption: küçük bir highlight alanı */
.post-caption {
  font-size: 14px;            /* 13 -> 14 (çok fark eder) */
  line-height: 1.55;
  color: #0f172a;

  background: #f8fafc;
  border: 1px solid #eef2f7;
  border-radius: 12px;

  padding: 6px 8px;           /* az, layoutu şişirmez */
  margin-top: 6px;
  margin-bottom: 6px;
}

/* Kullanıcı adı daha belirgin + tıklanabilir hissi */
.post-caption-user {
  font-weight: 800;
  color: #111827;
}

.post-caption-user:active {
  opacity: 0.8;
}

/* Asıl metin: daha okunur kontrast */
.post-caption-text {
  font-weight: 600;           /* 400-500 yerine 600 */
  color: #0f172a;
}

/* Comments da biraz güçlensin ama caption kadar bağırmasın */
.post-comment-main {
  font-size: 13.5px;          /* 13 -> 13.5 */
  color: #0f172a;
}

.comment-text {
  color: #0f172a;
  font-weight: 500;
}

/* Meta tarih (altta) çok soluk kalmış, biraz toparlayalım */
.post-meta {
  color: #6b7280;             /* 9ca3af -> 6b7280 */
  font-weight: 700;
}
</style>