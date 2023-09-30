<template>
  <div class="main-wrapper h-100 position-relative">
    <TableSubItem 
      :path="path"
      :title="title"
      :data="subjects" 
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
      path: 'contact-subject',
      title: 'Contact Subject',
      subjects: [],
    }
  },
  created() {
    this.$api.contactSubject.getListSubject().then((res) => {
      this.subjects = res.data.data
    })
  },
  methods: {
    handleRemoveItem(id) {
      this.$api.contactSubject.deleteSubject(id).then((res) => {
        this.subjects = this.subjects.filter((item) => item.id !== id)
        this.$toast.success('Delete contact subject successfully!', {
          className: 'my-toast',
        })
        this.$router.push('/contact-subject')
      })
    },
  },
}
</script>

<style lang="scss">
</style>