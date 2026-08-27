import * as globalTypes from '@/store/mutation-types'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'
//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
export default {
  name: 'Question',
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      subjects: [
        { key: 'pages.question.subjects.profileUpgrade' },
        { key: 'pages.question.subjects.otherProducts' },
        { key: 'pages.question.subjects.appQuestion' },
        { key: 'pages.question.subjects.somethingWrong' },
        { key: 'common.other' },
      ],
    }
  },

  computed: {},
  created() {},
  mounted() {},
  methods: {},
  watch: {}
}