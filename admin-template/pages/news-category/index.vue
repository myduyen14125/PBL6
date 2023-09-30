<template>
  <div class="main-wrapper h-100 position-relative">
    <TableSubItem 
      :path="path"
      :title="title"
      :data="categories" 
      @remove-item="handleRemoveItem"
    />
  </div>
</template>

<script>
import TableSubItem from '~/components/table/TableSubItem.vue'

export default {
  components: {
    TableSubItem,
  },
  layout: 'secret',
  data() {
    return {
      path: 'news-category',
      title: "News Category",
      categories: [],
    }
  },
  created() {
    this.$api.newsCategory.getListNewsCate().then((res) => {
      this.categories = res.data.data
    })
  },
  methods: {
    handleRemoveItem(id) {
      this.$api.newsCategory.deleteNewsCate(id).then((res) => {
        this.categories = this.categories.filter((item) => item.id !== id)
        this.$toast.success('Delete news category successfully!', {
          className: 'my-toast',
        })
        this.$router.push('/news-category')
      })
    },
  },
}
</script>

<style lang="scss">
</style>