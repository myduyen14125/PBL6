<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-14 text-lg min-h-[92vh]">
        <el-steps :active="activeStep" align-center>
          <el-step title="Chọn thời gian" />
          <el-step title="Xác nhận" />
        </el-steps>

        <div v-if="activeStep === 0" class="section-wrapper mt-3">
          <FullCalendar :options="calendarOptions" class="full-calendar" />
        </div>
        
        <div v-else-if="activeStep === 1" class="mt-3 text-xl section-wrapper">
          <AppointmentDetail :userInfo="userInfo" :selectedSchedule="selectedSchedule" @note="updateNote" />
        </div>

        <div class="mt-4 gap-4 text-xl text-[#0a5565]">
          <div class="d-flex justify-content-center">
            <button v-if="activeStep > 0" class="btn btn-primary btn-lg mr-2" @click="previousActiveStep">Quay
              lại</button>
            <button v-if="activeStep == 0" class="btn btn-primary btn-lg mr-2" @click="nextActiveStep">Tiếp tục</button>
            <button v-else class="btn btn-primary btn-lg" @click="bookAppointment">
              Đặt lịch
              <span v-if="isBookingAppointment" className="spinner-border spinner-border-sm ms-2" role="status"
                aria-hidden="true"></span>
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
import AppointmentDetail from "../../components/AppointmentCard/AppointmentDetail.vue";

import { useSchedule } from "../../stores/schedule";
import { useUser } from "../../stores/user";
import { useAppointment } from "../../stores/appointment";
import { formatDate, formatTimeFullCalendar } from "../../ultils/date";
import SwalPopup from "../../ultils/swalPopup";
import Swal from "sweetalert2";

export default {
  components: { GuestLayout, SvgIcon, FullCalendar, AppointmentDetail },
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
        eventColor: "#409ee7",
        slotDuration: "00:30:00",
        slotMinTime: "06:00:00",
        slotMaxTime: "24:00:00",
      },
      userInfo: {},
      userSchedules: [],
      selectedSchedule: {
        id: "",
        title: "",
        start: "",
        end: "",
      },
      note: "",
      activeStep: 0,
      isBookingAppointment: false,
    };
  },
  methods: {
    handleDateClick: function (arg) {
      this.showToast(
        "warning",
        "Mentor không có lịch rảnh trong thời gian này! " +
        "</br>" +
        formatTimeFullCalendar(arg.dateStr)
      );
    },
    handleSelectSchedule: function (arg) {
      this.selectedSchedule.id = arg.event.id;
      this.selectedSchedule.start = formatTimeFullCalendar(arg.event.start);
      this.selectedSchedule.end = formatTimeFullCalendar(arg.event.end);
      this.calendarOptions.events.forEach((event) => {
        if (event.id === arg.event.id) {
          event.color = "#139896";
          event.title = "Đã chọn";
        } else {
          event.color = "#409ee7";
          event.title = "Có thể đặt lịch"
        }
      });
    },
    getUserInformation: function (id) {
      const userStore = useUser();
      userStore.requestGetUserInfo({
        id: id,
        callback: {
          onSuccess: (res) => {
            this.userInfo = res;
            console.log(this.userInfo);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Xin lỗi, hệ thống có lỗi xảy ra, vui lòng thử lại!",
              "error"
            );
          },
        },
      });
    },
    getUserSchedules: function () {
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
              "Xin lỗi, hệ thống có lỗi xảy ra, vui lòng thử lại!",
              "error"
            );
          },
        },
      });
    },
    setUserSchedules: function () {
      for (let i = 0; i < this.userSchedules.length; i++) {
        if (this.userSchedules[i].status === false) continue;
        this.calendarOptions.events.push({
          id: this.userSchedules[i]._id,
          title: "Có thể đặt lịch",
          start: this.userSchedules[i].start_at,
          end: this.userSchedules[i].end_at,
        });
      }
    },
    bookAppointment: function () {
      if (this.validateInfo() === false) return;
      else {
        const appointmentStore = useAppointment();
        this.isBookingAppointment = true;
        appointmentStore.requestCreateAppointment({
          params: {
            mentor: this.id,
            schedule: this.selectedSchedule.id,
            note: this.note,
          },
          callback: {
            onSuccess: (res) => {
              SwalPopup.swalResultPopup("Đặt lịch thành công", "success");
              this.isBookingAppointment = false;
              this.$router.push("/appointments");
            },
            onFailure: () => {
              SwalPopup.swalResultPopup(
                "Sorry, looks like there are some errors detected, please try again.",
                "error"
              );
              this.isBookingAppointment = false;
            },
          },
        });
      }
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
    nextActiveStep: function () {
      if (this.validateInfo() === false) return;
      else if (this.activeStep++ > 1) this.activeStep = 0;
    },
    previousActiveStep: function () {
      if (this.activeStep-- < 0) this.activeStep = 0;
    },
    validateInfo: function () {
      if (this.selectedSchedule.id === "") {
        SwalPopup.swalResultPopup(
          "Vui lòng chọn thời gian hẹn!",
          "error"
        );
        return false;
      }
      return true;
    },
    updateNote: function (note) {
      this.note = note;
    },
  },
  async mounted() {
    this.getUserInformation(this.id);
    await this.getUserSchedules();
    this.setUserSchedules();
  },
};
</script>

<style scoped lang="css">
.section-wrapper {
  height: 66vh;
}

.full-calendar {
  height: 100%;
}</style>
