<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update contact subject</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormSubItem 
      :subdata="subject"
      :button-content="'Update'"
      @submit="onSubmit"
    />
    <BaseModal
      v-if="showModal"
      :title="'Update contact subject'"
      :description="'Do you want to update this Contact Subject?'"
      :function-text="'Update'"
      @function-action="updateSubject"
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
      subject: {},
      showModal: false,
    }
  },
  created() {
    this.$api.contactSubject.getSubjectById(this.$route.params.id)
    .then((res) => {
      this.subject = res.data.data
    })
  },
  methods: {
    onSubmit() {
      this.openModal()
      // this.updateSubject()
    },
    updateSubject(subject) {
      this.$api.contactSubject.updateSubject(this.subject.id, this.subject)
        .then((res) => {
          this.$toast.success('Update contact subject successfully!', {
            className: 'my-toast',
          })
        })
        .then((res) => {
          this.$router.push('/contact-subject/' + this.subject.id)
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