<template>
  <div class="main-wrapper h-100 position-relative">
    <TableContact ref="table" :data="contacts" @searchContent="onSearchContent" @selectCategory="onSelectCategory" @selectStatus="onSelectStatus"/>
    <div v-if="contacts.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="">
      </div>
    </div>
    <pagination 
      v-if="contacts.length > 0"
      :current-page="params.page" 
      :total-pages="meta.total_pages" 
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableContact from '~/components/table/TableMentor.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  name: 'MentorManagement',
  components: {
    TableContact,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      contacts: [],
      params: {
        page: 1,
        // page: this.$route.query.page ? this.$route.query.page : 1,
        // // paging: 10,
        // subject: this.$route.query.subject ? this.$route.query.subject : '',
        // content: this.$route.query.content ? this.$route.query.content : '',
        // status: this.$route.query.status ? this.$route.query.status : '',
      },
      meta: {
        total_pages: 1, 
        total_count: '', 
      },
    }
  },
  mounted() {
    this.getListMentor(this.params)
  },
  methods: {
    getListMentor(params) {
      this.$api.contact.getListMentor(params).then((res) => {
        this.contacts = res.data
        // this.meta.total_pages = parseInt(res.data.meta.total_pages)
        // console.log("totalpages: ", this.meta.total_pages)
        // this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListMentor(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListMentor(this.params)
    },
    onSelectCategory(id) {
      this.params.subject = id
      this.params.page = 1 // Reset page to 1 when searching
      this.getListMentor(this.params)
    },
    onSelectStatus(status) {
      this.params.status = status
      this.params.page = 1 // Reset page to 1 when searching
      this.getListMentor(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>