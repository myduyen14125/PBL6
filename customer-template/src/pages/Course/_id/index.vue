<template>
  <GuestLayout>
    <div class="course-detail">
      <div class="container">
        <div class="row mt-5 px-4">
          <div
            class="d-flex justify-content-between align-items-center border-bottom"
          >
            <h3 class="pb-3">{{ lessonDetails?.title || "" }}</h3>
            <span
              v-if="showEdit"
              class="btn btn-primary px-4 action-button my-2"
              @click="createLesson"
            >
              Tạo bài học
            </span>
          </div>
        </div>
        <div class="row my-5 px-4">
          <div
            v-if="loading"
            class="col-12 d-flex align-items-center justify-content-center min-h-[250px]"
          >
            <div class="spinner-border text-info" role="status"></div>
          </div>
          <div v-else class="flex flex-wrap gap-4">
            <div
              class="w-100"
              v-for="lesson in lessonDetails?.lessons"
              :key="lesson?._id"
            >
              <LessonCard
                :lesson="lesson"
                :showEdit="showEdit"
                @deleteLesson="deleteLesson"
                @editLesson="editLesson"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
    <LessonModal
      ref="lessonModal"
      :courseId="id"
      :loadPage="getCourseDetails"
    />
  </GuestLayout>
</template>

<script lang="ts">
import { ref, onMounted, type Ref } from "vue";
import SvgIcon from "../../../components/BUI/SvgIcon/SvgIcon.vue";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import LessonCard from "../../../components/LessonCard/LessonCard.vue";
import { useCourse } from "../../../stores/course";
import SwalPopup from "../../../ultils/swalPopup";
import { formatDate } from "../../../ultils/date";
import { useRoute } from "vue-router";
import LessonModal from "../elements/Lesson/LessonModal.vue";
import { useLesson } from "../../../stores/lesson";
import { getUserInfo } from "../../../ultils/cache/cookies";

export default {
  components: {
    SvgIcon,
    GuestLayout,
    LessonCard,
    LessonModal,
  },
  setup(props) {
    const route = useRoute();
    const lessonStore = useLesson();
    const courseStore = useCourse();
    const id = route.params.id.toString();
    const loading = ref(false);
    const lessonDetails = ref();
    const lessonModal: Ref<any> = ref<typeof LessonModal | null>(null);
    const showEdit = ref(false);

    onMounted(() => {
      getCourseDetails();
    });

    const getCourseDetails = () => {
      loading.value = true;
      courseStore.requestGetCourseById({
        id: id,
        callback: {
          onSuccess: (res) => {
            lessonDetails.value = res;
            loading.value = false;
            showEdit.value = res?.creator?._id == getUserInfo()?._id;
          },
          onFailure: () => {
            loading.value = false;
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const createLesson = () => {
      lessonModal?.value?.show();
    };

    const editLesson = (lesson: any) => {
      lessonModal?.value?.setData(lesson);
      lessonModal?.value?.show();
    };

    const deleteLesson = (lessonId: any) => {
      loading.value = true;
      lessonStore.requestDeleteLesson({
        id: lessonId,
        callback: {
          onSuccess: (res) => {
            getCourseDetails();
          },
          onFailure: () => {
            loading.value = false;
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    return {
      id,
      loading,
      showEdit,
      lessonModal,
      lessonDetails,
      formatDate,
      createLesson,
      editLesson,
      deleteLesson,
      getCourseDetails,
    };
  },
};
</script>

<style scoped lang="css"></style>
