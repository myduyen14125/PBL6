<template>
  <div>
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
        <h1 class="title">Create product</h1>
      </div>
    </div>
    <hr class="my-2" />
    <FormProduct :product="product" @submit="onSubmit" />
  </div>
</template>
<script>
import FormProduct from "~/components/form/FormProduct.vue";

export default {
  name: "Appointment",
  components: {
    FormProduct,
  },
  layout: "secret",
  data() {
    return {
      product: {
        title: "",
        description: "",
        link: "",
        published: false,
      },
    };
  },
  computed: {},
  methods: {
    onSubmit() {
      this.createProduct();
    },
    createProduct() {
      // console.log("product", this.product)
      this.$api.product
        .createProduct(this.product)
        .then((res) => {
          this.$toast.success("Create succesfully!", {
            className: "my-toast",
          });
          this.$router.push("/product");
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
