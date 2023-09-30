<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update job</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormJob :job="job" @submit="onSubmit"/>
    <BaseModal
      v-if="showModal"
      :title="'Update Job'"
      :description="'Do you want to update job?'"
      :function-text="'Update'"
      @function-action="updateJob"
      @close="closeModal"
    ></BaseModal>
  </div>
</template>
<script>
import FormJob from '~/components/form/FormJob.vue';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  name: 'News',
  components: {
    FormJob,
    BaseModal
  },
  layout: 'secret',
  data() {
    return {
      job: {},
      showModal: false
    }
  },
  created() {
    this.$api.job.getJobById(this.$route.params.id)
    .then((res) => {
      this.job = res.data.data
    })
  },
  methods: {
    onSubmit() {
      // this.updateJob()
      this.openModal()
    },
    updateJob(job) {
      this.$api.job.updateJob(this.job.id, this.job)
        .then((res) => {
          this.$toast.success('Update successfully!', {
            className: 'my-toast',
          })
          this.$router.push('/job/' + this.$route.params.id)
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