<template>
  <div class="main-wrapper h-100 position-relative">
    <TableActivity ref="table" :data="activities" @searchContent="onSearchContent"/>
    <div v-if="activities.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="activities.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableActivity from '~/components/table/TableActivity.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableActivity,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      activities: [],
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
  mounted() {
    this.getListActivity(this.params)
  },
  methods: {
    getListActivity(params) {
      this.$api.activity.getListActivity(params).then((res) => {
        this.activities = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListActivity(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListActivity(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>