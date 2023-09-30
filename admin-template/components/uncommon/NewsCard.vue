<template>
  <div class="news-card">
    <div class="image-wrapper mb-4">
      <!-- <img :src="item.image" alt="" /> -->
      <img v-if="item.thumbnail_url" :src="item.thumbnail_url" alt="">
      <img v-else src="~/assets/images/thumbnail-default.jpg"  alt="" class="img-logo" srcset="">
    </div>
    <div class="content">
      <div class="d-flex justify-content-between align-items-center">
        <div class="category px-2 d-flex align-items-center">
          {{ category ? category : item.category }}
        </div>
        <div class="date">{{ item.created_at }}</div>
      </div>
      <div class="new-title mt-2-5">{{ item.title }}</div>
      <div class="desc mt-2-5 ellipsed">{{ item.content}}</div>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    item: {
      type: Object,
      default: () => {},
    },
    category: {
      type: String,
      default: '',
    },
  },
  setup() {},
}
</script>
<style lang="scss" scoped>
.news-card {
  margin-bottom: 28px;
  width: 100%;
  padding: 16px 12px;
  color: $color-secondary;
  transition: 0.3s ease-out;
  border-radius: 20px;
  &:hover {
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.12);
  }
  &:hover img {
    transform: scale(1.07);
  }
}
.image-wrapper {
  width: 100%;
  overflow: hidden;
  border-radius: 20px;
  img {
    width: 100%;
    height: 100%;
    max-width: 400px;
    min-width: 350px;
    min-height: 300px;
    object-fit: cover;
    border-radius: 20px;
    transition: 0.3s ease-out;
  }
}
.category {
  height: 31px;
  background-color: $bg-gray;
  border-radius: 10px;
}
.new-title {
  color: $color-primary;
  font-weight: 500;
  font-size: 24px;
  transition: 0.3s ease-out;
}
.desc {
  font-size: 16px;
}
.ellipsed {
  -webkit-line-clamp: 6; 
}
</style>