import { computed, defineComponent, onMounted, ref } from "vue";
import heroImg from "@/assets/image/hero-section.png";
import MentorCard from "@/components/MentorCard/MentorCard.vue";
import MentorPost from "@/components/MentorPost/MentorPost.vue";
import MentorMarquee from "@/components/Homepage/MentorMarquee.vue";
import HiddenBackground from "@/components/Homepage/HiddenBackground.vue";
import IntroductionText from "@/components/Homepage/IntroductionText.vue";
import SearchBar from "@/components/SearchBar/SearchBar.vue";
import ProcessSection from "@/components/Homepage/ProcessSection.vue";
import { Carousel, Navigation, Slide } from "vue3-carousel";
import "vue3-carousel/dist/carousel.css";

import GuestLayout from "@/layout/GuestLayout/GuestLayout.vue";
import { useMentors } from "@/stores/mentors";
import { useBlog } from "@/stores/blog";
import SwalPopup from "@/ultils/swalPopup";
import { GetPaginationParams, Mentor } from "@/types/mentor";
import { Blog } from "@/types/blog";
import { SearchMentorsParams } from "../../types/mentor";
import { useRouter } from "vue-router";
import { Course } from "../../types/course";
import { useCourse } from "../../stores/course";
import CourseCard from "@/components/Course/CourseCard.vue";


export default defineComponent({
  name: "Home",
  components: {
    GuestLayout,
    MentorCard,
    MentorPost,
    MentorMarquee,
    SearchBar,
    HiddenBackground,
    IntroductionText,
    ProcessSection,
    Carousel,
    Slide,
    Navigation,
    CourseCard
  },
  setup() {
    const router = useRouter();
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const mentors = ref<Mentor[]>([]);
    const blogs = ref<Blog[]>([]);
    const isLoadingMentor = ref(false);
    const isLoadingBlog = ref(false);
    const courses = ref<Course[]>([]);
    const totalCourses = ref(0);

    const searchValue = ref<SearchMentorsParams>({
      page: 1,
      name: "",
      expertise: "",
      limit: 8,
    });

    onMounted(() => {
      getMentors();
      getBlogs();
      getCourses();
    });

    const getMentors = () => {
      isLoadingMentor.value = true;
      mentorsStore.requestGetMentors({
        params: { page: 1, limit: 8 } as GetPaginationParams,
        callback: {
          onSuccess: (res: any) => {
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
          onSuccess: (res: any) => {
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

    const getCourses = () => {
      useCourse().requestGetAllCourses({
        params: {
          page: 1,
          limit: 100,
        } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            courses.value = res.courses;
            totalCourses.value = res.count;
          },
          onFailure: () => {
            console.log("err");
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
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

    const settings = {
      itemsToShow: 1,
      snapAlign: "center",
    };

    const breakpoints = {
      // 700px and up
      700: {
        itemsToShow: 2.5,
        snapAlign: "center",
      },
      // 1024 and up
      1024: {
        itemsToShow: 4,
        snapAlign: "start",
      },
    };

    return {
      heroImg,
      mentors,
      blogs,
      isLoadingBlog,
      isLoadingMentor,
      searchValue,
      getSearchParams,
      settings,
      breakpoints,
      courses,
      totalCourses,
      router,
    };
  },
});
