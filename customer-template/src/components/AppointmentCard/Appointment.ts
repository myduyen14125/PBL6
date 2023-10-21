import { defineComponent } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import { Appointment } from "../../types/appointment";
import { formatDate } from "../../ultils/date";
import { PropType } from "vue";

export default defineComponent({
  name: "AppointmentCard",
  components: { SvgIcon },
  props: {
    appointment: {
      type: Object as PropType<any>,
      required: true,
      default: () => ({}),
    },
  },
  setup() {
    return { formatDate };
  },
});
