<template>
  <div class="main-wrapper h-100 position-relative">
    <TableRecruitment ref="table" :data="applications" @searchContent="onSearchContent" @selectPosition="onSelectPosition" @selectStatus="onSelectStatus"/>
    <div v-if="applications.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="applications.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableRecruitment from '~/components/table/TableRecruitment.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableRecruitment,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      applications: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        position: this.$route.query.position ? this.$route.query.position : '',
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
    this.getListApplication(this.params)
  },
  methods: {
    getListApplication(params) {
      this.$api.application.getListApplication(params).then((res) => {
        this.applications = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListApplication(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      })
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListApplication(this.params)
    },
    onSelectPosition(id) {
      this.params.position = id
      this.params.page = 1 // Reset page to 1 when searching
      this.getListApplication(this.params)
    },
    onSelectStatus(status) {
      this.params.status = status
      this.params.page = 1 // Reset page to 1 when searching
      this.getListApplication(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>