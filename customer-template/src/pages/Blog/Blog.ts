import { defineComponent, ref, onMounted } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import wallPaper from "../../assets/image/blog-cover.jpg";
import advertisementImg from "../../assets/image/advertisement.jpg";
import avatar from "../../assets/image/avatar.png";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import { useBlog } from "./../../stores/blog";
import { useMentors } from "./../../stores/mentors";
import SwalPopup from "../../ultils/swalPopup";
import { useRouter } from "vue-router";
import { Blog } from "../../types/blog";
import { GetPaginationParams, Mentor } from "../../types/mentor";

export default defineComponent({
  name: "Blog",
  components: { GuestLayout, MentorPost },
  setup() {
    const router = useRouter();
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const blogs = ref<Blog[]>([]);
    const mentors = ref<Mentor[]>([]);
    const isLoadingBlogs = ref(false);
    const currentPage = ref(1);
    const totalElement = ref(0);
    const limit = 8;

    onMounted(() => {
      getBlogs();
      getMentors();
    });

    const getBlogs = () => {
      isLoadingBlogs.value = true;

      blogStore.requestGetBlogs({
        params: {
          page: currentPage.value,
          limit: limit,
        } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            blogs.value = res.blogs;
            totalElement.value = res.count;
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
        params: { page: 1, limit: 5 } as GetPaginationParams,
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
      currentPage,
      totalElement,
      limit,
      getBlogs,
    };
  },
});
