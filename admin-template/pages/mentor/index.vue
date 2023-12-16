<template>
  <div class="main-wrapper h-100 position-relative">
    <TableMentor ref="table" :data="mentors" @searchContent="onSearchContent" />
    <div
      v-if="mentors.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
    <pagination
      v-if="mentors.length > 0"
      :current-page="params.page"
      :total-pages="meta.total_pages"
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableMentor from "~/components/table/TableMentor.vue";
import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "MentorManagement",
  components: {
    TableMentor,
    Pagination,
  },
  layout: "secret",
  data() {
    return {
      mentors: [],
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
    this.getListMentor(this.params);
  },
  methods: {
    getListMentor(params) {
      this.$api.contact.getListSearchMentor(params).then((res) => {
        this.mentors = res.data?.mentors || [];
        this.meta.total_pages = parseInt(res.data?.countPage);
        this.meta.total_count = res.data?.count;
      });
      this.$router.push({ query: this.params });
    },
    changePage(pageNumber) {
      this.params.page = pageNumber;
      this.getListMentor(this.params);
    },
    onSearchContent(content) {
      this.params.name = content;
      this.getListMentor(this.params);
    },
  },
};
</script>

<style lang="scss"></style>
