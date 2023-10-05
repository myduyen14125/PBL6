import { defineComponent } from "vue";
import heroImg from "../../assets/image/hero-section.png";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";

export default defineComponent({
  name: "Home",
  components: { MentorCard, MentorPost },
  setup() {
    return { heroImg };
  },
});
