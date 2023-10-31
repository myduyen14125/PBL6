import { confirmAppointment } from "./../../api/appointment";
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
    const getAllUserAppointment = () => {
      console.log("hihi");

      emit("getAllUserAppointment", "");
    };
    const confirmAppointment = () => {
      appointmentStore.requestConfirmAppointment({
        id: props?.appointment._id,
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup("Appointment confirmed", "success");
            getAllUserAppointment();
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };
    return { formatDate, confirmAppointment, getUserInfo };
  },
});
