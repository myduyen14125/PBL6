<template>
  <div>
    <div
      class="table-header d-flex align-items-center justify-content-between mb-4"
    >
      <h1 class="title">Create new expertise</h1>
      <button class="btn-custom btn-white" @click="$router.go(-1)">
        Cancel
      </button>
    </div>
    <!-- <FormExpertise :expertise="expertise"/> -->
    <FormExpertise />
  </div>
</template>
<script>
import FormExpertise from "~/components/form/FormExpertise.vue";

export default {
  name: "ExpertiseCreate",
  components: {
    FormExpertise,
  },
  layout: "secret",
  data() {
    return {
      expertise: {
        name: "",
        //   id: this.$route.params.id,
      },
    };
  },
  computed: {},
  created() {},
};
</script>
<style lang="scss" scoped></style>
