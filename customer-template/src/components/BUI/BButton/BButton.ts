import { defineComponent, type PropType } from "vue";

export default defineComponent({
  name: "BButton",
  props: {
    label: String,
    labelIsLoading: String,
    isLoading: {
      type: Boolean,
      default: false,
    },
    classes: {
      type: String,
      default: "",
    },
    typeButton: {
      type: String as PropType<"button" | "submit" | "reset" | undefined>,
      default: "",
    },
  },
  emits: ["click"],
  setup(props, { emit }) {
    const onClick = (event: any): void => {
      emit("click", event);
    };

    return {
      onClick,
    };
  },
});
