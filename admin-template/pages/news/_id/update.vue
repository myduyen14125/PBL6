<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update news detail</h1>
      </div>
    </div>
    <hr class="my-2">
    <!-- @mark-public="markPublic" -->
    <FormNews
      :news="news" 
      @submit="onSubmit" />
    <BaseModal
      v-if="showModal"
      :title="'Update News'"
      :description="'Do you want to update news?'"
      :function-text="'Update'"
      @function-action="updateNews"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import FormNews from '~/components/form/FormNews.vue';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  name: 'News',
  components: {
    FormNews,
    BaseModal
  },
  layout: 'secret',
  data() {
    return {
      news: {},
      showModal: false
    }
  },
  created() {
    this.$api.news.getNewsById(this.$route.params.id)
    .then((res) => {
      this.news = res.data.data
    })
  },
  methods: {
    onSubmit() {
      this.openModal()
      // this.updateNews()
    },
    updateNews(news) {
      this.$api.news.updateNews(this.news.id, this.news)
        .then((res) => {
          this.$toast.success('Update successfully!', {
            className: 'my-toast',
          })
          this.$router.push('/news/' + this.$route.params.id)
        })
        .catch(() => {
          this.$toast.error('Update fail!', {
            className: 'my-toast',
          })
        })
        this.closeModal()
    },
    openModal() {
      this.showModal = true; 
    },
    closeModal() {
      this.showModal = false; 
    },
  }
}
</script>
<style lang="scss" scoped>

</style>