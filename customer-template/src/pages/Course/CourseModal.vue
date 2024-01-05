<template>
  <BModal
    v-model:modal="modal"
    id="course_modal"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:header>
      <div class="d-flex align-items-center w-100">
        <h5 class="modal-title">
          {{ data ? "Chỉnh sửa khóa học" : "Thêm khóa học" }}
        </h5>
        <span class="cursor-pointer ml-auto" @click="hide">
          <SvgIcon icon="closeModal" />
        </span>
      </div>
    </template>
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
        <div class="flex items-start">
          <div className="form-group required mb-3 w-1/2">
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
          <div className="form-group mb-3 w-1/2 ml-4">
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
        </div>
        <div className="form-group required mb-3">
          <p class="label">Ảnh bìa</p>
          <div class="p-3 avatar-img" @click="clickInputFile">
            <img
              :src="
                form?.image ||
                fileImage ||
                'https://montevista.greatheartsamerica.org/wp-content/uploads/sites/2/2016/11/default-placeholder.png'
              "
              style="width: 100%; height: 300px; object-fit: cover"
              alt="avatar"
              ref="avatarSrc"
            />
            <SvgIcon class="cameraIcon" icon="cameraIcon" />
            <input
              ref="fileRef"
              class="cameraInput"
              type="file"
              id="avatar"
              name="avatar"
              accept="image/*"
              @change="toggleAvatar"
            />
          </div>
          <p v-if="error.image" class="error-message mt-1">
            {{ error.image }}
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
  <AvatarModal
    ref="avatarModal"
    @updated="uploadAvatar"
    :avatar="getAvatar()"
  />
</template>
<script lang="ts">
import { useCourse } from "../../stores/course";
import { useMedia } from "../../stores/media";
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
  image: string | null;
}

export default defineComponent({
  name: "CourseModal",
  components: { BModal, BButton, SvgIcon, AvatarModal },
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
    const courseStore = useCourse();
    const mediaStore = useMedia();

    const initialForm: Form = {
      price: "",
      description: "",
      title: "",
      discount: "",
      image: null,
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
    const fileImage = ref<any>(null);
    const fileRef: Ref<HTMLDivElement | null> = ref(null);
    const avatarModal: Ref<any> = ref<typeof AvatarModal | null>(null);

    watch(modal, () => {
      if (modal.value == true && props?.data) {
        form.value = {
          price: props?.data?.price,
          title: props?.data?.title,
          description: props?.data?.description,
          discount: props?.data?.discount,
          image: props?.data?.image,
        };
      }
    });

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      resetData();
      modal.value = false;
    };

    const resetData = () => {
      fileImage.value = null;
      fileRef.value = null;
      form.value = {
        price: "",
        description: "",
        title: "",
        discount: "",
        image: "",
      };
      error.value = {
        price: "",
        description: "",
        title: "",
        discount: "",
        image: "",
      };
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
        image: form.value.image ? form.value.image : "",
      };

      if (props?.data) {
        updateCourse(params);
      } else {
        createCourse(params);
      }
    };

    const createCourse = (params: CreateCourseParams) => {
      isSubmitting.value = true;
      courseStore.requestCreateCourse({
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
      courseStore.requestUpdateCourse({
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
      if (fileRef.value) {
        fileRef.value.click();
      }
    };

    const toggleAvatar = (e: any): void => {
      const avatar = e.target.files[0];
      if (!avatar) return;
      fileImage.value = avatar;
      avatarModal?.value?.show();
    };

    const uploadAvatar = () => {
      form.value.image = URL.createObjectURL(fileImage.value);

      mediaStore.requestUploadMedia({
        file: fileImage.value,
        callback: {
          onSuccess: (res) => {
            form.value.image = res.url;
          },
          onFailure: (res) => {
            form.value.image = res.url;
            // SwalPopup.swalResultPopup(
            //   "Sorry, looks like there are some errors detected, please try again.",
            //   "error"
            // );
          },
        },
      });
    };

    const getAvatar = () => {
      if (fileImage.value) {
        return URL.createObjectURL(fileImage.value);
      }
      return "";
    };

    return {
      form,
      error,
      modal,
      isSubmitting,
      avatarModal,
      submitForm,
      validateRequired,
      show,
      hide,
      clickInputFile,
      fileImage,
      toggleAvatar,
      uploadAvatar,
      getAvatar,
      fileRef,
    };
  },
});
</script>

<style scoped>
.avatar-img {
  position: relative;
}

.avatar-img:hover .cameraIcon {
  display: block;
}

.avatar-img img {
  cursor: pointer;
}

.avatar-img .cameraIcon {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: none;
  cursor: pointer;
}

.avatar-img .cameraInput {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: none;
  cursor: pointer;
}
</style>
