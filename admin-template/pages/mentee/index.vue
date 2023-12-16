<template>
  <div class="main-wrapper h-100 position-relative">
    <TableMentee ref="table" :data="mentees" @searchContent="onSearchContent" />
    <div
      v-if="mentees.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
    <pagination
      v-if="mentees.length > 0"
      :current-page="params.page"
      :total-pages="meta.total_pages"
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableMentee from "~/components/table/TableMentee.vue";
import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "MenteeManagement",
  components: {
    TableMentee,
    Pagination,
  },
  layout: "secret",
  data() {
    return {
      mentees: [],
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
    this.getListMentee(this.params);
  },
  methods: {
    getListMentee(params) {
      this.$api.contact.getListSearchMentee(params).then((res) => {
        this.mentees = res.data?.mentees || [];
        this.meta.total_pages = parseInt(res.data?.countPage);
        this.meta.total_count = res.data?.count;
      });
      this.$router.push({ query: this.params });
    },
    changePage(pageNumber) {
      this.params.page = pageNumber;
      this.getListMentee(this.params);
    },
    onSearchContent(content) {
      this.params.name = content;
      this.getListMentee(this.params);
    },
    // onSelectExpertise(id) {
    //   this.params.expertise = id;
    //   this.getListMentor(this.params);
    // },
  },
};
</script>
