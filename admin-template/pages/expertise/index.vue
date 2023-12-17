<template>
  <div class="main-wrapper h-100 position-relative">
    <TableExpertise
      ref="table"
      :data="expertises"
      @searchContent="onSearchContent"
      @getListExpertise="getListExpertise"
    />
    <div
      v-if="expertises.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
  </div>
</template>

<script>
import TableExpertise from "~/components/table/TableExpertise.vue";
// import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "ExpertiseManagement",
  components: {
    TableExpertise,
    // Pagination,
  },
  layout: "secret",
  data() {
    return {
      expertises: [],
      //   params: {
      //     page: 1,
      //   },
      //   meta: {
      //     total_pages: 1,
      //     total_count: "",
      //   },
    };
  },
  mounted() {
    this.getListExpertise();
  },
  methods: {
    getListExpertise() {
      this.$api.contact.getListSearchExpertise().then((res) => {
        this.expertises = res.data || [];
      });
    },
    onSearchContent(content) {
      //   this.params.name = content;
      this.getListExpertise();
    },
  },
};
</script>
