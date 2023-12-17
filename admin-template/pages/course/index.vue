<template>
  <div class="main-wrapper h-100 position-relative">
    <TableCourse ref="table" :data="courses" @searchContent="onSearchContent" />
    <div
      v-if="courses.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
    <pagination
      v-if="courses.length > 0"
      :current-page="params.page"
      :total-pages="meta.total_pages"
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableCourse from "~/components/table/TableCourse.vue";
import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "CourseManagement",
  components: {
    TableCourse,
    Pagination,
  },
  layout: "secret",
  data() {
    return {
      courses: [],
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
    this.getListCourse(this.params);
  },
  methods: {
    getListCourse(params) {
      this.$api.contact.getListSearchCourse(params).then((res) => {
        this.courses = res.data?.courses || [];
        this.meta.total_pages = parseInt(res.data?.countPage);
        this.meta.total_count = res.data?.count;
      });
      this.$router.push({ query: this.params });
    },

    changePage(pageNumber) {
      this.params.page = pageNumber;
      this.getListCourse(this.params);
    },
    onSearchContent(title) {
      this.params.title = title;
      this.getListCourse(this.params);
    },
  },
};
</script>
