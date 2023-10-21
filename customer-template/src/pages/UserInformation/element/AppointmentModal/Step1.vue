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
      <FullCalendar :options="calendarOptions" />
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
      calendarOptions: {
        plugins: [ timeGridPlugin, interactionPlugin ],
        initialView: 'timeGridWeek',
        headerToolbar: {
          left: 'prev,next',
          center: 'title',
          right: 'timeGridWeek,timeGridDay' // user can switch between the two
        },
        dateClick: this.handleDateClick,
        events: [
          { title: 'Hanging with Yuu', date: '2023-10-20 10:30'},
          { title: 'Hehe, partyyy', date: '2023-10-18 20:10' }
        ]
      }
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
