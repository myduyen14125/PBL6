import { defineComponent, ref } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import { Appointment } from "../../types/appointment";
import { formatDate } from "../../ultils/date";
import { PropType } from "vue";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";
import { getUserInfo } from "../../ultils/cache/localStorage";

export default defineComponent({
  name: "AppointmentCard",
  components: { SvgIcon },
  emits: ["getAllUserAppointment"],
  props: {
    appointment: {
      type: Object as PropType<Appointment>,
      required: true,
      default: () => ({}),
    },
  },
  setup(props, { emit }) {
    const appointmentStore = useAppointment();
    const isLoadingConfirm = ref(false);
    const isLoadingCancel = ref(false);

    const confirmAppointment = () => {
      isLoadingConfirm.value = true;
      appointmentStore.requestConfirmAppointment({
        id: props?.appointment._id,
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup("Appointment confirmed", "success");
            emit("getAllUserAppointment", "confirmed");
            isLoadingConfirm.value = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingConfirm.value = false;
          },
        },
      });
    };

    const onCancelAppointment = () => {
      SwalPopup.swalDeletePopup("Bạn có chắc chắn xóa lịch hẹn ?", {
        onConfirmed: () => {
          cancelAppointment();
        },
      });
    };

    const cancelAppointment = () => {
      isLoadingCancel.value = true;
      appointmentStore.requestCancelAppointment({
        id: props?.appointment._id,
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup("Canceled Appointment ", "success");
            emit("getAllUserAppointment", "canceled");
            isLoadingCancel.value = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingCancel.value = false;
          },
        },
      });
    };

    return {
      formatDate,
      confirmAppointment,
      getUserInfo,
      onCancelAppointment,
      isLoadingConfirm,
      isLoadingCancel,
    };
  },
});
