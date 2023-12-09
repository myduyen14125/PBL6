import { defineComponent, ref } from "vue";
import BModal from "../../BUI/BModal/BModal.vue";

export default defineComponent({
  name: "AvatarModal",
  components: { BModal },
  props: {
    avatar: {
      type: String,
      required: true,
      default: "",
    },
  },
  emits: ["updated"],
  setup(props, { emit }) {
    const modal = ref(false);
    const isSubmitting = ref(false);

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
    };

    const updateAvatar = () => {
      emit("updated", "");
      hide();
    };

    return {
      modal,
      isSubmitting,
      show,
      hide,
      updateAvatar,
    };
  },
});
