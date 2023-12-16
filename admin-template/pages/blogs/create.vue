<template>
  <div class="">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Create news</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormNews 
      :news="news"
      @submit="onSubmit"  
    />
  </div>
</template>
<script>
import FormNews from '~/components/form/FormNews.vue';

export default {
  name: 'News',
  components: {
    FormNews
  },
  layout: 'secret',
  data() {
    return {
      news: {
        title: '',
        category_id: '',
        content: '',
        published: false,
      }
    }
  },
  computed: {
  },
  methods: {
    onSubmit() {
      this.createNews()
    },
    createNews() {
      // eslint-disable-next-line no-console
      console.log("news", this.data)
      this.$api.news.createNews(this.news)
        .then((res) => {
          this.$toast.success('Create succesfully!', {
            className: 'my-toast',
          })
          // console.log("res", res.data.data.id)
          this.$router.push('/news')
        })
        .catch(() => {
          this.$toast.error('Create failed!', {
            className: 'my-toast',
          })
        })
    },
  }
}
</script>
<style lang="scss" scoped>

</style>