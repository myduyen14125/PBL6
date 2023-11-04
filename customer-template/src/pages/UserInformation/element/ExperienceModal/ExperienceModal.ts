import { createExperience } from "./../../../../api/bio";
import { useBio } from "../../../../stores/bio";
import { ref, defineComponent, watch, onMounted } from "vue";
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import coverImg from "../../../../assets/image/cover.jpg";
import { PropType } from "vue";
import { formatDate } from "../../../../ultils/date";
import BModal from "../../../../components/BUI/BModal/BModal.vue";
import BButton from "../../../../components/BUI/BButton/BButton.vue";
import { validate } from "../../../../ultils/validators";
import { PostExperienceParams } from "../../../../types/bio";
import SwalPopup from "../../../../ultils/swalPopup";

interface Form {
  position: string;
  company: string;
  date: Date[] | string[] | string;
  description: string;
}

export default defineComponent({
  name: "ExperienceModal",
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
      position: "",
      company: "",
      date: [],
      description: "",
    };
    const initialError: Form = {
      position: "",
      company: "",
      date: "",
      description: "",
    };
    const form = ref<Form>(
      props.data
        ? {
            position: props?.data?.position,
            company: props?.data?.company,
            date: [props?.data?.start_date, props?.data?.end_date],
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
          position: newData?.position,
          company: newData?.company,
          date: [newData?.start_date, newData?.end_date],
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
      arrRes.push(validateRequired("position"));
      arrRes.push(validateRequired("company"));
      arrRes.push(validateRequired("date"));
      arrRes.push(validateRequired("description"));

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = () => {
      if (!validateForm()) return;
      const params: PostExperienceParams = {
        bio: props?.bio,
        position: form.value.position,
        company: form.value.company,
        start_date: form.value.date[0],
        end_date: form.value.date[1],
        description: form.value.description,
      };

      if (props?.data) {
        updateExperience(params);
      } else {
        createExperience(params);
      }
    };

    const createExperience = (params: PostExperienceParams) => {
      isSubmitting.value = true;
      bioStore.requestCreateExperience({
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

    const updateExperience = (params: PostExperienceParams) => {
      isSubmitting.value = true;
      bioStore.requestUpdateExperience({
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
