<template>
  <div class="main-wrapper overflow-hidden h-100 position-relative">
    <TableBlog
      ref="table"
      :data="blogs"
      @searchContent="onSearchContent"
      @changeSelect="onSelectExpertise"
      @reloadTable="getListBlog"
      title="Quản lý bài viết"
    />
    <div
      v-if="blogs.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
    <pagination
      v-if="blogs.length > 0"
      :current-page="params.page"
      :total-pages="meta.total_pages"
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableBlog from "~/components/table/TableBlog.vue";
import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "BlogManagement",
  components: {
    TableBlog,
    Pagination,
  },
  layout: "secret",
  data() {
    return {
      blogs: [],
      params: {
        page: 1,
      },
      meta: {
        total_pages: 1,
        total_count: "",
      },
    };
  },
  mounted() {
    this.getListBlog(this.params);
  },
  methods: {
    getListBlog(params = this.params) {
      this.$api.contact.getListBlog(params).then((res) => {
        this.blogs = res.data?.blogs || [];
        this.meta.total_pages = parseInt(res.data?.countPage);
        this.meta.total_count = res.data?.count;
      });
      this.$router.push({ query: this.params });
    },
    changePage(pageNumber) {
      this.params.page = pageNumber;
      this.getListBlog(this.params);
    },
    onSearchContent(content) {
      this.params.title = content;
      this.getListBlog(this.params);
    },
    onSelectExpertise(id) {
      this.params.expertise = id;
      this.getListBlog(this.params);
    },
  },
};
</script>

<style lang="scss"></style>
