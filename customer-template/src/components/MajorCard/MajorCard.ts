import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";

export default defineComponent({
  name: "MajorCard",
  components: { SvgIcon },
  props: {
    major: {
      type: Object,
      required: true,
      default: () => ({
      }),
    },
  },
  setup() {
  },
});
