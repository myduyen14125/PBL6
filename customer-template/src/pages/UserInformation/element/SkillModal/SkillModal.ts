import BModal from "../../../../components/BUI/BModal/BModal.vue";
import BButton from "../../../../components/BUI/BButton/BButton.vue";
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import { ref, defineComponent, watch, onMounted } from "vue";
import { useBio } from "../../../../stores/bio";
import { validate } from "../../../../ultils/validators";
import { SkillParams } from "../../../../types/bio";
import SwalPopup from "../../../../ultils/swalPopup";
import { PropType } from "vue";

interface Form {
  name: string;
  description: string;
}

export default defineComponent({
  name: "SkillModal",
  components: { BModal, BButton, SvgIcon },
  props: {
    bio: {
      type: String,
      required: false,
      default: "",
    },
    data: {
      type: Object as PropType<any>,
      required: false,
    },
  },

  emits: ["updatedModal"],

  setup(props, { emit }) {
    const modal = ref(false);
    const bioStore = useBio();
    const initialForm: Form = {
      name: "",
      description: "",
    };
    const initialError: Form = {
      name: "",
      description: "",
    };
    const form = ref<Form>(
      props.data
        ? {
            name: props?.data?.name,
            description: props?.data?.description,
          }
        : { ...initialForm }
    );
    const error = ref<Form>({ ...initialError });
    const isSubmitting = ref(false);

    watch(
      () => props.data,
      (newData, oldData) => {
        form.value = {
          name: newData?.name,
          description: newData?.description,
        };
      }
    );

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
      resetData();
    };

    const resetData = () => {
      form.value = { ...initialForm };
      error.value = { ...initialError };
    };

    const validateRequired = (fieldName: keyof Form): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      error.value[fieldName] = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateRequired("name"));
      arrRes.push(validateRequired("description"));

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = () => {
      if (!validateForm()) return;
      const params: SkillParams = {
        bio: props?.bio,
        name: form.value.name,
        description: form.value.description,
      };

      if (props?.data) {
        updateSkill(params);
      } else {
        createSkill(params);
      }
    };

    const createSkill = (params: SkillParams) => {
      isSubmitting.value = true;
      bioStore.requestCreateSkill({
        params: params,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            emit("updatedModal", 1);
            hide();
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

    const updateSkill = (params: SkillParams) => {
      isSubmitting.value = true;
      bioStore.requestUpdateSkill({
        id: props?.data?._id,
        params: params,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            emit("updatedModal", 1);
            hide();
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

    return {
      form,
      error,
      modal,
      isSubmitting,
      submitForm,
      validateRequired,
      show,
      hide,
    };
  },
});
