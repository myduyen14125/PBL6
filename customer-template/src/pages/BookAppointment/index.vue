<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-14 text-lg">
        <el-steps :active="activeStep" align-center>
          <el-step title="Chọn thời gian" />
          <el-step title="Xác nhận" />
          <el-step title="Thành công" />
        </el-steps>

        <div class="calendar-wrapper mt-3">
          <FullCalendar :options="calendarOptions" class="full-calendar" />
        </div>
        <div class="d-flex justify-content-between items-center mt-4 gap-4 text-xl text-[#0a5565]">
          <!-- <div class="px-4 shadow-md bg-[#139896] text-white rounded h-14 d-flex items-center">
            <p class="mr-2 my-0">Lịch chọn</p>
            <p class="my-0 mr-2" v-if="selectedSchedule.start">{{ selectedSchedule.start }} - </p>
            <p class="my-0 mr-2" v-if="selectedSchedule.end">{{ selectedSchedule.end }}</p>
          </div> -->
          <div>
            <button class="btn btn-primary btn-lg mr-2" @click="nextActiveStep">Tiếp tục</button>
            <button class="btn btn-primary btn-lg" @click="bookAppointment">
              Đặt lịch
            </button>
          </div>
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
import { useUser } from "../../stores/user";
import { useAppointment } from "../../stores/appointment";
import { formatDate, formatTimeFullCalendar } from "../../ultils/date";
import SwalPopup from "../../ultils/swalPopup";
import Swal from "sweetalert2";

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
        timeZone: "Asia/Ho_Chi_Minh",
        initialView: "timeGridWeek",
        headerToolbar: {
          left: "prev,next",
          center: "title",
          right: "timeGridWeek,timeGridDay",
        },
        allDaySlot: false,
        validRange: {
          start: formatDate(new Date(), "YYYY-MM-DD"),
        },
        dateClick: this.handleDateClick,
        eventClick: this.handleSelectSchedule,
        events: [],
        eventColor: '#409ee7',
        slotDuration: "00:30:00",
        slotMinTime: "06:00:00",
        slotMaxTime: "24:00:00",
      },
      userSchedules: [],
      selectedSchedule: {
        id: "",
        title: "",
        start: "",
        end: "",
      },
      activeStep : 0,
    };
  },
  methods: {
    handleDateClick: function (arg) {
      this.showToast("warning", "Mentor không có lịch rảnh trong thời gian này! " + "</br>" + formatTimeFullCalendar(arg.dateStr));
    },
    handleSelectSchedule: function (arg) {
      this.selectedSchedule.id = arg.event.id;
      this.selectedSchedule.start = formatTimeFullCalendar(arg.event.start);
      this.selectedSchedule.end = formatTimeFullCalendar(arg.event.end);
      // change eventColor
      this.calendarOptions.events.forEach((event) => {
        if (event.id === arg.event.id) {
          event.color = "#139896";
          event.title = "Đã chọn";
        } else {
          event.color = "#409ee7";
        }
      });
    },
    getUserInformation: function () {
      const userStore = useUser();
      userStore.requestGetUserSchedules({
        id: this.id,
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
        if(this.userSchedules[i].status === false) continue;
        this.calendarOptions.events.push({
          id: this.userSchedules[i]._id,
          title: "Có thể đặt lịch",
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
          schedule: this.selectedSchedule.id,
          note: "Hehehe yuu dat lich nheeee",
        },
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup("Đặt lịch thành công", "success");
            this.$router.push("/appointments");
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
    showToast: function (type, content) {
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.addEventListener("mouseenter", Swal.stopTimer);
          toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
      });

      Toast.fire({
        icon: type,
        title: content,
      });
    },
    nextActiveStep: function() {
      if (this.activeStep++ > 2) this.activeStep = 0
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
