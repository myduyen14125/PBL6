import {
  defineComponent,
  onMounted,
  ref,
  onBeforeUnmount,
  type PropType,
} from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import icMentee from "../../assets/image/ic-mentee.png";
import icFollowed from "../../assets/image/followed.png";
import router from "../../router";
import { Blog } from "../../types/blog";

export default defineComponent({
  name: "MentorCard",
  components: { SvgIcon },
  props: {
    mentor: {
      type: Object as PropType<Blog>,
      required: true,
      default: () => ({}),
    },
    hover: {
      type: Boolean,
      required: false,
      default: true,
    },
  },
  setup(props) {
    const isTooltipRight = ref(true);
    const tooltipContainer = ref<HTMLElement | null>(null);

    onMounted(() => {
      checkTooltipPosition();
      if (props.hover) {
        window.addEventListener("resize", checkTooltipPosition);
      }
    });

    onBeforeUnmount(() => {
      if (props.hover) {
        window.removeEventListener("resize", checkTooltipPosition);
      }
    });

    const checkTooltipPosition = (): void => {
      const hoverTooltipRect =
        tooltipContainer?.value?.getBoundingClientRect().right;
      const tooltipRect = hoverTooltipRect! + 250;

      if (tooltipRect > window.innerWidth) {
        isTooltipRight.value = false;
      } else {
        isTooltipRight.value = true;
      }
    };

    return {
      avatar,
      icMentee,
      icFollowed,
      tooltipContainer,
      isTooltipRight,
      router,
    };
  },
});
