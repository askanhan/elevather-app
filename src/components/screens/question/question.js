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
      subjects: [{
          nl: 'Upgrade mijn profiel',
          tr: 'xxxxxxxxxx'
        },
        {
          nl: 'Vraag over andere producten',
          tr: 'xxxxxxxxxx'
        },
        {
          nl: 'Vraag over de app',
          tr: 'xxxxxxxxxx'
        },
        {
          nl: 'Iets foutgelopen?',
          tr: 'xxxxxxxxxx'
        },
        {
          nl: 'Overige',
          tr: 'xxxxxxxxxx'
        },
      ],
    }
  },

  computed: {},
  created() {},
  mounted() {},
  methods: {},
  watch: {}
}