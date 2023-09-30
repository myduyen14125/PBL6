<template>
  <div>
    <vue-image-crop-upload
      :width="1000"
      :height="500"
      class="img-thumbnail"
      :image="image"
    ></vue-image-crop-upload>
    <notification-icon></notification-icon>
  </div>
</template>

<script>
import VueImageCropUpload from '~/components/common/VImageCropUpload.vue'
import NotificationIcon from '~/components/uncommon/NotificationIcon.vue'

export default {
  components: {
    VueImageCropUpload,
    NotificationIcon,
  },
  layout: 'secret',
  data() {
    return {
      currentPage: 1,
      itemsPerPage: 10,
      data: [
        { id: 1, name: 'Item 1' },
        { id: 2, name: 'Item 2' },
        { id: 3, name: 'Item 3' },
        { id: 4, name: 'Item 4' },
        { id: 5, name: 'Item 5' },
        { id: 6, name: 'Item 6' },
        { id: 7, name: 'Item 7' },
        { id: 8, name: 'Item 8' },
        { id: 9, name: 'Item 9' },
        { id: 10, name: 'Item 10' },
        { id: 11, name: 'Item 11' },
        { id: 12, name: 'Item 12' },
        { id: 13, name: 'Item 13' },
        { id: 14, name: 'Item 14' },
        { id: 15, name: 'Item 15' },
        { id: 16, name: 'Item 16' },
        { id: 17, name: 'Item 17' },
        { id: 18, name: 'Item 18' },
        { id: 19, name: 'Item 19' },
        { id: 20, name: 'Item 20' },
      ],
      image: ''
    }
  },
  computed: {
    paginatedData() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage
      const endIndex = startIndex + this.itemsPerPage
      return this.data.slice(startIndex, endIndex)
    },
    totalPages() {
      return Math.ceil(this.data.length / this.itemsPerPage)
    },
  },
  methods: {
    changePage(pageNumber) {
      this.currentPage = pageNumber
    },
  },
}
</script>
<style lang="scss" scoped>
.img-thumbnail {
  width: 263px;
  height: 200px;
}
</style>