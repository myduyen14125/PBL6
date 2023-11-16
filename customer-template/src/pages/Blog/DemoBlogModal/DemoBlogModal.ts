import { defineComponent, ref, PropType } from "vue";
import BModal from "../../../components/BUI/BModal/BModal.vue";
import { getUserInfo } from "../../../ultils/cache/cookies";
import { formatDate } from "../../../ultils/date";
import avatar from "../../../assets/image/avatar.png";

export default defineComponent({
  name: "DemoBlogModal",
  components: { BModal },
  props: {
    blogDetail: {
      type: Object as PropType<any>,
      required: true,
    },
  },
  setup() {
    const modal = ref(false);
    const isSubmitting = ref(false);

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
    };

    return {
      avatar,
      modal,
      isSubmitting,
      show,
      hide,
      getUserInfo,
      formatDate,
    };
  },
});
