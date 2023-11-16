import { defineComponent, ref, onMounted } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MajorCard from "../../components/MajorCard/MajorCard.vue";
import SearchBar from "./element/SearchBar/SearchBar.vue";
import { majors } from "../../mockData";
import imageSaler from "../../assets/image/saler.png";
import { useMentors } from "../../stores/mentors";
import SwalPopup from "../../ultils/swalPopup";
import { Mentor, SearchMentorsParams } from "../../types/mentor";

export default defineComponent({
  name: "Mentor",
  components: { GuestLayout, MentorCard, SearchBar, MajorCard },
  setup() {
    const mentorsStore = useMentors();
    const mentors = ref<Mentor[]>([]);
    const isLoading = ref(false);
    const totalElement = ref(0);
    const limit = 8;
    const searchValue = ref<SearchMentorsParams>({
      page: 1,
      name: "",
      expertise: "",
      limit: limit,
    });

    onMounted(() => {
      searchMentor();
    });

    const searchMentor = () => {
      isLoading.value = true;
      mentorsStore.requestGetSearchMentor({
        params: searchValue.value,
        callback: {
          onSuccess: (res) => {
            isLoading.value = false;
            mentors.value = res.mentors;
            totalElement.value = res.count;
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

    const getSearchParams = (params: SearchMentorsParams) => {
      searchValue.value = {
        ...searchValue.value,
        ...params,
        page: 1,
      };
      searchMentor();
    };

    return {
      mentors,
      majors,
      imageSaler,
      limit,
      totalElement,
      isLoading,
      searchValue,
      searchMentor,
      getSearchParams,
    };
  },
});
