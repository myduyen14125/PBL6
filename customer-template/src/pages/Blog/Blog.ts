import { defineComponent, ref, onMounted } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import wallPaper from "../../assets/image/blog-wallpaper.jpg";
import advertisementImg from "../../assets/image/advertisement.jpg";
import avatar from "../../assets/image/avatar.png";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import { useBlog } from "./../../stores/blog";
import { useMentors } from "./../../stores/mentors";
import SwalPopup from "../../ultils/swalPopup";
import router from "../../router";
import { Blog } from "../../types/blog";
import { GetMentorsParams } from "../../types/mentor";

export default defineComponent({
  name: "Blog",
  components: { GuestLayout, MentorPost },
  setup() {
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const blogs = ref<Blog[]>([]);
    const mentors = ref([]);
    const isLoadingBlogs = ref(false);

    onMounted(() => {
      getAllBlogs();
      getMentors();
    });

    const getAllBlogs = () => {
      isLoadingBlogs.value = true;

      blogStore.requestGetAllBlogs({
        callback: {
          onSuccess: (res) => {
            blogs.value = res;
            isLoadingBlogs.value = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingBlogs.value = false;
          },
        },
      });
    };

    const getMentors = () => {
      mentorsStore.requestGetMentors({
        params: { page: 1, limit: 5 } as GetMentorsParams,
        callback: {
          onSuccess: (res) => {
            mentors.value = res.mentors;
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
      blogs,
      wallPaper,
      isLoadingBlogs,
      advertisementImg,
      avatar,
      router,
      mentors,
    };
  },
});
