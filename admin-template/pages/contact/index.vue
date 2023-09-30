<template>
  <div class="main-wrapper h-100 position-relative">
    <TableContact ref="table" :data="contacts" @searchContent="onSearchContent" @selectCategory="onSelectCategory" @selectStatus="onSelectStatus"/>
    <div v-if="contacts.length == 0" class="d-flex justify-content-center align-items-center no-result">
      <div>
        <p class="text-center">There are no results!</p>
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
import TableContact from '~/components/table/TableContact.vue'
import Pagination from '@/components/common/Pagination.vue'

export default {
  name: 'Home',
  components: {
    TableContact,
    Pagination,
  },
  layout: 'secret',
  data() {
    return {
      contacts: [],
      params: {
        page: this.$route.query.page ? this.$route.query.page : 1,
        // paging: 10,
        subject: this.$route.query.subject ? this.$route.query.subject : '',
        content: this.$route.query.content ? this.$route.query.content : '',
        status: this.$route.query.status ? this.$route.query.status : '',
      },
      meta: {
        total_pages: 1, 
        total_count: '', 
      },
    }
  },
  mounted() {
    this.getListContact(this.params)
  },
  methods: {
    getListContact(params) {
      this.$api.contact.getListContact(params).then((res) => {
        this.contacts = res.data.data
        this.meta.total_pages = parseInt(res.data.meta.total_pages)
        console.log("totalpages: ", this.meta.total_pages)
        this.meta.total_count = res.data.meta.total_count
      })
      this.$router.push({ query: this.params })
    },
    changePage(pageNumber) {
      this.params.page = pageNumber
      this.getListContact(this.params)
      this.$nextTick(() => {
        this.$refs.table.scrollToTop();
      });
    },
    onSearchContent(content) {
      this.params.content = content
      this.params.page = 1 // Reset page to 1 when searching
      this.getListContact(this.params)
    },
    onSelectCategory(id) {
      this.params.subject = id
      this.params.page = 1 // Reset page to 1 when searching
      this.getListContact(this.params)
    },
    onSelectStatus(status) {
      this.params.status = status
      this.params.page = 1 // Reset page to 1 when searching
      this.getListContact(this.params)
    },
  },
}
</script>

<style lang="scss">
</style>