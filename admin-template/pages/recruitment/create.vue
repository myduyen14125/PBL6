<template>
  <div>
    <div class="table-header d-flex align-items-center justify-content-between mb-4">
      <h1 class="title">Create Product</h1>
      <button class="btn-custom btn-white" @click="$router.go(-1)">
        Cancel
      </button>
    </div>
    <FormProduct/>
  </div>
</template>
<script>
import FormProduct from '~/components/form/FormProduct.vue';

export default {
  name: 'News',
  components: {
    FormProduct
  },
  layout: 'secret',
  methods: {
  }
}
</script>
<style lang="scss" scoped>

</style>