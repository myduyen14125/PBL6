import { defineComponent, ref } from "vue";
import personLogo from '../../../assets/image/ic-mentee.png';
import heartLogo from '../../../assets/image/followed.png';
import ratingLogo from '../../../assets/image/rating.png';
import hourLogo from '../../../assets/image/hour.png';
import coverImg from '../../../assets/image/cover.jpg';
import avatarImg from '../../../assets/image/cover.jpg';
import advertisementImg from '../../../assets/image/advertisement.jpg';
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";


export default defineComponent({
  name: "MentorInformation",
  components: { GuestLayout },
  setup() {
    const selectedOption = ref("profile"); 

    return {
        personLogo,
        heartLogo,
        coverImg,
        avatarImg,
        ratingLogo,
        hourLogo,
        advertisementImg,
        selectedOption,
    };
  },
});
