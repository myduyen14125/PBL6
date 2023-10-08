<template>
  <div class="main-wrapper h-100 position-relative">
    <TableService ref="table" :data="services" @searchContent="onSearchContent" @selectCategory="onSelectCategory" @selectStatus="onSelectStatus"/>
    <div v-if="services.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="services.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableService from '~/components/table/TableService.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableService,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      services: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        category: this.$route.query.category ? this.$route.query.category : '',
        content: this.$route.query.content ? this.$route.query.content : '',
        status: this.$route.query.status ? this.$route.query.status : '',
      },
      meta: {
        total_pages: '', 
        total_count: '', 
      },
    }
  },
  created() {
    this.getListService(this.params)
  },
  methods: {
    getListService(params) {
      this.$api.service.getListService(params).then((res) => {
        this.services = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListService(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      })
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1
      this.getListService(this.params)
    },
    onSelectCategory(id) {
      this.params.category = id
      this.params.page = 1
      this.getListService(this.params)
    },
    onSelectStatus(status) {
      this.params.status = status
      this.params.page = 1 // Reset page to 1 when searching
      this.getListService(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>