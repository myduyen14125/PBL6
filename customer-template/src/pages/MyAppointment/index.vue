<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-20 text-lg">
        <div class="calendar-wrapper">
          <FullCalendar :options="calendarOptions" />
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
import { formatDate } from "../../ultils/date";
import SwalPopup from "../../ultils/swalPopup";
import Swal from "sweetalert2";

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
      },
      appointmentId: 1,
      existSchedules: [],
      newSchedules: [],
      isSubmitting: false,
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
    // "calendarOptions.events": {
    //   handler(newValue, oldValue) {
    //     console.log(this.calendarOptions.events);
    //   },
    //   deep: true,
    // },
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
        }
      }
    },

    submit: function () {
      const params = this.newSchedules.map((item) => {
        return {
          start_at: formatDate(item.start, "YYYY-MM-DDTHH:mm:ss"),
          end_at: formatDate(item.end, "YYYY-MM-DDTHH:mm:ss"),
        };
      });
      this.createSchedule(params);
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
                  : "Lịch đang chờ xác nhận",
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
  },
  mounted() {
    this.getMySchedule();
  },
};
</script>

<style scoped lang="css"></style>
