<template>
  <div class="">
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
        <h1 class="title">Create blog</h1>
      </div>
    </div>
    <hr class="my-2" />
    <FormBlog :blog="blog" @submit="onSubmit" />
  </div>
</template>
<script>
import FormBlog from "~/components/form/FormBlog.vue";

export default {
  name: "BlogCreate",
  components: {
    FormBlog,
  },
  layout: "secret",
  data() {
    return {
      blog: {
        title: "",
        content: "",
        image: "",
      },
    };
  },
  computed: {},
  methods: {
    onSubmit(blogDetail) {
      this.blog = blogDetail;
      this.createNews();
    },
    createNews() {
      // eslint-disable-next-line no-console
      this.$api.contact
        .createBlog(this.blog)
        .then((res) => {
          this.$toast.success("Create succesfully!", {
            className: "my-toast",
          });
          // console.log("res", res.data.data.id)
          this.$router.push("/blogs");
        })
        .catch(() => {
          this.$toast.error("Create failed!", {
            className: "my-toast",
          });
        });
    },
  },
};
</script>
<style lang="scss" scoped></style>
