import { defineComponent, onMounted, ref } from "vue";
import heroImg from "../../assets/image/hero-section.png";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "../../stores/mentors";
import { useBlog } from "./../../stores/blog";
import SwalPopup from "../../ultils/swalPopup";

export default defineComponent({
  name: "Home",
  components: { GuestLayout, MentorCard, MentorPost },
  setup() {
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const mentors = ref([]);
    const blogs = ref([]);
    const isLoadingMentor = ref(false);
    const isLoadingBlog = ref(false);

    onMounted(() => {
      getAllMentors();
      getAllBlogs();
    });

    const getAllMentors = () => {
      isLoadingMentor.value = true;
      mentorsStore.requestGetAllMentors({
        callback: {
          onSuccess: (res) => {
            isLoadingMentor.value = false;
            mentors.value = res.slice(0, 8);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingMentor.value = false;
          },
        },
      });
    };

    const getAllBlogs = () => {
      isLoadingBlog.value = true;
      blogStore.requestGetAllBlogs({
        callback: {
          onSuccess: (res) => {
            isLoadingBlog.value = false;
            blogs.value = res.slice(0, 3);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingBlog.value = false;
          },
        },
      });
    };

    return { heroImg, mentors, blogs, isLoadingBlog, isLoadingMentor };
  },
});
