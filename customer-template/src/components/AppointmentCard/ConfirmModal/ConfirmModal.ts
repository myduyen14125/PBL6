import { defineComponent, ref, PropType } from "vue";
import BModal from "../../BUI/BModal/BModal.vue";
import { Appointment } from "../../../types/appointment";
import { getUserInfo } from "../../../ultils/cache/cookies";
import { formatDate } from "../../../ultils/date";
import avatar from "../../../assets/image/avatar.png";

export default defineComponent({
  name: "ConfirmModal",
  components: { BModal },
  emits: ["cancel", "confirm"],
  props: {
    appointment: {
      type: Object as PropType<Appointment>,
      required: true,
      default: () => ({}),
    },
  },
  setup(props, { emit }) {
    const modal = ref(false);
    const isSubmitting = ref(false);
    const status = ref("");

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
      status.value = "";
    };

    const setStatus = (value: string) => {
      status.value = value;
    };

    const confirm = () => {
      if (status.value == "cancel") {
        emit("cancel", "");
        hide();
      } else if (status.value == "confirm") {
        emit("confirm", "");
        hide();
      }
    };

    return {
      avatar,
      modal,
      isSubmitting,
      status,
      show,
      hide,
      getUserInfo,
      formatDate,
      confirm,
      setStatus,
    };
  },
});
