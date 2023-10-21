import { defineComponent, onMounted, ref } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SwalPopup from "../../ultils/swalPopup";
import { useUser } from "../../stores/user";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import { getUserInfo } from "../../ultils/cache/localStorage";
import { User } from "../../types/auth";
import { Blog } from "../../types/blog";

export default defineComponent({
  name: "MyBlog",
  components: { GuestLayout, MentorPost },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const userStore = useUser();
    const isLoadingBlog = ref(false);
    const initialUser: User = {
      email: "",
      name: "",
      address: "",
      phone: "",
      date_of_birth: "",
      gender: null,
      facebook_link: "",
      skype_link: "",
    };
    const initialBlog: Blog = {
      _id: "",
      title: "",
      content: "",
      user: "",
    };
    const userInfo = ref<User>(initialUser);
    const blogs = ref<Blog>(initialBlog);

    onMounted(() => {
      getAllBlogsByMentorId();
    });
    const getAllBlogsByMentorId = () => {
      isLoadingBlog.value = true;
      userStore.requestGetUserInfo({
        id: getUserInfo()._id,
        callback: {
          onSuccess: (res) => {
            userInfo.value = res;
            blogs.value = res.blogs;
            isLoadingBlog.value = false;
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

    return {
      getAllBlogsByMentorId,
      userInfo,
      blogs,
      isLoadingBlog,
    };
  },
});
