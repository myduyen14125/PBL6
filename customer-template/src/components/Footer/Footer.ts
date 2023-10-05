import { defineComponent, onMounted } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";

export default defineComponent({
  name: "Footer",
  component: { SvgIcon },
  setup() {
    return {
      logo,
      //   navLinks,
    };
  },
});
