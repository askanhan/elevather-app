import * as globalTypes from '@/store/mutation-types'
import icons from '@/mixins/icons.js'
import basicOperations from '@/mixins/basic-operations'
import * as mutationTypes from '@/store/mutation-types.js'
import UIText from '@/mixins/ui-text.js'

//  const basicOperations = require('@/mixins/basic-operations.js')

import Vue from 'vue'
export default {
  name: 'MyMessages',
  mixins: [basicOperations, icons, UIText],
  data() {
    return {
      menu: []
    }
  },

  computed: {
    chats() {
      return this.$store.state.allMessages
    },
    nOfChats() {
      return Object.keys(this.chats).length
    }
  },
  created() {
    this.$store.commit('SET_HEADER_TITLE', {
      tr: 'Mesajlarim',
      nl: 'Mijn berichten',
      fr: 'Mes messages'
    })
    this.$store.dispatch('getAllMessages')
  },
  mounted() { },
  methods: {
    goToChat(chat, profile) {
      this.$store.commit('SET_HEADER_TITLE', {
        tr: profile.p_username + ' ile sohbet',
        nl: 'Gesprek met ' + profile.p_username,
        fr: 'Conversation avec ' + profile.p_username,
      })
      this.$router.push({
        name: 'chat',
        params: {
          chat,
          profile
        }
      })
    },
    getProfile(id) {
      return this.$store.getters.getProfile(id)
    },
    nOfUnreadMessagesOfChat(chat) {
      return chat.filter(c => c.pm_viewed === 0).length
    },
    fromNow(chat) {
      return new moment(chat[chat.length - 1].pm_date).fromNow()
    }
  },
  watch: {}
}