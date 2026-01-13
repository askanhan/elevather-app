// import * as mutationTypes from '@/store/mutation-types.js' // lokale SET mutation implementeren

export default {
  name: 'kalender',

  data() {
    return {
      msg: 'Datum selectie',
      dezeDatum: null
      // childData: ''
    }
  },
  props: ['show2', 'datumParent', 'kalenderId', 'withTimestamp'],
  watch: {
    dezeDatum: {
      immediate: true,
      handler(newVal, oldVal) { // watch it
        console.log('Prop changed: ', newVal, ' | was: ', oldVal)
      }
    },
    show2: {
      immediate: true,
      handler(newVal, oldVal) { // watch it
        console.log('Prop changed: ', newVal, ' | was: ', oldVal)
        if (newVal) {
          this.dezeDatum = this.datumParent
          let dit = this
          let gevondenDatum = this.datumParent

          if (gevondenDatum === '') {
            gevondenDatum = new Date() // bv. voor publicatiedatum kan leeg zijn
          }

          setTimeout(function (dit) { // verplicht
            console.log('moet date zijn:')
            let dezeDit = dit
            var formatering = 'YYYY-MM-DD'
            var showTimepicker = false
            if (dit.withTimestamp) {
              formatering = 'YYYY-MM-DD HH:mm'
              showTimepicker = true
            }
            $('#' + dit.kalenderId).daterangepicker({
              singleDatePicker: true,
              showDropdowns: true,
              autoUpdateInput: true,
              timePicker: showTimepicker,
              timePicker24Hour: true,
              startDate: moment(gevondenDatum).format(formatering),
              locale: {
                format: formatering,
                'daysOfWeek': ['Zo', 'Ma', 'Di', 'Wo', 'Do', 'Vr', 'Za'],
                'monthNames': ['Januari', 'Februari', 'Maart', 'April', 'Mei', 'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November',
                  'December'
                ],
                'firstDay': 1,
                'applyLabel': 'Ok',
                'cancelLabel': 'Annuleer',
              }
            })

            $('#' + dit.kalenderId).on('hide.daterangepicker', function (ev, picker) {
              let datum = $('#' + dit.kalenderId)[0].value
              let vueScope = dezeDit
              vueScope.$emit('dateChanged', datum)
              console.log('emit datum!!!!')
            })
          }, 500, dit)
          /* volledig zichtbaar in scherm (verder uitwerken indien nodig)
               $('#kalender').daterangepicker({
                 $('#kalender').daterangepicker({
                   singleDatePicker: true,
                    zonderPopup: true, => daterangepickerMAARTEN_INLINE_KALENDER.js gebruiken!
                   'startDate': new Date(),
                   locale: {
                     format: 'YYYY-MM-DD',
                     'daysOfWeek': [ 'Zo', 'Ma', 'Di', 'Wo', 'Do', 'Vr', 'Za' ],
                     'monthNames': ['Januari', 'Februari', 'Maart', 'April', 'Mei', 'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November', 'December'],
                     'firstDay': 1
                   } })
                 $('#hierin').append($('.daterangepicker'))
                 $('#kalender').click()
                 let kalender = $('.show-calendar')
                 kalender.removeClass()
                 kalender.addClass('daterangepicker single')
                  }, 500);
           */
        } else { // TODO not global then? mutationTypes.ZET_SELECTED_DATUM no more work
          this.$store.commit('wPuntenboekje/' + 'ZET_SELECTED_DATUM', $('#' + this.kalenderId).data('daterangepicker').startDate._d)
        }
      }
    }
  },
  methods: {
    // maybe onchagne may onclick whatever..
    /* handleDataFc: function () {
      this.$emit('interface', this.childData) // handle data and give it back to parent by interface
     },
     beforeMount () {
       this.childData = this.parentData // save props data to itself's data and deal with it
     },
     datumGewijzigd (par1, par2, par3) {
       console.log('datum gewijzigd')
       this.$store.commit(mutationTypes.ZET_SELECTED_DATUM, $('#kalender').data('daterangepicker').startDate._d)
     } */
  }
}
