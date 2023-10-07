import { defineComponent } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import SearchBar from "./element/SearchBar.vue";
import { mentors } from "../../mockData";

export default defineComponent({
  name: "Mentor",
  components: { GuestLayout, MentorCard, SearchBar },
  setup() {
    return {
      mentors,
    };
  },
});
