<template>
  <div>
    <div
      class="table-header d-flex flex-wrap align-items-center justify-content-between mb-2 gap-4"
    >
      <h1 class="title">{{ title }}</h1>
      <SearchInput @search="handleSearch" />
      <nuxt-link to="/expertise/create">
        <button class="btn-custom btn-blue">Create expertise</button>
      </nuxt-link>
    </div>
    <div class="table-wrapper w-100 position-relative">
      <div class="layer-new-block"></div>
      <div ref="table" class="table-overflow overflow-auto d-block h-90">
        <table class="table table-striped">
          <thead class="color-primary table-head">
            <tr>
              <th scope="col" class="col-1">No</th>
              <th scope="col" class="col-4">Name</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, index) in data"
              :key="index"
              class="cursor-pointer"
              @click="handleRouting(item?._id)"
            >
              <td class="color-primary">
                <span class="td-content">
                  <nuxt-link
                    :to="`/mentee/${item?._id}`"
                    class="cursor-pointer color-primary"
                    >{{ index }}</nuxt-link
                  >
                </span>
              </td>
              <td class="color-secondary">
                <span class="td-content">{{ item?.name }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import SearchInput from "../uncommon/SearchInput.vue";

export default {
  components: {
    SearchInput,
  },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: "Quản lý expertise",
    },
  },
  data() {
    return { expertiseList: [] };
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

    handleRouting(id) {
      this.$router.push(`/expertise/${id}`);
    },

    handleSearch(content) {
      this.$emit("searchContent", content);
    },

    handleSelect(expertise) {
      this.$emit("changeSelect", expertise);
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

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.text-start {
  text-align: start;
}
</style>
