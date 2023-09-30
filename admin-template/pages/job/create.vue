<template>
  <div>
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Create job</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormJob :job="job" @submit="onSubmit" />
  </div>
</template>
<script>
import FormJob from '~/components/form/FormJob.vue'

export default {
  name: 'News',
  components: {
    FormJob,
  },
  layout: 'secret',
  data() {
    return {
      job: {
        title: '',
        working_type: '',
        address: '',
        salary: '',
        introduction: '',
        deadline: '',
        responsibilities: [],
        requirements: [],
        benefits: [],
        published: false,
      },
    }
  },
  methods: {
    onSubmit() {
      this.createJob()
    },
    createJob(job) {
      this.$api.job.createJob(this.job).then((res) => {
        this.$toast.success('Create  job succesfully!', {
          className: 'my-toast',
        })
        this.$router.push('/job')
      })
    },
  },
}
</script>
<style lang="scss" scoped>
</style>