<template>
  <div class="">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Create activity</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormActivity 
      :activity="activity"
      @submit="onSubmit"  
    />
  </div>
</template>
<script>
import FormActivity from '~/components/form/FormActivity.vue';

export default {
  name: 'Activity',
  components: {
    FormActivity
  },
  layout: 'secret',
  data() {
    return {
      activity: {
        title: '',
        published: false,
      }
    }
  },
  computed: {
  },
  methods: {
    onSubmit() {
      this.createActivity()
    },
    createActivity() {
      this.$api.activity.createActivity(this.activity)
        .then((res) => {
          this.$toast.success('Create succesfully!', {
            className: 'my-toast',
          })
          this.$router.push('/activity')
        })
    },
  }
}
</script>
<style lang="scss" scoped>

</style>