import { defineComponent, onMounted, ref } from "vue";
import personLogo from "../../assets/image/ic-mentee.png";
import heartLogo from "../../assets/image/followed.png";
import ratingLogo from "../../assets/image/rating.png";
import hourLogo from "../../assets/image/hour.png";
import coverImg from "../../assets/image/cover.jpg";
import avatarImg from "../../assets/image/cover.jpg";
import advertisementImg from "../../assets/image/advertisement.jpg";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import ExperienceCard from "./element/ExperienceCard.vue";
import { useUser } from "../../stores/user";
import SwalPopup from "../../ultils/swalPopup";
import { getUserInfo } from "../../ultils/cache/localStorage";

export default defineComponent({
  name: "UserInformation",
  components: { GuestLayout, MentorPost, ExperienceCard },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const userStore = useUser();
    const selectedOption = ref("profile");
    const userInfo = ref();
    const showEdit = getUserInfo()._id == props.id;

    onMounted(() => {
      getUserInformation(props.id);
    });

    const getUserInformation = (id: string) => {
      userStore.requestGetUserInfo({
        id: props.id,
        callback: {
          onSuccess: (res) => {
            userInfo.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    return {
      personLogo,
      heartLogo,
      coverImg,
      avatarImg,
      ratingLogo,
      hourLogo,
      advertisementImg,
      selectedOption,
      userInfo,
      showEdit,
    };
  },
});