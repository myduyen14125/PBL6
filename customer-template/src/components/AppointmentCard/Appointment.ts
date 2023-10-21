import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import { Appointment } from "../../types/appointment";
import { formatDate } from "../../ultils/date";

export default defineComponent({
  name: "AppointmentCard",
  components: { SvgIcon },
  props: {
    appointment: {
      type: Object as PropType<Appointment>,
      required: true,
      default: () => ({}),
    },
  },
  setup() {
    return { formatDate };
  },
});
