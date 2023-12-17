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
        <h1 class="title">Update blog detail</h1>
      </div>
    </div>
    <hr class="my-2" />
    <!-- @mark-public="markPublic" -->
    <FormBlog :blog="blog" @submit="onSubmit" />
    <BaseModal
      v-if="showModal"
      :title="'Update Blog'"
      :description="'Are you sure you want to update this blog?'"
      :function-text="'Update'"
      @function-action="updateBlog"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import FormBlog from "~/components/form/FormBlog.vue";
import BaseModal from "~/components/modal/BaseModal.vue";

export default {
  name: "BlogDetail",
  components: {
    FormBlog,
    BaseModal,
  },
  layout: "secret",
  data() {
    return {
      blog: {},
      showModal: false,
    };
  },
  created() {
    this.getBlogDetail();
  },
  methods: {
    getBlogDetail() {
      this.$api.contact.getBlogById(this.$route.params.id).then((res) => {
        this.blog = res?.data;
      });
    },
    onSubmit() {
      this.openModal();
    },
    updateBlog() {
      this.$api.contact
        .updateBlog(this.blog)
        .then((res) => {
          this.$toast.success("Update successfully!", {
            className: "my-toast",
          });
        })
        .catch(() => {
          this.$toast.error("Update fail!", {
            className: "my-toast",
          });
        });
      this.closeModal();
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
