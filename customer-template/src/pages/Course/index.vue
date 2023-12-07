<template>
  <GuestLayout>
    <div class="container py-14 text-lg">
      <div class="flex flex-wrap mx-auto justify-center gap-4">
        <div class="" v-for="course in courses" :key="course.id">
          <CourseCard :course="course" />
        </div>
      </div>
    </div>
  </GuestLayout>
</template>
<script>
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import CourseCard from '@/components/Course/CourseCard.vue';

export default {
  name: 'Course',
  components: {
    GuestLayout, CourseCard
  },
  data() {
    return {
      courses: [
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
      ]
    }
  }
}
</script>