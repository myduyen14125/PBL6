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
      path: 'service-category',
      title: "Service Category",
      categories: [],
    }
  },
  created() {
    this.$api.serviceCategory.getListCategory().then((res) => {
      this.categories = res.data.data
    })
  },
  methods: {
    handleRemoveItem(id) {
      this.$api.serviceCategory.deleteCategory(id).then((res) => {
        this.categories = this.categories.filter((item) => item.id !== id)
        this.$toast.success('Delete service category successfully!', {
          className: 'my-toast',
        })
        this.$router.push('/service-category')
      })
    },
  },
}
</script>

<style lang="scss">
</style>