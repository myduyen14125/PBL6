import { defineComponent, onMounted } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import icMentee from "../../assets/image/ic-mentee.png";
import icFollowed from "../../assets/image/followed.png";

export default defineComponent({
  name: "MentorCard",
  components: { SvgIcon },
  setup() {
    return {
      avatar,
      icMentee,
      icFollowed,
    };
  },
});
