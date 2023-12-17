<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-20 text-lg">
        <div class="calendar-wrapper">
          <FullCalendar :options="calendarOptions" class="full-calendar" />
        </div>
        <div class="text-end">
          <button
            class="btn btn-primary p-3 my-5"
            @click="submit"
            :disabled="isSubmitting"
          >
            Đặt lịch rảnh
            <span
              v-if="isSubmitting"
              className="spinner-border spinner-border-sm ms-2"
              role="status"
              aria-hidden="true"
            ></span>
          </button>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script>
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import FullCalendar from "@fullcalendar/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import moment from "moment";
import { useSchedule } from "../../stores/schedule";
import { useUser } from "../../stores/user";
import { formatDate } from "../../ultils/date";
import SwalPopup from "../../ultils/swalPopup";
import Swal from "sweetalert2";
import router from "../../router";

export default {
  components: { GuestLayout, FullCalendar },
  data() {
    return {
      calendarOptions: {
        plugins: [timeGridPlugin, interactionPlugin],
        timeZone: "Asia/Ho_Chi_Minh",
        initialView: "timeGridWeek",
        headerToolbar: {
          left: "",
          center: "title",
        },
        validRange: {
          start: formatDate(new Date(), "YYYY-MM-DD"),
        },
        allDaySlot: false,
        // slotDuration: "00:15:00",
        dateClick: this.handleDateClick,
        events: [],
        eventClick: this.handleScheduleClick,
        slotMinTime: "06:00:00",
        slotMaxTime: "24:00:00",
      },
      appointmentId: 1,
      existSchedules: [],
      newSchedules: [],
      isSubmitting: false,
      skype_link: "",
    };
  },
  watch: {
    existSchedules: {
      handler(newValue, oldValue) {
        this.calendarOptions.events = [...newValue, ...this.newSchedules];
      },
      deep: true,
    },
    newSchedules: {
      handler(newValue, oldValue) {
        this.calendarOptions.events = [...this.existSchedules, ...newValue];
      },
      deep: true,
    },
  },
  methods: {
    handleDateClick: function (arg) {
      const end = moment(new Date(arg.dateStr))
        .add(moment.duration(1, "hours"))
        .format("YYYY-MM-DDTHH:mm:ss");

      this.newSchedules.push({
        id: this.appointmentId++,
        title: "Tôi sẵn sàng tư vấn",
        start: arg.dateStr,
        end: end,
      });
    },

    handleScheduleClick: function (arg) {
      let deleteItem = this.existSchedules.findIndex((item) => {
        return item.id == arg.event._def.publicId;
      });

      if (deleteItem == -1) {
        deleteItem = this.newSchedules.findIndex(
          (item) => item.id == arg.event._def.publicId
        );
        this.newSchedules.splice(deleteItem, 1);
      } else {
        if (this.existSchedules[deleteItem].status) {
          this.existSchedules.splice(deleteItem, 1);

          /// call delete api
          this.deleteSchedule(arg.event._def.publicId);
        }
      }
    },

    submit: function () {
      if (this.skype_link) {
        const params = this.newSchedules.map((item) => {
          return {
            start_at: formatDate(item.start, "YYYY-MM-DDTHH:mm:ss"),
            end_at: formatDate(item.end, "YYYY-MM-DDTHH:mm:ss"),
          };
        });
        this.createSchedule(params);
      } else {
        SwalPopup.swalResultPopup(
          "Vui lòng cập nhật link Google Meet của bạn trước khi đặt lịch rảnh. Cuộc hẹn giữa bạn và mentee sẽ diễn ra tại link Google Meet này.",
          "success",
          {
            onConfirmed: () => {
              router.push({ path: "/personal-info" });
            },
          }
        );
      }
    },

    showToast: function () {
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
        icon: "success",
        title: "Đặt lịch rảnh thành công.",
      });
    },

    createSchedule: function (params) {
      this.isSubmitting = true;
      const scheduleStore = useSchedule();
      scheduleStore.requestCreateSchedule({
        params: params,
        callback: {
          onSuccess: (res) => {
            this.isSubmitting = false;
            this.getMySchedule();
            this.newSchedules = [];
            this.showToast();
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            this.isSubmitting = false;
          },
        },
      });
    },

    deleteSchedule: function (id) {
      this.isSubmitting = true;
      const scheduleStore = useSchedule();
      scheduleStore.requestDeleteSchedule({
        id: id,
        callback: {
          onSuccess: (res) => {
            this.isSubmitting = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            this.isSubmitting = false;
          },
        },
      });
    },

    getMySchedule: function (params) {
      const scheduleStore = useSchedule();
      scheduleStore.requestGetMySchedules({
        callback: {
          onSuccess: (res) => {
            this.existSchedules = res?.map((item) => {
              return {
                id: item._id,
                title: item.status
                  ? "Tôi sẵn sàng tư vấn"
                  : "Lịch đã được book",
                start: item.start_at,
                end: item.end_at,
                color: item.status ? "" : "orange",
                status: item.status,
              };
            });
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

    getUserInformation: function (params) {
      const userStore = useUser();
      userStore.requestMyProfile({
        callback: {
          onSuccess: (res) => {
            this.skype_link = res?.skype_link || "";
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
  mounted() {
    this.getMySchedule();
    this.getUserInformation();
  },
};
</script>

<style scoped lang="css">
.calendar-wrapper {
  height: 650px;
}
.full-calendar {
  height: 100%;
}
</style>
