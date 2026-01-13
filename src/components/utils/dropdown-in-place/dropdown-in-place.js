import icons from '@/mixins/icons.js'
export default {
  name: 'DropdownInPlace',
  data() {
    return {
      showDDList: true
    }
  },
  props: ['listOfItems'],
  mixins: [icons],
  created() {},
  mounted() {},
  computed: {
    selectedItem() {
      return this.listOfItems.filter(function(item) {
        return item._selected
      })[0]
    }
  },
  methods: {
    itemClicked(clickedItem) {
      if (!clickedItem._selected) {
        this.listOfItems.map(function(anItem) {
          anItem._selected = false
        })
        clickedItem._selected = true
      }
      this.$emit('ddselected', clickedItem)
      this.showDDList = false
    },
    closeList() {
      console.log('closeList')
      this.$emit('ddselected', '')
      this.showDDList = false
    }
  }
}