import { defineComponent, computed } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import postImg from "../../assets/image/post-img.png";
import { formatDate } from "../../ultils/date";
import { useRouter } from "vue-router";
import { getUserInfo } from "../../ultils/cache/cookies";
import { VideoPlayer } from "@videojs-player/vue";
import SwalPopup from "../../ultils/swalPopup";

export default defineComponent({
  name: "LessonCard",
  components: { SvgIcon, VideoPlayer },
  emits: ["deleteLesson", "editLesson"],
  props: {
    lesson: {
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
    const router = useRouter();

    const deleteLesson = () => {
      SwalPopup.swalDeletePopup(
        "",
        {
          onConfirmed: () => {
            emit("deleteLesson", props.lesson?._id);
          },
        },
        {
          html:
            "Bạn có chắc chắn xóa khóa học " +
            `<span class="color-primary">${props?.lesson?.title}</span>` +
            " ?",
        }
      );
    };

    const editLesson = () => {
      emit("editLesson", props.lesson);
    };

    // Compute the content of the first <p> tag in the lesson content
    const demoContent = computed(function () {
      if (props.lesson?.content) {
        const div = document.createElement("div");
        div.innerHTML = props.lesson?.content;
        const firstParagraph = div.querySelector("p");
        return firstParagraph
          ? firstParagraph.innerHTML
          : props.lesson?.content;
      }
      return "";
    });

    return {
      avatar,
      postImg,
      router,
      formatDate,
      getUserInfo,
      deleteLesson,
      editLesson,
      demoContent,
    };
  },
});
