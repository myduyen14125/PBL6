import { defineComponent } from "vue";
import heroImg from "../../assets/image/hero-section.png";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { mentors } from "../../mockData";

export default defineComponent({
  name: "Home",
  components: { GuestLayout, MentorCard, MentorPost },
  setup() {
    return { heroImg, mentors };
  },
});
