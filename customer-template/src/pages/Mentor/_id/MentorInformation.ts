import { defineComponent, onMounted, ref } from "vue";
import personLogo from "../../../assets/image/ic-mentee.png";
import heartLogo from "../../../assets/image/followed.png";
import ratingLogo from "../../../assets/image/rating.png";
import hourLogo from "../../../assets/image/hour.png";
import coverImg from "../../../assets/image/cover.jpg";
import avatarImg from "../../../assets/image/cover.jpg";
import advertisementImg from "../../../assets/image/advertisement.jpg";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "../../../stores/mentors";
import SwalPopup from "../../../ultils/swalPopup";

export default defineComponent({
  name: "MentorInformation",
  components: { GuestLayout },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const mentorsStore = useMentors();
    const selectedOption = ref("profile");
    const mentorInfo = ref();

    onMounted(() => {
      console.log(props.id);
      getMentorInfo(props.id);
    });

    const getMentorInfo = (id: string) => {
      mentorsStore.requestGetMentorInfo({
        id: props.id,
        callback: {
          onSuccess: (res) => {
            console.log(res);
            mentorInfo.value = res;
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
      mentorInfo,
    };
  },
});
