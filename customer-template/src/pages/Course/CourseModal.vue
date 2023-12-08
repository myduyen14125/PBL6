<template>
  <BModal
    v-model:modal="modal"
    id="course_modal"
    :title="data ? 'Chỉnh sửa khóa học' : 'Thêm khóa học'"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên khóa học</p>
          <input
            type="text"
            v-model="form.title"
            name="title"
            :className="
              ['form-control', error.title ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập tên khóa học"
            @blur="validateRequired('title')"
          />
          <p v-if="error.title" class="error-message mt-1">
            {{ error.title }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Mô tả khóa học</p>
          <textarea
            rows="4"
            v-model="form.description"
            name="title"
            :className="
              ['form-control', error.description ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập mô tả khóa học"
            @blur="validateRequired('description')"
          />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Giá tiền</p>
          <input
            type="number"
            v-model="form.price"
            name="title"
            :className="
              ['form-control', error.price ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập giá khóa học"
            @blur="validateRequired('price')"
          />
          <p v-if="error.price" class="error-message mt-1">
            {{ error.price }}
          </p>
        </div>
        <div className="form-group mb-3">
          <p class="label">Giá khuyến mãi</p>
          <input
            type="number"
            v-model="form.discount"
            name="title"
            :className="
              ['form-control', error.discount ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập giá khuyến mãi"
          />
          <p v-if="error.discount" class="error-message mt-1">
            {{ error.discount }}
          </p>
        </div>

      </form>
    </template>
    <template v-slot:footer>
      <BButton
        typeButton="submit"
        classes="btn btn-primary px-5"
        label="Lưu"
        @click="submitForm"
        :isLoading="isSubmitting"
      />
    </template>
  </BModal>
</template>
<script lang="ts">
import { useBio } from "../../stores/bio";
import { ref, defineComponent, watch, onMounted } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import { PropType } from "vue";
import BModal from "../../components/BUI/BModal/BModal.vue";
import BButton from "../../components/BUI/BButton/BButton.vue";
import { validate } from "../../ultils/validators";
import { EducationParams } from "../../types/bio";
import SwalPopup from "../../ultils/swalPopup";

interface Form {
  price: string;
  title: string;
  description: string;
  discount: string;
}

export default defineComponent({
  name: "CourseModal",
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
      price: "",
      description: "",
      title: "",
      discount: "",
    };
    const initialError: Form = {
      price: "",
      title: "",
      description: "",
      discount: "",
    };
    const form = ref<Form>(
      props.data
        ? {
            price: props?.data?.price,
            title: props?.data?.title,
            description: props?.data?.description,
            discount: props?.data?.discount,
          }
        : { ...initialForm }
    );
    const error = ref<Form>({ ...initialError });
    const isSubmitting = ref(false);

    watch(
      () => props.data,
      (newData, oldData) => {
        form.value = {
          price: newData?.price,
          title: newData?.title,
          description: newData?.description,
          discount: newData?.discount,
        };
      }
    );

    const show = () => {
      console.log("show modal")
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
      return true;
    };

    const submitForm = () => {
      if (!validateForm()) return;
      const params: EducationParams = {
        bio: props?.bio,
        title: form.value.title,
        price: form.value.price,
        discount: form.value.discount,
        description: form.value.description,
      };

      if (props?.data) {
        updateExperience(params);
      } else {
        createExperience(params);
      }
    };

    const createExperience = (params: EducationParams) => {
      isSubmitting.value = true;
      bioStore.requestCreateEducation({
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

    const updateExperience = (params: EducationParams) => {
      isSubmitting.value = true;
      bioStore.requestUpdateEducation({
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


</script>