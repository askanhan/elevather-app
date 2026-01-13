import Vue from 'vue';
import moment from 'moment';
import icons from '@/mixins/icons.js';
import basicOperations from '@/mixins/basic-operations';
import UIText from '@/mixins/ui-text.js';
import AnimatedNumber from '@/components/utils/animated-number/animated-number.vue';
import VideoPlayer from '@/components/complementarities/video-player/video-player.vue';

export default {
  name: 'Post',
  props: {
    post: { type: Object, required: true },
    showType: { type: String, default: 'full' }
  },
  mixins: [basicOperations, icons, UIText],
  components: { AnimatedNumber, VideoPlayer },

  data() {
    return {
      isVisible: false,
      showComment: false,
      newComment: '',
      loggedInUserId: this.$store?.state?.profile?.p_id || 999,
      likedByLoggedInUser: false
    };
  },

  computed: {
    profile() {
      if (this.$store.getters && typeof this.$store.getters.getProfile === 'function') {
        return this.$store.getters.getProfile(this.post.fk_profile);
      }
      return { p_id: this.post.fk_profile || 999, p_username: this.$t('components.post.testUser') };
    }
  },

  created() {
    this.likedByLoggedInUser = this.post.Likes?.some(like => like.userId === this.loggedInUserId) || false;
  },

  methods: {
    increaseLike() {
      if (this.likedByLoggedInUser) {
        this.$store.dispatch('postUnlike', { postID: this.post.post_id });
      } else {
        this.$store.dispatch('postLike', { postID: this.post.post_id });
      }
      this.likedByLoggedInUser = !this.likedByLoggedInUser;
    },

    postComment() {
      if (!this.newComment) return;
      this.post.comments = this.post.comments || [];
      this.post.comments.push({ comment: this.newComment, fk_profile: this.loggedInUserId });
      this.newComment = '';
    },

    getFromNow() {
      return moment(this.post.post_date).fromNow();
    },

    goToProfile(ppID) {
      this.$router.push({ name: 'profile', params: { profileID: ppID } });
    }
  }
};
