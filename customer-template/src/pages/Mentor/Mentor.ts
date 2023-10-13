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
    const isLoading = ref(false);

    onMounted(() => {
      getAllMentors();
    });

    const getAllMentors = () => {
      isLoading.value = true;
      mentorsStore.requestGetAllMentors({
        callback: {
          onSuccess: (res) => {
            isLoading.value = false;
            mentors.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoading.value = false;
          },
        },
      });
    };

    const searchMentor = (name: string) => {
      isLoading.value = true;
      mentorsStore.requestGetSearchMentor({
        name: name,
        callback: {
          onSuccess: (res) => {
            isLoading.value = false;
            mentors.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoading.value = false;
          },
        },
      });
    };

    return {
      mentors,
      majors,
      imageSaler,
      searchMentor,
      isLoading,
    };
  },
});
