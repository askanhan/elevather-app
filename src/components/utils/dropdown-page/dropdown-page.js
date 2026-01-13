import * as mutationTypes from '@/store/mutation-types.js'
import icons from '@/mixins/icons.js'

export default {
  name: 'DropdownPage',
  data() {
    return {
      allSettings: {},
      listOfItems: []
    }
  },
  mixins: [icons],
  created() {
    this.allSettings = JSON.parse(JSON.stringify(this.$store.state.allDropdownMenus[this.$store.state.currentDropdownMenu]))
    this.listOfItems = this.allSettings.listOfItems
  },
  mounted() {},
  methods: {
    itemClicked(item) {
      console.log('itemClicked')
      if (!this.allSettings.isMultiSelect) {
        // uncheck other items
        this.listOfItems.map(function(others) {
          if (others._ID_DROPDOWN_PAGE === item._ID_DROPDOWN_PAGE) {
            item._SELECTED_DROPDOWN_PAGE = !item._SELECTED_DROPDOWN_PAGE
          } else {
            others._SELECTED_DROPDOWN_PAGE = false
          }
        })
        //  if (this.allSettings.atLeastOneSelectedItemRequired && this.listOfItems.filter(function (item) {
        //    return item._SELECTED_DROPDOWN_PAGE
        //  }).length === 0) { // if there is no selected item && if atLeastOneSelectedItemRequired is true
        //    item._SELECTED_DROPDOWN_PAGE = true
        //  }
        this.goBack()
      } else {
        item._SELECTED_DROPDOWN_PAGE = !item._SELECTED_DROPDOWN_PAGE
      }
    },
    goBack() {
      this.$store.commit(mutationTypes.UPDATE_LIST_OF_ITEMS_OF_DROPDOWN, this.listOfItems)
      this.$router.go(-1)
    }
  },
  watch: {}
}