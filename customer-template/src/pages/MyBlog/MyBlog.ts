import { defineComponent, onMounted, ref } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SwalPopup from "../../ultils/swalPopup";
import { useUser } from "../../stores/user";
import { useBlog } from "../../stores/blog";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import { getUserInfo } from "../../ultils/cache/localStorage";
import { Blog } from "../../types/blog";
import { GetPaginationParams } from "../../types/mentor";
import router from "../../router";

export default defineComponent({
  name: "MyBlog",
  components: { GuestLayout, MentorPost },
  setup() {
    const userStore = useUser();
    const blogStore = useBlog();
    const isLoadingBlog = ref(false);
    const blogs = ref<Blog>();
    const currentPage = ref(1);
    const totalElement = ref(0);
    const limit = 8;

    onMounted(() => {
      getAllBlogsByMentorId();
    });

    const getAllBlogsByMentorId = () => {
      isLoadingBlog.value = true;
      userStore.requestGetUserBlogs({
        id: getUserInfo()._id,
        params: {
          page: currentPage.value,
          limit: limit,
        } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            isLoadingBlog.value = false;
            totalElement.value = res.count;
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

    const deleteBlog = (id: string, blogTitle: string) => {
      SwalPopup.swalDeletePopup(
        "",
        {
          onConfirmed: () => {
            requestDeleteBlog(id);
          },
        },
        {
          html:
            "Bạn có chắc chắn xóa bài viết " +
            `<span class="color-primary">${blogTitle}</span>` +
            " ?",
        }
      );
    };

    const editBlog = (id: string) => {
      router.push(`/edit-blog/${id}`);
    };

    const requestDeleteBlog = (id: string) => {
      blogStore.requestDeleteBlog({
        id: id,
        callback: {
          onSuccess: (res) => {
            getAllBlogsByMentorId();
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
      isLoadingBlog,
      currentPage,
      totalElement,
      limit,
      getAllBlogsByMentorId,
      deleteBlog,
      editBlog,
    };
  },
});
