<template>
  <div class="main-wrapper h-100 position-relative">
    <TableProduct ref="table" :data="products" @searchContent="onSearchContent"/>
    <div v-if="products.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="products.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableProduct from '~/components/table/TableProduct.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableProduct,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      products: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        content: this.$route.query.content ? this.$route.query.content : '',
      },
      meta: {
        total_pages: '', 
        total_count: '', 
      },
    }
  },
  created() {
    this.getListProduct(this.params)
  },
  methods: {
    getListProduct(params) {
      this.$api.product.getListProduct(params).then((res) => {
        this.products = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListProduct(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListProduct(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>