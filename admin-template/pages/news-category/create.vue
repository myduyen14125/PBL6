<template>
  <div>
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Create news category</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormSubItem 
      :subdata="category"
      :button-content="'Create'"
      @submit="onSubmit"
    />
  </div>
</template>
<script>
import FormSubItem from '~/components/form/FormSubItem.vue';

export default {
  name: 'News',
  components: {
    FormSubItem
  },
  layout: 'secret',
  data() {
    return {
      category: {
        title: '',
      }
    }
  },
  methods: {
    onSubmit() {
      this.createNews()
    },
    createNews() {
      this.$api.newsCategory.createNewsCate(this.category)
        .then((res) => {
          this.$toast.success('Create successfully!', {
            className: 'my-toast',
          })
        })
        .then((res) => {
          this.$router.push('/news-category')
        })
    },
  }
}
</script>
<style lang="scss" scoped>

</style>