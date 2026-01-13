import * as globalTypes from '@/store/mutation-types'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
export default {
  name: 'SelectTag',
  mixins: [basicOperations, icons, UIText],
  /* 
    components: {
      UIText
    }, */
  data() {
    return {
      selectedTags: [],
    }
  },

  computed: {
    allCategories() {
      return this.$store.state.categories
    }
  },
  created() {},
  mounted() {
    if (sessionStorage.selectedTags && sessionStorage.selectedTags.length > 0) {
      this.selectedTags = sessionStorage.selectedTags.split(',').map(t => parseInt(t))
    }
  },
  methods: {
    selectTag(catID, tagID) {
      if (this.isTagSelected(tagID)) {
        this.selectedTags = this.selectedTags.filter(t => t !== tagID)
      } else {
        if (!this.maximumReached()) {
          this.selectedTags.push(tagID)
        }
      }
    },
    isTagSelected(tagID) {
      return this.selectedTags.filter(t => t === tagID).length > 0
    },
    maximumReached() {
      if (this.selectedTags.length > 4) {
        this.$store.commit(globalTypes.SHOW_MESSAGE, this.UIText.add.maximumReached[this.lang])
        return true
      }
      return false
    },
    goBack() {
      if (this.selectedTags.length == 0) {
        this.$store.commit(globalTypes.SHOW_MESSAGE, this.UIText.add.selectSomeTags[this.lang])
      } else {
        sessionStorage.setItem('selectedTags', this.selectedTags)
        this.$router.go(-1)
      }
    }
  },
  watch: {}
}