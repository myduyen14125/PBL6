import moment from 'moment'
import Vue from "vue";

export default ({ app }, inject) => {
  inject('formatTimestamp', (timestamp) => {
    return moment(timestamp).format('YYYY-MM-DD')
  })

  inject('getDay', (timestamp) => {
    return moment(timestamp).format('DD')
  })

  inject('getMonth', (timestamp) => {
    return moment(timestamp).format('MM')
  })

  inject('getYear', (timestamp) => {
    return moment(timestamp).format('YYYY')
  })

}

Vue.mixin({
  methods: {
    formatDateTimeTimeByLanguageCode(timestamp) {
      const FORMAT_DATE = {
        'en': 'MM/DD/YYYY',
        'ja': 'YYYY/MM/DD',
        'vi': 'DD/MM/YYYY'
      }
      return moment(timestamp).format(FORMAT_DATE[this.$i18n.locale]); 
    },
    formatDateTime(timestamp) {
      const date = new Date(timestamp);
      return (
        date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear()
      );
    },
    formatWorkingType(type) {
      return type.replace('_', ' ').toLowerCase().replace(/(^|\s)\S/g, (L) => L.toUpperCase());
    },
    formatSalary(salary) {
      return salary.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    },
    formatDate(date) {
      return moment(date).format('DD.MM.YYYY');
    },
    trimInput(obj, key) {
      obj[key] = obj[key].trim();
    },
    trimInputArray(obj, key) {
      obj[key] = obj[key].map(item => item.trim());
    }
  }
});