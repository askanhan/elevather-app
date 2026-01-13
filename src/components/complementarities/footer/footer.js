
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
      window.plugins.socialsharing.share('Butun Belçikali Turklerin bir araya geldigi bu platformu siz de indirin!', null, null, 'www.burada.be')
    }
  },
  watch: {}
}