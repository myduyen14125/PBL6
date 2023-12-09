<template>
  <BModal v-model:modal="modal" id="course_modal" :title="data ? 'Chỉnh sửa khóa học' : 'Thêm khóa học'" size="lg"
    animation="fade" :noCloseOnBackdrop="true">
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên khóa học</p>
          <input type="text" v-model="form.title" name="title" :className="['form-control', error.title ? 'is-invalid' : '']
            .filter(Boolean)
            .join(' ')
            " placeholder="Nhập tên khóa học" @blur="validateRequired('title')" />
          <p v-if="error.title" class="error-message mt-1">
            {{ error.title }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Mô tả khóa học</p>
          <textarea rows="4" v-model="form.description" name="title" :className="['form-control', error.description ? 'is-invalid' : '']
            .filter(Boolean)
            .join(' ')
            " placeholder="Nhập mô tả khóa học" @blur="validateRequired('description')" />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
        </div>
        <div class="flex items-start">
          <div className="form-group required mb-3 w-1/2">
            <p class="label">Giá tiền</p>
            <input type="number" v-model="form.price" name="title" :className="['form-control', error.price ? 'is-invalid' : '']
              .filter(Boolean)
              .join(' ')
              " placeholder="Nhập giá khóa học" @blur="validateRequired('price')" />
            <p v-if="error.price" class="error-message mt-1">
              {{ error.price }}
            </p>
          </div>
          <div className="form-group mb-3 w-1/2 ml-4">
            <p class="label">Giá khuyến mãi</p>
            <input type="number" v-model="form.discount" name="title" :className="['form-control', error.discount ? 'is-invalid' : '']
              .filter(Boolean)
              .join(' ')
              " placeholder="Nhập giá khuyến mãi" />
            <p v-if="error.discount" class="error-message mt-1">
              {{ error.discount }}
            </p>
          </div>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Ảnh bìa</p>
          <input type="text" v-model="form.image" name="title" :className="['form-control', error.image ? 'is-invalid' : '']
            .filter(Boolean)
            .join(' ')
            " placeholder="Nhập link ảnh bìa" @blur="validateRequired('image')" />
          <div class="p-3 avatar-img" @click="clickInputFile">
            <img :src="data?.avatar || fileImage" alt="avatar" ref="avatarSrc" />
            <SvgIcon v-if="showEdit" class="cameraIcon" icon="cameraIcon" />
            <input v-if="showEdit" ref="fileRef" class="cameraInput" type="file" id="avatar" name="avatar"
              accept="image/*" @change="toggleAvatar" />
          </div>
          <p v-if="error.image" class="error-message mt-1">
            {{ error.image }}
          </p>
        </div>

      </form>
    </template>
    <template v-slot:footer>
      <BButton typeButton="submit" classes="btn btn-primary px-5" label="Lưu" @click="submitForm"
        :isLoading="isSubmitting" />
    </template>
  </BModal>
</template>
<script lang="ts">
import { useCourse } from "../../stores/course";
import { ref, defineComponent, watch, onMounted, type Ref } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import { PropType } from "vue";
import BModal from "../../components/BUI/BModal/BModal.vue";
import BButton from "../../components/BUI/BButton/BButton.vue";
import { validate } from "../../ultils/validators";
import { CreateCourseParams } from "../../types/course";
import SwalPopup from "../../ultils/swalPopup";
import AvatarModal from "../../components/Modal/AvatarModal/AvatarModal.vue";

interface Form {
  price: string;
  title: string;
  description: string;
  discount: string;
  image: string;
}

export default defineComponent({
  name: "CourseModal",
  components: { BModal, BButton, SvgIcon },
  props: {
    course: {
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
    const bioStore = useCourse();
    const initialForm: Form = {
      price: "",
      description: "",
      title: "",
      discount: "",
      image: "",
    };
    const initialError: Form = {
      price: "",
      title: "",
      description: "",
      discount: "",
      image: "",
    };
    const form = ref<Form>(
      props.data
        ? {
          price: props?.data?.price,
          title: props?.data?.title,
          description: props?.data?.description,
          discount: props?.data?.discount,
          image: props?.data?.image,
        }
        : { ...initialForm }
    );
    const error = ref<Form>({ ...initialError });
    const isSubmitting = ref(false);
    const showEdit = false;
    const fileImage = ref<any>(null);
    const fileRef: Ref<HTMLDivElement | null> = ref(null);
    const avatarModal: Ref<any> = ref<typeof AvatarModal | null>(null);

    watch(
      () => props.data,
      (newData, oldData) => {
        form.value = {
          price: newData?.price,
          title: newData?.title,
          description: newData?.description,
          discount: newData?.discount,
          image: newData?.image,
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
      const params: CreateCourseParams = {
        title: form.value.title,
        price: parseInt(form.value.price),
        discount: parseInt(form.value.discount),
        description: form.value.description,
        image: form.value.image,
      };

      if (props?.data) {
        updateCourse(params);
      } else {
        createCourse(params);
      }
    };

    const createCourse = (params: CreateCourseParams) => {
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

    const updateCourse = (params: CreateCourseParams) => {
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

    const clickInputFile = () => {
      if (showEdit) {
        if (fileRef.value) {
          fileRef.value.click();
        }
      }
    };

    const toggleAvatar = (e: any): void => {
      const avatar = e.target.files[0];
      if (!avatar) return;
      fileImage.value = avatar;
      avatarModal?.value?.show();
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
      clickInputFile,
      fileImage,
      showEdit,
      toggleAvatar,
    };
  },
});


</script>