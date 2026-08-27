
import basicOperations from '@/mixins/basic-operations'
export default {
  name: 'Footer',
  mixins: [basicOperations],
  data() {
    return {
      isVisible: false
    }
  },

  computed: {
  },
  created() {
  },
  mounted() {},
  methods: {
    shareapp(){
      console.log('shareapp')
      window.plugins.socialsharing.share(this.$t('components.footer.shareMessage'), null, null, 'https://elevather.eu/')
    }
  },
  watch: {}
}