import { defineComponent, onMounted, ref } from "vue";
import heroImg from "../../assets/image/hero-section.png";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "../../stores/mentors";
import SwalPopup from "../../ultils/swalPopup";

export default defineComponent({
  name: "Home",
  components: { GuestLayout, MentorCard, MentorPost },
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

    return { heroImg, mentors };
  },
});
