<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update application position</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormSubItem 
      :subdata="position"
      :button-content="'Update'"
      @submit="onSubmit"
    />
    <BaseModal
      v-if="showModal"
      :title="'Update application position'"
      :description="'Do you want to update this position?'"
      :function-text="'Update'"
      @function-action="updatePosition"
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
      position: {},
      showModal: false,
    }
  },
  created() {
    this.$api.position.getPositionById(this.$route.params.id)
    .then((res) => {
      this.position = res.data.data
    })
  },
  methods: {
    onSubmit() {
      this.openModal()
      // this.updatePosition()
    },
    updatePosition(position) {
      this.$api.position.updatePosition(this.position.id, this.position)
        .then((res) => {
          this.$toast.success('Update successfully!', {
            className: 'my-toast',
          })
          this.$router.push('/recruitment-position/' + this.position.id)
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