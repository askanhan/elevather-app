import * as globalTypes from '@/store/mutation-types'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import Post from '@/components/complementarities/post/post.vue'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
export default {
  name: 'PostList',
  mixins: [basicOperations, icons, UIText],
  components: {
    Post
  },
  data() {
    return {
      selectedLocation: 0,
      welcomeMessage: 'Welkom gebruiker',
      meta: {}
    }
  },

  computed: { // cached and changed only if one of its dependencies is changed
    tag() {
      if (this.meta.tagID) {
        return this.$store.state.allTags.filter(t => t.tag_id === this.meta.tagID)[0]
      }
      return {}
    },
    locations() {
      return this.$store.state.locations
    },
    tagsPosts() {
      return this.$store.state.allPosts.filter(p => p.tags.filter(pt => pt === this.meta.tagID).length > 0)
    }
  },
  created() {
    this.meta = this.$route.params
  },
  mounted() {
    let self = this
  },
  methods: {
    selectTag(tagID) {
      console.log("kfffffffffffffffffffffffffffffffffffff")
      this.meta = {}
      this.meta.screen = 'search'
      this.meta.tagID = tagID
    }
  },
  watch: {}
}