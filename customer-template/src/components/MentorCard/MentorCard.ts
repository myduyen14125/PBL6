import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import icMentee from "../../assets/image/ic-mentee.png";
import icFollowed from "../../assets/image/followed.png";

export default defineComponent({
  name: "MentorCard",
  components: { SvgIcon },
  props: {
    // props mentor with this attributes:
    // name: "Tran Thi Nga",
    // description: "Sinh viên tại DUT University. ",
    // avatar: "https://picsum.photos/200/300",
    // numberOfMentees: 12,
    // numberOfLikes: 100,
    // freeTime: "14:30, Monday"
    mentor: {
      type: Object,
      required: true,
      default: () => ({
      }),
    },
  },
  setup() {
    const isTooltipRight = ref(true);
    const tooltipContainer = ref<HTMLElement | null>(null);

    onMounted(() => {
      checkTooltipPosition();
      window.addEventListener("resize", checkTooltipPosition);
    });

    onBeforeUnmount(() => {
      window.removeEventListener("resize", checkTooltipPosition);
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
    };
  },
});
