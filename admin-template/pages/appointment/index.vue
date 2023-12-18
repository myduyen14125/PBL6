<template>
  <div class="main-wrapper h-100 position-relative">
    <TableAppointment
      ref="table"
      :data="appointments"
      @changeSelect="changeStatus"
    />
    <div
      v-if="appointments.length == 0"
      class="d-flex justify-content-center align-items-center no-result"
    >
      <div>
        <p class="text-center">Không có kết quả phù hợp!</p>
        <img class="mt-4" src="~/assets/images/no-result.png" alt="" />
      </div>
    </div>
    <pagination
      v-if="appointments.length > 0"
      :current-page="params.page"
      :total-pages="meta.total_pages"
      @page-changed="changePage"
    />
  </div>
</template>

<script>
import TableAppointment from "~/components/table/TableAppointment.vue";
import Pagination from "@/components/common/Pagination.vue";

export default {
  name: "AppointmentManagement",
  components: {
    TableAppointment,
    Pagination,
  },
  layout: "secret",
  data() {
    return {
      appointments: [],
      params: {
        page: 1,
        status: null,
      },
      meta: {
        total_pages: "",
        total_count: "",
      },
    };
  },
  created() {
    this.getListAppointment(this.params);
  },
  methods: {
    getListAppointment(params) {
      this.$api.appointment.getListAppointment(params).then((res) => {
        this.appointments = res.data.appointments;
        this.meta.total_pages = parseInt(res.data.countPage);
        this.meta.total_count = res.data.count;
      });
      this.$router.push({ query: this.params });
    },
    changePage(pageNumber) {
      this.params.page = pageNumber;
      this.getListAppointment(this.params);
    },

    changeStatus(status) {
      this.params.status = status;
      this.getListAppointment(this.params);
    },
  },
};
</script>

<style lang="scss"></style>
