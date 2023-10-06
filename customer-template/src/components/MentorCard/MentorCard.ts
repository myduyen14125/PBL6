import { defineComponent, onMounted, ref, onBeforeUnmount } from "vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../assets/image/avatar.png";
import icMentee from "../../assets/image/ic-mentee.png";
import icFollowed from "../../assets/image/followed.png";

export default defineComponent({
  name: "MentorCard",
  components: { SvgIcon },
  setup() {
    const isTooltipRight = ref(true);
    const hoverTooltip = ref<HTMLElement | null>(null);

    onMounted(() => {
      checkTooltipPosition();
      window.addEventListener("resize", checkTooltipPosition);
    });

    onBeforeUnmount(() => {
      window.removeEventListener("resize", checkTooltipPosition);
    });

    const checkTooltipPosition = (): void => {
      const hoverTooltipRect =
        hoverTooltip?.value?.getBoundingClientRect().right;
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
      hoverTooltip,
      isTooltipRight,
    };
  },
});
