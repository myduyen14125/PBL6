import { defineComponent, onMounted } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import postImg from "../../assets/image/post-img.png";
import { formatDate } from "../../ultils/date";
import router from "../../router";
import { getUserInfo } from "../../ultils/cache/localStorage";

export default defineComponent({
  name: "MentorPost",
  components: { SvgIcon },
  props: {
    blog: {
      type: Object,
      required: true,
      default: () => ({}),
    },
    showEdit: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  setup() {
    return {
      avatar,
      postImg,
      router,
      formatDate,
      getUserInfo,
    };
  },
});
