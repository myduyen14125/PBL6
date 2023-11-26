import { computed, defineComponent, onMounted, ref } from "vue";
import heroImg from "@/assets/image/hero-section.png";
import MentorCard from "@/components/MentorCard/MentorCard.vue";
import MentorPost from "@/components/MentorPost/MentorPost.vue";
import MentorMarquee from "@/components/Homepage/MentorMarquee.vue";
import HiddenBackground from "@/components/Homepage/HiddenBackground.vue";
import IntroductionText from "@/components/Homepage/IntroductionText.vue";
import SearchBar from "@/components/SearchBar/SearchBar.vue";
import ProcessSection from "@/components/Homepage/ProcessSection.vue";

import GuestLayout from "@/layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "@/stores/mentors";
import { useBlog } from "@/stores/blog";
import SwalPopup from "@/ultils/swalPopup";
import { GetPaginationParams, Mentor } from "@/types/mentor";
import { Blog } from "@/types/blog";
import { SearchMentorsParams } from "../../types/mentor";
import router from "../../router";

export default defineComponent({
  name: "Home",
  components: { GuestLayout, MentorCard, MentorPost, MentorMarquee, SearchBar, HiddenBackground, IntroductionText, ProcessSection },
  setup() {
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const mentors = ref<Mentor[]>([]);
    const blogs = ref<Blog[]>([]);
    const isLoadingMentor = ref(false);
    const isLoadingBlog = ref(false);
    const searchValue = ref<SearchMentorsParams>({
      page: 1,
      name: "",
      expertise: "",
      limit: 8,
    });

    onMounted(() => {
      getMentors();
      getBlogs();
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

    const getSearchParams = (params: SearchMentorsParams) => {
      searchValue.value = {
        ...searchValue.value,
        ...params,
        page: 1,
      };
      router.push(`/mentors`);
    };

    return {
      heroImg,
      mentors,
      blogs,
      isLoadingBlog,
      isLoadingMentor,
      searchValue,
      getSearchParams,
    };
  },
});
