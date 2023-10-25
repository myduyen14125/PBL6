import { defineComponent, onMounted, ref, watch } from "vue";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import { useBlog } from "../../../stores/blog";
import { CreateBlogParams } from "../../../types/blog";
import SwalPopup from "../../../ultils/swalPopup";
import { validate } from "../../../ultils/validators";
import Swal from "sweetalert2";

export default defineComponent({
  name: "CreateBlog",
  components: { GuestLayout, QuillEditor },
  props: {
    id: {
      type: String,
      required: false,
      default: "",
    },
  },
  setup(props) {
    const blogStore = useBlog();
    const form = ref<CreateBlogParams>({
      title: "",
      content: "",
      image: "",
    });
    const error = ref<CreateBlogParams>({
      title: "",
      content: "",
    });
    const isSubmitting = ref(false);
    const myEditor = ref();

    onMounted(() => {
      if (props?.id) {
        getBlogDetail();
      }
    });

    watch(
      () => props.id,
      () => {
        getBlogDetail();
      }
    );

    const resetData = () => {
      form.value = {
        title: "",
        content: "",
      };

      error.value = {
        title: "",
        content: "",
      };

      myEditor.value?.setHTML("");
    };

    const validateRequired = (fieldName: keyof CreateBlogParams): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      error.value[fieldName] = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateRequired("title"));
      arrRes.push(validateRequired("content"));

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const getBlogDetail = () => {
      blogStore.requestGetBlogById({
        id: props?.id,
        callback: {
          onSuccess: (res) => {
            form.value.content = res?.content;
            form.value.title = res?.title;
            myEditor.value?.setHTML(form.value.content);
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

    const submitContent = () => {
      if (!validateForm()) return;
      if (props?.id) {
        editBlog();
      } else {
        createBlog();
      }
    };

    const createBlog = () => {
      isSubmitting.value = true;

      blogStore.requestCreateBlog({
        params: form.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            showToast(`/blogs/${res?._id}`);
            resetData();
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isSubmitting.value = false;
          },
        },
      });
    };

    const editBlog = () => {
      isSubmitting.value = true;

      blogStore.requestUpdateBlog({
        id: props?.id,
        params: form.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            showToast(`/blogs/${props?.id}`);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isSubmitting.value = false;
            getBlogDetail();
          },
        },
      });
    };

    const showToast = (link: string) => {
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.addEventListener("mouseenter", Swal.stopTimer);
          toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
      });

      Toast.fire({
        icon: "success",
        title: props?.id
          ? "Chỉnh sửa bài viết thành công"
          : "Tạo bài viết thành công.",
        html:
          "Bấm vào " +
          `<a class="color-primary" href="${link}">link</a> ` +
          " này để xem bài viết.",
      });
    };

    return {
      form,
      error,
      isSubmitting,
      myEditor,
      submitContent,
      validateRequired,
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
