<template>
  <GuestLayout>
    <div class="container py-14 text-lg min-h-[62vh]">
      <h1 class="text-3xl text-center font-bold text-teal-600 mb-4">Các khóa học của tôi</h1>
      <div class="flex flex-wrap mx-auto justify-center gap-4">
        <div class="" v-for="course in courses" :key="course.id">
          <CourseCard :course="course" />
        </div>
      </div>
    </div>
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

export default defineComponent({
  name: 'Course',
  components: {
    GuestLayout, CourseCard
  },
  setup() {
    const courses = ref<Course[]>([]);
    const courses2 = ref([
    {
          "_id": "655adbd01af3dea1a1477ed7",
          "title": "Pay Course",
          "discount": 0,
          "lesson_count": 3,
          "description": "No",
          "price": 100000,
          "user_count": 0,
          "image": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
          "creator": {
            "name": "Phan Dat",
            "avatar": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
            "expertise": {
              "name": "Web Development"
            }
          }
        },
        {
          "_id": "655adad26551224ae9801374",
          "title": "Free Course",
          "discount": 0,
          "lesson_count": 2,
          "description": "No",
          "price": 0,
          "user_count": 1,
          "image": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
          "creator": {
            "name": "Phan Dat",
            "avatar": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
            "expertise": {
              "name": "Web Development"
            }
          }
        },
        {
          "_id": "655adad26551224ae9801374",
          "title": "Free Course",
          "discount": 0,
          "lesson_count": 2,
          "description": "No",
          "price": 0,
          "user_count": 1,
          "image": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
          "creator": {
            "name": "Phan Dat",
            "avatar": "https://itmentor.s3.ap-southeast-1.amazonaws.com/6551a2f9a44daf1d5c95de67/maxresdefault.jpg",
            "expertise": {
              "name": "Web Development"
            }
          }
        }
    ]);
    const totalElement = ref(0);

    onMounted(() => {
      getCourses();
    })

    const getCourses = () => {
      console.log("hehehe")
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

    return {
      courses,
      getCourses
    }
  }
})
</script>