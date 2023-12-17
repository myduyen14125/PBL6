<template>
  <div>
    <div
      class="table-header d-flex flex-wrap align-items-center justify-content-between mb-2 gap-4"
    >
      <h1 class="title">Quản lý expertise</h1>
      <button class="btn-custom btn-blue" @click="addExpertise">
        Create expertise
      </button>
    </div>
    <div class="table-wrapper w-100 position-relative">
      <div class="layer-new-block"></div>
      <div ref="table" class="table-overflow overflow-auto d-block h-90">
        <table class="table table-striped">
          <thead class="color-primary table-head">
            <tr>
              <th scope="col" class="col-1 text-start">No</th>
              <th scope="col" class="col-11 text-start">Name</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, index) in data"
              :key="index"
              class="cursor-pointer"
              @click="handleRouting(item?._id)"
            >
              <td class="color-primary text-start">
                <span class="td-content">
                  <nuxt-link
                    :to="`/mentee/${item?._id}`"
                    class="cursor-pointer color-primary"
                    >{{ index + 1 }}</nuxt-link
                  >
                </span>
              </td>
              <td class="color-secondary text-start">
                <span class="td-content">{{ item?.name }}</span>
              </td>
            </tr>
          </tbody>
        </table>
        <ExpertiseModal
          v-if="showModal"
          @closeExpertise="closeExpertise"
          @loadExpertiseTable="reloadTable"
        >
        </ExpertiseModal>
      </div>
    </div>
  </div>
</template>
<script>
import ExpertiseModal from "../modal/ExpertiseModal.vue";

export default {
  components: {
    ExpertiseModal,
  },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return { expertiseList: [], showModal: false };
  },

  methods: {
    handleRouting(id) {
      this.$router.push(`/expertise/${id}`);
    },

    addExpertise() {
      this.showModal = true;
    },

    closeExpertise() {
      this.showModal = false;
    },

    reloadTable() {
      this.$emit("getListExpertise");
    },
  },
};
</script>
<style lang="scss" scoped>
.td-content {
  justify-content: center;
  display: inline-block;
}

.table {
  font-size: 14px;
  &-head {
    font-weight: 600;
  }
  &-row {
    margin: 8px 0;
    &:hover {
      background-color: $color-blue-hover !important;
    }
    &:first-child {
      margin-top: 0;
    }
  }
  td {
    word-break: break-all;
  }
}

hr {
  margin: 8px 0;
}
</style>
