export default {
  name: 'html-textarea',
  props: ['value'],
  mounted: function() {
    this.$el.innerHTML = this.value;
  },
  methods: {
    updateHTML: function(e) {
      this.$emit('input', e.target.innerHTML);
    }
  }
};
