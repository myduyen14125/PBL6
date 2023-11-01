import { computed, defineComponent, onMounted, ref } from "vue";
import heroImg from "../../assets/image/hero-section.png";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "../../stores/mentors";
import { useBlog } from "./../../stores/blog";
import SwalPopup from "../../ultils/swalPopup";
import { GetPaginationParams } from "../../types/mentor";

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
    const textIndex = ref(0);
    const charIndex = ref(0);
    const showCursor = ref(true);
    const textArray = ["Kết nối", "Phát triển", "Định hướng"];

    const currentText = computed(() => {
      const currentWord = textArray[textIndex.value];
      return currentWord.substring(0, charIndex.value);
    });

    onMounted(() => {
      getMentors();
      getBlogs();
      setInterval(typeText, 100);
    });

    const getMentors = () => {
      isLoadingMentor.value = true;
      mentorsStore.requestGetMentors({
        params: { page: 1, limit: 8 } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            isLoadingMentor.value = false;
            mentors.value = res.mentors;
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

    const getBlogs = () => {
      isLoadingBlog.value = true;
      blogStore.requestGetBlogs({
        params: { page: 1, limit: 3 } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            isLoadingBlog.value = false;
            blogs.value = res.blogs;
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

    const typeText = () => {
      if (charIndex.value < textArray[textIndex.value].length) {
        charIndex.value += 1;
        showCursor.value = true;
      } else {
        showCursor.value = false;
        setTimeout(() => {
          charIndex.value = 0;
          textIndex.value = (textIndex.value + 1) % textArray.length;
        }, 0); 
      }
    };

    return { heroImg, mentors, blogs, isLoadingBlog, isLoadingMentor, currentText, showCursor };
  },
});
