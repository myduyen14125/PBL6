import { defineComponent, onMounted, ref } from "vue";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import { useBlog } from "../../../stores/blog";
import { CreateBlogParams } from "../../../types/blog";
import router from "../../../router";
import { RouterNameEnum } from "../../../constants/routeName";
import SwalPopup from "../../../ultils/swalPopup";

export default defineComponent({
  name: "CreateBlog",
  components: { GuestLayout, QuillEditor },

  setup() {
    const authStore = useBlog();
    const content = ref("");
    const title = ref("");
    const initialData: CreateBlogParams = {
      title: "",
      content: "",
    };

    const initialError: CreateBlogParams = {
      title: "",
      content: "",
    };
    onMounted(() => {});

    const submitContent = () => {
      console.log(content.value);
      console.log(title.value);

      authStore.requestCreateBlog({
        params: [title, content],
        callback: {
          onSuccess: (res) => {
            router.push({ name: RouterNameEnum.Home });
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
      title,
      content,
      submitContent,
      editorToolbar: "full",
      editorOptions: {
        modules: {
          toolbar: {
            // Configure your toolbar options here
            essential: [
              [{ header: [1, 2, 3, 4, 5, 6, false] }],
              ["bold", "italic", "underline"],
              [{ list: "ordered" }, { list: "bullet" }, { align: [] }],
              ["blockquote", "code-block", "link"],
              [{ color: [] }, "clean"],
            ],
            minimal: [
              [{ header: 1 }, { header: 2 }],
              ["bold", "italic", "underline"],
              [{ list: "ordered" }, { list: "bullet" }, { align: [] }],
            ],
            full: [
              ["bold", "italic", "underline", "strike"],
              ["blockquote", "code-block"],
              [{ header: 1 }, { header: 2 }],
              [{ list: "ordered" }, { list: "bullet" }],
              [{ script: "sub" }, { script: "super" }],
              [{ indent: "-1" }, { indent: "+1" }],
              [{ direction: "rtl" }],
              // [{ size: ["small", false, "large", "huge"] }],
              [{ header: [1, 2, 3, 4, 5, 6, false] }],
              [{ color: [] }, { background: [] }],
              [{ font: [] }],
              [{ align: [] }],
              ["link", "video", "image"],
              ["clean"],
            ],
          },
        },
      },
    };
  },
});
