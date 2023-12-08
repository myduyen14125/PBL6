<template>
  <div class="card p-0 border-0">
    <div class="card-image relative" @mouseover="changeIsHover(true)" @mouseout="changeIsHover(false)">
      <img :src="course.image" :alt="course.title" class="rounded"/>
      <div class="absolute top-0 left-0 bg-dark rounded transition-all w-100 h-100"
        :class="isHover ? 'opacity-40' : 'opacity-0'">
      </div>
      <button ref="btnCouse" class="btn btn-white btn-course !font-[600] !rounded-xl absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2"
        :class="isHover ? 'opacity-100' : 'opacity-0'"
        >
        Xem khóa học
      </button>
    </div>
    <div class="card-content mt-2">
      <div class="media">
        <div class="media-content">
          <p class="title font-bold m-0">{{ course.title }}</p>
          <div class="price flex items-center">
            <p class="subtitle text-gray-500 line-through my-0">{{ course.price }}đ</p>
            <p class="subtitle text-red-700 my-0 ml-2">{{ course.discount }}đ</p>
          </div>
          <div v-if="getUserInfo().role == 'mentee'" class="flex items-center">
            <img :src="course.creator.avatar" :alt="course.creator.name" class="rounded-full w-8 h-8"/>
            <p class="subtitle text-gray-500 ml-2 mt-3">{{ course.creator.name }}</p>
          </div>
          <div v-else>
            <p class="subtitle text-gray-500 my-0">{{ course.user_count }} học viên</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { ref } from 'vue';
import { getUserInfo } from "@/ultils/cache/cookies";

export default {
  name: 'CourseCard',
  props: {
    course: {
      type: Object,
      required: true
    }
  },
  setup() {
    const isHover = ref(false);
    const changeIsHover = (value) => {
      isHover.value = value;
    }

    return {
      isHover,
      changeIsHover,
      getUserInfo
    }
  }
}
</script>
<style scoped lang="css">
.card {
  width: 360px;
  height: 300px;
}

.card-image {
  height: 200px;
  overflow: hidden;
}

.card-image img {
  object-fit: cover;
  width: 100%;
  height: 100%;
}

.btn-course {
  animation-duration: 1s;
  animation-fill-mode: forwards;
}
</style>