import { defineComponent, computed } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import postImg from "../../assets/image/post-img.png";
import { formatDate } from "../../ultils/date";
import router from "../../router";
import { getUserInfo } from "../../ultils/cache/localStorage";

export default defineComponent({
  name: "MentorPost",
  components: { SvgIcon },
  emits: ["deleteBlog", "editBlog"],
  props: {
    blog: {
      type: Object,
      required: true,
      default: () => ({}),
    },
    showEdit: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  setup(props, { emit }) {
    const deleteBlog = () => {
      emit("deleteBlog", props.blog?._id, props.blog?.title);
    };

    const editBlog = () => {
      emit("editBlog", props.blog?._id);
    };

    // Compute the content of the first <p> tag in the blog content
    const demoContent = computed(function () {
      if (props.blog?.content) {
        const div = document.createElement("div");
        div.innerHTML = props.blog?.content;
        const firstParagraph = div.querySelector("p");
        console.log(firstParagraph);
        return firstParagraph ? firstParagraph.innerHTML : props.blog?.content;
      }
      return "";
    });

    return {
      avatar,
      postImg,
      router,
      formatDate,
      getUserInfo,
      deleteBlog,
      editBlog,
      demoContent,
    };
  },
});
