import { hideModal } from "../../../ultils/helpers/modal";
import { Modal } from "bootstrap";
import {
  computed,
  defineComponent,
  ref,
  watch,
  type WritableComputedRef,
} from "vue";

export default defineComponent({
  name: "BModal",
  props: {
    modal: Boolean,
    id: String,
    title: String,
    size: {
      type: String,
      default: "md",
    },
    animation: {
      type: String,
      default: "fade",
    },
    noCloseOnBackdrop: {
      type: Boolean,
      default: false,
    },
  },
  emits: ["update:modal"],
  setup(props, { emit }) {
    const newTargetModalRef = ref<null | HTMLElement>(null);
    const isShowModal: WritableComputedRef<boolean> = computed({
      get(): boolean {
        return props.modal;
      },
      set(value: boolean): void {
        emit("update:modal", value);
      },
    });

    watch(isShowModal, (now: any, prev: any) => {
      if (now == prev) {
        return;
      }
      if (isShowModal.value == true) {
        show();
      } else {
        hide();
      }
    });

    const show = () => {
      const config: Modal.Options = {
        backdrop: props.noCloseOnBackdrop == true ? "static" : true,
        keyboard: false,
        focus: false,
      };
      const modal = new Modal(newTargetModalRef.value as Element, config);
      modal.show();

      newTargetModalRef.value?.addEventListener("hidden.bs.modal", () => {
        isShowModal.value = false;
      });
    };

    const hide = () => {
      isShowModal.value = false;
      hideModal(newTargetModalRef.value);
    };

    return {
      newTargetModalRef,
      isShowModal,
      show,
      hide,
    };
  },
});
