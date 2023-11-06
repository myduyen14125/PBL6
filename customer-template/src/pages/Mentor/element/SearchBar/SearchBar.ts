import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import { ref, defineComponent } from "vue";
export default defineComponent({
  name: "SearchBar",
  components: {
    SvgIcon,
  },
  emits: ["clickSearch"],
  setup(props, { emit }) {
    // Define reactive data properties using ref()
    const showLocationSelector = ref(false);
    const showMajorDropdown = ref(false);
    const locations = ref(["Đà Nẵng", "Hà Nội", "Hồ Chí Minh"]);
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
    const chosenLocation = ref("");
    const searchText = ref("");

    // Define methods
    const toggleLocationSelector = () => {
      showLocationSelector.value = !showLocationSelector.value;
    };

    const selectLocation = (location: any) => {
      chosenLocation.value = location;
      showLocationSelector.value = false;
    };

    const selectPosition = (major: any) => {
      searchText.value = major;
      showMajorDropdown.value = false;
    };

    const onSearchMentor = () => {
      // Call your API here with the necessary parameters
      const searchParams = {
        keyword: searchText.value,
        location: chosenLocation.value,
      };

      emit("clickSearch", searchText.value);
    };

    return {
      showLocationSelector,
      showMajorDropdown,
      locations,
      positions,
      chosenLocation,
      searchText,
      toggleLocationSelector,
      selectLocation,
      selectPosition,
      onSearchMentor,
    };
  },
});
