<template>
  <div>
    <div
      class="table-header d-flex align-items-center justify-content-between mb-4"
    >
      <h1 class="title">Create new contact</h1>
      <button class="btn-custom btn-white" @click="$router.go(-1)">
        Cancel
      </button>
    </div>
    <FormContact />
  </div>
</template>
<script>
import FormContact from "~/components/form/FormContact.vue";

export default {
  name: "CreateMentor",
  components: {
    FormContact,
  },
  layout: "secret",
};
</script>
<style lang="scss" scoped></style>
