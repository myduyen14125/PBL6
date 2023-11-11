import { defineComponent, ref, PropType } from "vue";
import BModal from "../../BUI/BModal/BModal";
import { Appointment } from "../../../types/appointment";
import { getUserInfo } from "../../../ultils/cache/cookies";
import { formatDate } from "../../../ultils/date";

export default defineComponent({
  name: "ConfirmModal",
  components: { BModal },
  props: {
    appointment: {
      type: Object as PropType<Appointment>,
      required: true,
      default: () => ({}),
    },
  },
  setup() {
    const modal = ref(false);
    const isSubmitting = ref(false);

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
    };

    return {
      modal,
      isSubmitting,
      show,
      hide,
      getUserInfo,
      formatDate,
    };
  },
});
