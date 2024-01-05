<template>
  <GuestLayout>
    <div class="course-detail">
      <div class="container">
        <div class="row mt-5 px-4">
          <div
            class="d-flex justify-content-between align-items-center border-bottom"
          >
            <h3 class="pb-3">Các bài học của bạn</h3>
            <span
              class="btn btn-primary px-4 action-button my-2"
              @click="createLesson"
            >
              Tạo bài học
            </span>
          </div>
        </div>
        <div class="row my-5 px-4">
          <div class="flex flex-wrap gap-4">
            <LessonCard
              v-for="lesson in lessonDetails?.lessons"
              :key="course?._id"
              :lesson="lesson"
              showEdit
              @deleteLesson="() => {}"
              @editLesson="() => {}"
            />
          </div>
        </div>
      </div>
    </div>
    <LessonModal ref="lessonModal" :courseId="id" />
  </GuestLayout>
</template>

<script lang="ts">
import { ref, onMounted, watch, type Ref } from "vue";
import SvgIcon from "../../../components/BUI/SvgIcon/SvgIcon.vue";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import LessonCard from "../../../components/LessonCard/LessonCard.vue";
import { useLesson } from "../../../stores/lesson";
import { useCourse } from "../../../stores/course";
import SwalPopup from "../../../ultils/swalPopup";
import { formatDate } from "../../../ultils/date";
import { useRoute } from "vue-router";
import LessonModal from "../elements/Lesson/LessonModal.vue";

export default {
  components: {
    SvgIcon,
    GuestLayout,
    LessonCard,
    LessonModal,
  },
  setup(props) {
    const route = useRoute();
    const courseStore = useCourse();
    const lessonStore = useLesson();
    const id = route.params.id.toString();
    const loading = ref(false);
    const lessonDetails = ref();
    const lessonModal: Ref<any> = ref<typeof LessonModal | null>(null);

    onMounted(() => {
      getCourseDetails();
      // getLessonList();
    });

    const getCourseDetails = () => {
      courseStore.requestGetCourseById({
        id: id,
        callback: {
          onSuccess: (res) => {
            lessonDetails.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const getLessonList = () => {
      lessonStore.requestGetLessons({
        id: id,
        callback: {
          onSuccess: (res) => {
            console.log(res);
          },
          onFailure: () => {
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

    return {
      id,
      loading,
      lessonModal,
      lessonDetails,
      formatDate,
      createLesson,
    };
  },
};
</script>

<style scoped lang="css"></style>
