import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";

export default defineComponent({
  name: "MessageCard",
  components: { SvgIcon },
  setup() {
    return {
      avatar,
    };
  },
});
