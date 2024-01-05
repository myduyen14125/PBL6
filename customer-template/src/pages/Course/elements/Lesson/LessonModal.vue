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
          {{ data ? "Chỉnh sửa bài học" : "Thêm bài học" }}
        </h5>
        <span class="cursor-pointer ml-auto" @click="hide">
          <SvgIcon icon="closeModal" />
        </span>
      </div>
    </template>
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên bài học</p>
          <input
            type="text"
            v-model="form.title"
            name="title"
            :className="
              ['form-control', error.title ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập tên bài học"
            @blur="validateRequired('title')"
          />
          <p v-if="error.title" class="error-message mt-1">
            {{ error.title }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Mô tả bài học</p>
          <textarea
            rows="4"
            v-model="form.description"
            name="title"
            :className="
              ['form-control', error.description ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập mô tả bài học"
            @blur="validateRequired('description')"
          />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Ảnh bìa</p>
          <div class="p-3 avatar-img" @click="clickInputImage">
            <img
              :src="
                form?.image ||
                'https://montevista.greatheartsamerica.org/wp-content/uploads/sites/2/2016/11/default-placeholder.png'
              "
              style="width: 100%; height: 300px; object-fit: cover"
              alt="avatar"
              ref="avatarSrc"
            />
            <SvgIcon class="cameraIcon" icon="cameraIcon" />
            <input
              ref="imageRef"
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
        <div className="form-group required mb-3">
          <div
            class="d-flex flex-wrap align-item-center justify-content-between"
          >
            <p class="label">Video bài giảng</p>
            <div
              v-if="loadingVideo"
              class="spinner-border text-info me-3"
              role="status"
            >
              <span class="visually-hidden">Loading...</span>
            </div>
            <div v-else>
              <BButton
                typeButton="button"
                classes="btn btn-primary px-5"
                label="Tải video"
                @click="clickInputVideo"
                :isLoading="isSubmitting"
              />
            </div>
          </div>

          <div class="p-3 avatar-img">
            <VideoPlayer
              :src="form.video"
              controls
              :loop="false"
              :volume="0.6"
              :width="640"
              :height="360"
              style="width: 100%; height: 300px; object-fit: cover"
              alt="avatar"
            />
            <input
              ref="videoRef"
              class="cameraInput"
              type="file"
              id="avatar"
              name="avatar"
              accept="video/*"
              @change="toggleVideo"
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
</template>
<script lang="ts">
import { useCourse } from "../../../../stores/course";
import { useLesson } from "../../../../stores/lesson";
import { useMedia } from "../../../../stores/media";
import {
  ref,
  defineComponent,
  watch,
  onMounted,
  type Ref,
  PropType,
} from "vue";
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import BModal from "../../../../components/BUI/BModal/BModal.vue";
import BButton from "../../../../components/BUI/BButton/BButton.vue";
import { valueEquals } from "element-plus";
import { validate } from "../../../../ultils/validators";
import SwalPopup from "../../../../ultils/swalPopup";
import { VideoPlayer } from "@videojs-player/vue";

interface Form {
  course: string;
  title: string;
  description: string;
  image: string | null;
  video: string | null;
}

export default defineComponent({
  name: "LessonModal",
  components: { BModal, BButton, SvgIcon, VideoPlayer },
  props: {
    courseId: {
      type: String,
      required: true,
      default: "",
    },
    data: {
      type: Object || String,
      required: false,
    },
  },

  emits: ["updatedMLesson"],
  setup(props, { emit }) {
    const modal = ref(false);
    const courseStore = useCourse();
    const mediaStore = useMedia();
    const lessonStore = useLesson();
    const loadingVideo = ref(false);

    const initialForm: Form = {
      course: "",
      title: "",
      description: "",
      image: null,
      video: null,
    };
    const initialError: Form = {
      course: "",
      title: "",
      description: "",
      image: "",
      video: "",
    };
    const form = ref<Form>({ ...initialForm });
    const error = ref<Form>({ ...initialError });
    const isSubmitting = ref(false);
    const imageRef: Ref<HTMLDivElement | null> = ref(null);
    const videoRef: Ref<any> = ref(null);

    watch(modal, () => {
      if (modal.value == true && props?.data) {
        if (props?.data) {
          form.value = {
            course: props?.courseId,
            title: props?.data?.title,
            description: props?.data?.description,
            image: props?.data?.image,
            video: props?.data?.video,
          };
        } else {
          form.value = { ...initialForm };
        }
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
      imageRef.value = null;
      videoRef.value = null;
      form.value = {
        ...initialForm,
      };
      error.value = {
        ...initialError,
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

      if (props?.data) {
        // updateCourse(params);
      } else {
        createLesson({ ...form?.value, course: props?.courseId });
      }
    };

    const createLesson = (params: any) => {
      isSubmitting.value = true;
      lessonStore.requestCreateLesson({
        params: params,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
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

    const clickInputImage = () => {
      if (imageRef.value) {
        imageRef.value.click();
      }
    };

    const clickInputVideo = () => {
      if (videoRef.value) {
        videoRef.value.click();
      }
    };

    const toggleAvatar = (e: any): void => {
      const avatar = e.target.files[0];
      if (!avatar) return;
      uploadAvatar(e.target.files[0]);
    };

    const toggleVideo = (e: any): void => {
      const avatar = e.target.files[0];
      if (!avatar) return;
      uploadVideo(e.target.files[0]);
    };

    const uploadAvatar = (file: any) => {
      form.value.image = URL.createObjectURL(file);

      mediaStore.requestUploadMedia({
        file: file,
        callback: {
          onSuccess: (res) => {
            form.value.image = res.url;
          },
          onFailure: (res) => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const uploadVideo = (file: any) => {
      loadingVideo.value = true;
      mediaStore.requestUploadMedia({
        file: file,
        callback: {
          onSuccess: (res) => {
            form.value.video = res.url;
            loadingVideo.value = false;
          },
          onFailure: (res) => {
            loadingVideo.value = false;
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    // const getAvatar = () => {
    //   if (fileImage.value) {
    //     return URL.createObjectURL(fileImage.value);
    //   }
    //   return "";
    // };

    return {
      form,
      error,
      modal,
      loadingVideo,
      imageRef,
      videoRef,
      isSubmitting,
      submitForm,
      validateRequired,
      show,
      hide,
      clickInputImage,
      clickInputVideo,
      toggleAvatar,
      toggleVideo,
      //   getAvatar
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
