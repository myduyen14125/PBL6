<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img
          src="@/assets/icons/icon-back.svg"
          alt=""
          width="20px"
          height="20px"
          class="mr-1 cursor-pointer"
          @click="$router.go(-1)"
        />
        <h1 class="title">Update activity</h1>
      </div>
    </div>
    <hr class="my-2" />
    <FormActivity :activity="activity" @submit="onSubmit" />
    <BaseModal
      v-if="showModal"
      :title="'Update activity'"
      :description="'Do you want to update this activity?'"
      :function-text="'Update'"
      @function-action="updateActivity"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import FormActivity from "~/components/form/FormActivity.vue";
import BaseModal from "~/components/modal/BaseModal.vue";

export default {
  name: "ActivityUpdate",
  components: {
    FormActivity,
    BaseModal,
  },
  layout: "secret",
  data() {
    return {
      activity: {},
      showModal: false,
    };
  },
  created() {
    this.$api.activity.getActivityById(this.$route.params.id).then((res) => {
      this.activity = res.data.data;
    });
  },
  methods: {
    onSubmit() {
      this.openModal();
      // this.updateActivity()
    },
    updateActivity(activity) {
      this.$api.activity
        .updateActivity(this.activity.id, this.activity)
        .then((res) => {
          this.$toast.success("Update successfully!", {
            className: "my-toast",
          });
          this.$router.push("/activity/" + this.$route.params.id);
        });
    },
    openModal() {
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
  },
};
</script>
<style lang="scss" scoped></style>
