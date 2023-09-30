<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update news category</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormSubItem 
      :subdata="category"
      :button-content="'Update'"
      @submit="onSubmit"
    />
    <BaseModal
      v-if="showModal"
      :title="'Update news category'"
      :description="'Do you want to update this news category?'"
      :function-text="'Update'"
      @function-action="updateNewsCate"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import FormSubItem from '~/components/form/FormSubItem.vue';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  name: 'News',
  components: {
    FormSubItem,
    BaseModal
  },
  layout: 'secret',
  data() {
    return {
      category: {},
      showModal: false,
    }
  },
  created() {
    this.$api.newsCategory.getNewsCateById(this.$route.params.id)
    .then((res) => {
      this.category = res.data.data
    })
  },
  methods: {
    onSubmit() {
      this.openModal()
      // this.updateNewsCate()
    },
    updateNewsCate(category) {
      this.$api.newsCategory.updateNewsCate(this.category.id, this.category)
        .then((res) => {
          this.$toast.success('Update successfully!', {
            className: 'my-toast',
          })
          this.$router.push('/news-category/' + this.category.id)
        })
        .catch(() => {
          this.$toast.error('Update fail!', {
            className: 'my-toast',
          })
        })
        this.closeModal()
    },
    openModal() {
      this.showModal = true
    },
    closeModal() {
      this.showModal = false
    }
  }
}
</script>
<style lang="scss" scoped>

</style>