<template>
  <div class="h-100 position-relative">
    <div class="table-header d-flex align-items-center">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="$router.go(-1)">
        <h1 class="title">Update product</h1>
      </div>
    </div>
    <hr class="my-2">
    <FormProduct 
      :product="product"
      @submit="onSubmit" 
    />
    <BaseModal
      v-if="showModal"
      :title="'Update product'"
      :description="'Do you want to Update product?'"
      :function-text="'Update'"
      @function-action="updateProduct"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import FormProduct from '~/components/form/FormProduct.vue';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  name: 'News',
  components: {
    FormProduct, 
    BaseModal, 
  },
  layout: 'secret',
  data() {
    return {
      product: {},
      showModal: false,
    }
  },
  created() {
    this.$api.product.getProductById(this.$route.params.id)
    .then((res) => {
      this.product = res.data.data
    })
  },
  methods: {
    onSubmit() {
      this.openModal()
      // this.updateProduct()
    },
    updateProduct() {
      this.$api.product.updateProduct(this.product.id, this.product)
        .then((res) => {
          this.$toast.success('Update successfully!', {
            className: 'my-toast',
          })
          this.$router.push('/product/' + this.$route.params.id)
        })
        .catch(() => {
          this.$toast.error('Update fail!', {
            className: 'my-toast',
          })
        })
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