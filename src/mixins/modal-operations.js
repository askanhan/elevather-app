import * as globalTypes from "./../store/mutation-types.js";

export default {
  computed: {
    closeLocalDialog() {
      return this.$store.state.closeDialog;
    }
  },

  watch: {
    closeLocalDialog: function (newVal) {
      console.log("closeLocalDialog");
      if (newVal) {
        this.close();
        var dezeDit = this;
        setTimeout(function () {
          dezeDit.$store.commit(globalTypes.CLOSE_DIALOG, false);
        }, 100);
      }
    }
  }
};
