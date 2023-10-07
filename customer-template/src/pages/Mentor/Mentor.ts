import { defineComponent } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MajorCard from "../../components/MajorCard/MajorCard.vue";
import SearchBar from "./element/SearchBar.vue";
import { mentors, majors } from "../../mockData";
import imageSaler from "../../assets/image/saler.png";


export default defineComponent({
  name: "Mentor",
  components: { GuestLayout, MentorCard, SearchBar, MajorCard },
  setup() {
    return {
      mentors, majors, imageSaler
    };
  },
});
