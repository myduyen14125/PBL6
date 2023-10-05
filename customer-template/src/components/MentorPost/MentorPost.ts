import { defineComponent, onMounted } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import postImg from "../../assets/image/post-img.png";

export default defineComponent({
  name: "MentorPost",
  components: { SvgIcon },
  setup() {
    return {
      avatar,
      postImg,
    };
  },
});
