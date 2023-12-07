<template>
  <div class="card p-0 border-0">
    <div class="card-image">
      <img :src="course.image" :alt="course.title" class="rounded-t">
    </div>
    <div class="card-content mt-2">
      <div class="media">
        <div class="media-content">
          <p class="title is-4">{{ course.title }}</p>
          <p class="subtitle is-6">{{ course.price }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'CourseCard',
  props: {
    course: {
      type: Object,
      required: true
    }
  }
}
</script>
<style scoped lang="css">
.card {
  width: 360px;
  height: 260px;
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
</style>