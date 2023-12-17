<template>
  <div class="main-wrapper h-100 position-relative">
    <TableExpertise
      ref="table"
      :data="expertiseList"
      @getListExpertise="getListExpertise"
    />
    <div
      v-if="expertiseList.length == 0"
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
      expertiseList: [],
    };
  },
  mounted() {
    this.getListExpertise();
  },
  methods: {
    getListExpertise() {
      this.$api.contact.getListSearchExpertise().then((res) => {
        this.expertiseList = res.data || [];
      });
    },
  },
};
</script>
