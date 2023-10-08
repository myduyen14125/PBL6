import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";

export default defineComponent({
  name: "AppointmentCard",
  components: { SvgIcon },
  props: {
    appointment: {
      type: Object,
      required: true,
      default: () => ({
      }),
    },
  },
  setup() {
  },
});
