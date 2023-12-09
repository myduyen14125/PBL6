<template>
  <GuestLayout>
    <div class="container relative py-14 px-0 lg:px-16 text-lg min-h-[62vh]">
      <h1 class="text-3xl font-bold text-teal-600 mb-4">Các khóa học của tôi</h1>
      <button class="absolute top-14 right-14 btn btn-primary mb-4" @click="toggleModalCourse"
      >Tạo khóa học</button>
      <div class="flex flex-wrap gap-4">
        <div class="" v-for="course in courses" :key="course.id">
          <CourseCard :course="course" />
        </div>
      </div>
    </div>
    <CourseModal 
      ref="courseModal"
      :course="currentCourse?._id || ''"
      @updatedModal="() => getCourseInformation(id)" />
  </GuestLayout>
</template>
<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
import { Course } from "@/types/course"; 
import { useCourse } from "@/stores/course";
import { useMentors } from "@/stores/mentors";
import { GetPaginationParams, Mentor } from "@/types/mentor";
import GuestLayout from "@/layout/GuestLayout/GuestLayout.vue";
import CourseCard from '@/components/Course/CourseCard.vue';
import SwalPopup from "@/ultils/swalPopup";
import CourseModal from "@/pages/Course/CourseModal.vue";

export default defineComponent({
  name: 'Course',
  components: {
    GuestLayout, CourseCard, CourseModal
  },
  setup() {
    const courses = ref<Course[]>([]);
    const totalElement = ref(0);
    const courseModal: Ref<any> = ref<typeof CourseModal | null>(null);

    onMounted(() => {
      getCourses();
    })

    const getCourses = () => {
      useCourse().requestGetCourses({
        params: {
          page: 1,
          limit: 10,
        } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            courses.value = res.courses;
            totalElement.value = res.count;
          },
          onFailure: () => {
            console.log("err")
            SwalPopup.swalResultPopup(
                "Sorry, looks like there are some errors detected, please try again.",
                "error"
              );
          }
        }
      })
    }

    const getCourseInformation = (id: string) => {
      useCourse().requestGetCourseInformation({
        params: {
          id
        },
        callback: {
          onSuccess: (res) => {
            courses.value = res.courses;
            totalElement.value = res.count;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
                "Sorry, looks like there are some errors detected, please try again.",
                "error"
              );
          }
        }
      })
    }

    const toggleModalCourse = (): void => {
      console.log("courseModal", courseModal)
      courseModal?.value?.show();
    };

    return {
      courses,
      getCourses,
      toggleModalCourse,
      courseModal,
    }
  }
})
</script>