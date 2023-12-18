<template>
  <div>
    <div
      class="table-header d-flex flex-wrap align-items-center justify-content-between mb-2 gap-4"
    >
      <h1 class="title">{{ title }}</h1>
      <SearchInput @search="handleSearch" />
      <!-- <nuxt-link to="/mentor/create">
          <button class="btn-custom btn-blue">Create mentor</button>
        </nuxt-link> -->
    </div>
    <div class="table-wrapper w-100 position-relative">
      <div class="layer-new-block"></div>
      <div ref="table" class="table-overflow overflow-auto d-block h-90">
        <table class="table table-striped">
          <thead class="color-primary table-head">
            <tr>
              <th scope="col" class="text-start">Avatar</th>
              <th scope="col" class="text-start">Name</th>
              <th scope="col" class="text-start">Email</th>
              <th scope="col" class="text-start">Phone</th>
              <th scope="col">Gender</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, index) in data"
              :key="index"
              class="cursor-pointer"
              @click="handleRouting(item?._id)"
            >
              <td class="text-start">
                <img v-if="item?.avatar" class="avatar" :src="item?.avatar" />
              </td>
              <td class="color-primary text-start">
                <span class="td-content">
                  <nuxt-link
                    :to="`/mentee/${item?._id}`"
                    class="cursor-pointer color-primary"
                    >{{ item?.name }}</nuxt-link
                  >
                </span>
              </td>
              <td class="color-secondary text-start">
                <span class="td-content">{{ item?.email }}</span>
              </td>
              <td class="color-secondary text-start">
                <span class="td-content">{{ item?.phone }}</span>
              </td>
              <td class="color-secondary">
                <span class="td-content">{{
                  item?.gender ? "Female" : "Male"
                }}</span>
              </td>
              <!-- <td class="color-secondary">
                <span class="td-content">{{ item?.expertise?.name }}</span>
              </td> -->
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import SearchInput from "../uncommon/SearchInput.vue";
// import ComboBox from "../uncommon/ComboBox.vue";

export default {
  components: {
    SearchInput,
    // ComboBox,
  },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: "Quản lý mentee",
    },
  },
  data() {
    return { menteeList: [] };
  },
  mounted() {
    this.getListMentee();
  },
  methods: {
    getListMentee() {
      this.$api.contact.getListMentee().then((res) => {
        this.menteeList = res?.data.mentees ? res?.data.mentees : [];
      });
      this.$router.push({ query: this.params });
    },

    handleRouting(id) {
      this.$router.push(`/mentee/${id}`);
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
