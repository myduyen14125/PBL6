<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-14 text-lg">
        <div class="progress">
          <div
            class="progress-bar background-primary progress-bar-striped"
            role="progressbar"
            style="width: 25%"
            aria-valuenow="25"
            aria-valuemin="0"
            aria-valuemax="100"
          >
            25%
          </div>
        </div>
        <div class="d-flex align-items-center my-4">
          <SvgIcon icon="handIcon" class="me-3" />
          <h5 class="color-primary mb-0">Chọn thời gian</h5>
        </div>
        <div class="calendar-wrapper">
          <FullCalendar :options="calendarOptions" class="full-calendar" />
        </div>
        <div class="d-flex justify-content-center mt-5 gap-4">
          <span style="color: red">Lịch chọn: {{ selectedScheduleId }}</span>
          <button class="btn btn-primary btn-lg">Tiếp tục</button>
          <button class="btn btn-primary btn-lg" @click="bookAppointment">
            Đặt lịch
          </button>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script>
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import FullCalendar from "@fullcalendar/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import { useSchedule } from "../../stores/schedule";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";

export default {
  components: { GuestLayout, SvgIcon, FullCalendar },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      calendarOptions: {
        plugins: [timeGridPlugin, interactionPlugin],
        initialView: "timeGridWeek",
        headerToolbar: {
          left: "prev,next",
          center: "title",
          right: "timeGridWeek,timeGridDay", // user can switch between the two
        },
        dateClick: this.handleDateClick,
        eventClick: this.handleSelectSchedule,
        events: [],
        slotDuration: "00:30:00",
        slotMinTime: "06:00:00",
        slotMaxTime: "24:00:00",
      },
      userSchedules: [],
      selectedScheduleId: {},
    };
  },
  methods: {
    handleDateClick: function (arg) {
      alert("date click! " + arg.dateStr);
    },
    handleSelectSchedule: function (arg) {
      alert("event click! " + arg.event.id + " " + arg.event.startStr);
      this.selectedScheduleId = arg.event.id;
    },
    getUserInformation: function () {
      const scheduleStore = useSchedule();
      scheduleStore.requestGetMySchedules({
        callback: {
          onSuccess: (res) => {
            this.userSchedules = res;
            this.setUserSchedules();
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    },
    setUserSchedules: function () {
      for (let i = 0; i < this.userSchedules.length; i++) {
        this.calendarOptions.events.push({
          id: this.userSchedules[i]._id,
          title: "Có thể đặt lịch với mentor",
          start: this.userSchedules[i].start_at,
          end: this.userSchedules[i].end_at,
        });
      }
    },
    bookAppointment: function () {
      const appointmentStore = useAppointment();
      appointmentStore.requestCreateAppointment({
        params: {
          mentor: this.id,
          schedule: this.selectedScheduleId,
          note: "Hehehe yuu dat lich nheeee",
        },
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup("Đặt lịch thành công", "success");
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    },
  },
  async mounted() {
    await this.getUserInformation();
    this.setUserSchedules();
  },
};
</script>

<style scoped lang="css">
.calendar-wrapper {
  height: 600px;
}
.full-calendar {
  height: 100%;
}
</style>
