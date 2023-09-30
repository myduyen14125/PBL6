<template>
  <div class="main-wrapper h-100 position-relative">
    <TableSubItem 
      :path="path"
      :title="title"
      :data="positions" 
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
      path: 'recruitment-position',
      title: 'Recruitment Position',
      positions: [],
    }
  },
  created() {
    this.$api.position.getListPosition().then((res) => {
      this.positions = res.data.data
    })
  },
  methods: {
    handleRemoveItem(id) {
      this.$api.position.deletePosition(id).then((res) => {
        this.positions = this.positions.filter((item) => item.id !== id)
        this.$toast.success('Delete recruitment position successfully!', {
          className: 'my-toast',
        })
        this.$router.push('/recruitment-position')
      })
    },
  },
}
</script>

<style lang="scss">
</style>