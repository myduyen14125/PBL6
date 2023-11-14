import { defineComponent, ref, Ref } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import { Appointment } from "../../types/appointment";
import { formatDate } from "../../ultils/date";
import { PropType } from "vue";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";
import { getUserInfo } from "../../ultils/cache/cookies";
import ConfirmModal from "./ConfirmModal/ConfirmModal.vue";

export default defineComponent({
  name: "AppointmentCard",
  components: { SvgIcon, ConfirmModal },
  emits: ["getAllUserAppointment", "click"],
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
    const confirmModal: Ref<any> = ref<typeof ConfirmModal | null>(null);

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

    const onCancelAppointment = (e: any) => {
      showCancelConfirm();
      e.stopPropagation();
    };

    const onConfirmAppointment = (e: any) => {
      showConfirm();
      e.stopPropagation();
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

    const showCancelConfirm = () => {
      confirmModal?.value?.setStatus("cancel");
      confirmModal?.value?.show();
    };

    const showConfirm = () => {
      confirmModal?.value?.setStatus("confirm");
      confirmModal?.value?.show();
    };

    const handleImage = (image: any) => {
      if (!image || image === "blank") {
        return "https://4kwallpapers.com/images/wallpapers/anime-girl-girly-1024x768-9792.jpg";
      }
      return image;
    };

    const onClick = () => {
      emit("click", "");
    };

    return {
      formatDate,
      confirmAppointment,
      getUserInfo,
      onCancelAppointment,
      onConfirmAppointment,
      isLoadingConfirm,
      isLoadingCancel,
      confirmModal,
      handleImage,
      showCancelConfirm,
      cancelAppointment,
      onClick,
    };
  },
});
