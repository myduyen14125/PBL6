import { defineComponent, ref, onMounted } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MajorCard from "../../components/MajorCard/MajorCard.vue";
import SearchBar from "./element/SearchBar.vue";
import { majors } from "../../mockData";
import imageSaler from "../../assets/image/saler.png";
import { useMentors } from "../../stores/mentors";
import SwalPopup from "../../ultils/swalPopup";

export default defineComponent({
  name: "Mentor",
  components: { GuestLayout, MentorCard, SearchBar, MajorCard },
  setup() {
    const mentorsStore = useMentors();
    const mentors = ref([]);

    onMounted(() => {
      getAllMentors();
    });

    const getAllMentors = () => {
      mentorsStore.requestGetAllMentors({
        callback: {
          onSuccess: (res) => {
            mentors.value = res;
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
      mentors,
      majors,
      imageSaler,
    };
  },
});
