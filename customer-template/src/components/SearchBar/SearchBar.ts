import SvgIcon from "@/components/BUI/SvgIcon/SvgIcon.vue";
import { ref, defineComponent, onMounted } from "vue";
import { useExpertise } from "@/stores/expertise";
import SwalPopup from "@/ultils/swalPopup";
import { Expertise } from "@/types/expertise";

export default defineComponent({
  name: "SearchBar",
  components: {
    SvgIcon,
  },
  emits: ["clickSearch"],
  setup(props, { emit }) {
    // Define reactive data properties using ref()
    const searchText = ref("");
    const expertiseStore = useExpertise();
    const showLocationSelector = ref(false);
    const showMajorDropdown = ref(false);
    const chosenExpertise = ref<Expertise>();
    const allExpertise: Expertise = {
      _id: "",
      name: "Tất cả",
    };
    const listExpertise = ref<Expertise[]>([allExpertise]);

    const positions = ref([
      "Frontend",
      "Backend",
      "Fullstack",
      "Mobile",
      "DevOps",
      "QA",
      "UI/UX",
      "Data Science",
    ]);

    onMounted(() => {
      getAllExpertise();
    });

    // Define methods
    const toggleLocationSelector = () => {
      showLocationSelector.value = !showLocationSelector.value;
    };

    const selectExpertise = (expertise: Expertise) => {
      chosenExpertise.value = expertise;
      onSearchMentor();
    };

    const selectPosition = (major: any) => {
      searchText.value = major;
      showMajorDropdown.value = false;
    };

    const onSearchMentor = () => {
      // Call your API here with the necessary parameters
      const searchParams = {
        name: searchText.value,
        expertise: chosenExpertise.value?._id,
      };

      emit("clickSearch", searchParams);
    };

    const getAllExpertise = () => {
      expertiseStore.requestGetAllExpertise({
        callback: {
          onSuccess: (res) => {
            listExpertise.value = [allExpertise, ...res];
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
      listExpertise,
      showLocationSelector,
      showMajorDropdown,
      positions,
      chosenExpertise,
      searchText,
      toggleLocationSelector,
      selectExpertise,
      selectPosition,
      onSearchMentor,
    };
  },
});
