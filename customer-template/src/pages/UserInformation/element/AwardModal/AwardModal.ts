import BModal from "../../../../components/BUI/BModal/BModal.vue";
import BButton from "../../../../components/BUI/BButton/BButton.vue";
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import { ref, defineComponent, watch } from "vue";
import { useBio } from "../../../../stores/bio";
import { validate } from "../../../../ultils/validators";
import { AwardParams } from "../../../../types/bio";
import SwalPopup from "../../../../ultils/swalPopup";
import { PropType } from "vue";
import { isDateBeforeToday } from "../../../../ultils/date";

interface Form {
  name: string;
  date: Date | string;
  description: string;
}

export default defineComponent({
  name: "AwardModal",
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
      date: "",
      description: "",
    };
    const initialError: Form = {
      name: "",
      date: "",
      description: "",
    };
    const form = ref<Form>(
      props.data
        ? {
            name: props?.data?.name,
            date: props?.data?.date,
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
          date: newData?.date,
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
      arrRes.push(validateRequired("date"));
      arrRes.push(validateRequired("description"));

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = () => {
      if (!validateForm()) return;
      const params: AwardParams = {
        bio: props?.bio,
        name: form.value.name,
        date: form.value.date,
        description: form.value.description,
      };

      if (props?.data) {
        updateAward(params);
      } else {
        createAward(params);
      }
    };

    const createAward = (params: AwardParams) => {
      isSubmitting.value = true;
      bioStore.requestCreateAward({
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

    const updateAward = (params: AwardParams) => {
      isSubmitting.value = true;
      bioStore.requestUpdateAward({
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
      isDateBeforeToday,
    };
  },
});
