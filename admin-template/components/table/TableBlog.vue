<template>
  <div>
    <div
      class="table-header d-flex flex-wrap align-items-center justify-content-between mb-2 gap-4"
    >
      <h1 class="title">{{ title }}</h1>
      <div class="d-flex">
        <ComboBox
          v-if="expertiseList.length > 0"
          :options-prop="expertiseList"
          :placeholder="'Select expertise'"
          @selection-change="handleSelect"
        />
      </div>
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
              <th scope="col">Avatar</th>
              <th scope="col">Name</th>
              <th scope="col">Email</th>
              <th scope="col">Phone</th>
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
              <td>
                <img v-if="item?.avatar" class="avatar" :src="item?.avatar" />
              </td>
              <td class="color-primary text-start">
                <span class="td-content">
                  <nuxt-link
                    :to="`/mentor/${item?._id}`"
                    class="cursor-pointer color-primary"
                    >{{ item?.title }}</nuxt-link
                  >
                </span>
              </td>
              <td class="color-secondary text-start">
                <span class="td-content">{{ item?.content }}</span>
              </td>
              <td class="color-secondary text-start">
                <span class="td-content">{{ item?.user?.name }}</span>
              </td>
              <td class="color-secondary">
                <span class="td-content">{{
                  item?.user?.expertise?.name
                }}</span>
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
import ComboBox from "../uncommon/ComboBox.vue";

export default {
  components: {
    SearchInput,
    ComboBox,
  },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: "Quản lý mentor",
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
        this.expertiseList = res?.data
          ? res?.data?.map((item) => {
              return {
                id: item._id,
                title: item.name,
              };
            })
          : [];
      });
      this.$router.push({ query: this.params });
    },

    handleRouting(id) {
      this.$router.push(`/mentor/${id}`);
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
