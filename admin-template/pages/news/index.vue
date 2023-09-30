<template>
  <div class="main-wrapper h-100 position-relative">
    <TableNews ref="table" :data="news" @searchContent="onSearchContent" @selectCategory="onSelectCategory"/>
    <div v-if="news.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">There are no results!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="news.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableNews from '~/components/table/TableNews.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  components: {
    TableNews,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      news: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        category: this.$route.query.category ? this.$route.query.category : '',
        content: this.$route.query.content ? this.$route.query.content : '',
      },
      meta: {
        total_pages: '', 
        total_count: '', 
      },
    }
  },
  computed: {
    paginatedData() {
      const startIndex = (this.params.page - 1) * this.params.paging
      const endIndex = startIndex + this.params.paging
      return this.news.slice(startIndex, endIndex)
    },
    // totalPages() {
    //   return Math.ceil(this.news.length / this.params.paging)
    // },
  },
  mounted() {
    this.getListNews(this.params)
  },
  methods: {
    getListNews(params) {
      this.$api.news.getListNews(params).then((res) => {
        this.news = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListNews(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListNews(this.params)
    },
    onSelectCategory(id) {
      this.params.category = id
      this.params.page = 1 // Reset page to 1 when searching
      this.getListNews(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>