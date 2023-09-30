<template>
  <div class="main-wrapper h-100 position-relative">
    <TableJob ref="table" :data="jobs" @searchContent="onSearchContent" @selectType="onSelectType"/>
    <div v-if="jobs.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">There are no results!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="jobs.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableJob from '~/components/table/TableJob.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableJob,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      jobs: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        content: this.$route.query.content ? this.$route.query.content : '',
        type: this.$route.query.type ? this.$route.query.type : '',
      },
      meta: {
        total_pages: '', 
        total_count: '',
      }
    }
  },
  created() {
    this.getListJob(this.params)
  },
  methods: {
    getListJob(params) {
      this.$api.job.getListJob(params).then((res) => {
        this.jobs = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListJob(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListJob(this.params)
    },
    onSelectType(type) {
      this.params.type = type
      this.params.page = 1 // Reset page to 1 when searching
      this.getListJob(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>