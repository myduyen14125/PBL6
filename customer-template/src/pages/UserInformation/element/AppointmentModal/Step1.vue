<template>
  <div>
    <div class="progress">
      <div class="progress-bar background-primary progress-bar-striped" role="progressbar" style="width: 25%"
        aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
        25%
      </div>
    </div>
    <div class="d-flex align-items-center my-4">
      <SvgIcon icon="handIcon" class="me-3" />
      <h5 class="color-primary mb-0">Chọn thời gian</h5>
    </div>
    <div class="calendar-wrapper">
    </div>
  </div>
</template>

<script>
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'

export default {
  components: { SvgIcon, FullCalendar },
  data() {
    return {
    }
  },
  methods: {
    handleDateClick: function(arg) {
      alert('date click! ' + arg.dateStr)
    }
  },
  setup() {
  },
};
</script>

<style scoped lang="css"></style>
