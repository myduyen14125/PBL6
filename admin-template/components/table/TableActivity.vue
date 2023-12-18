<template>
  <div class="table-wrapper w-100">
    <div
      class="table-header d-flex align-items-center justify-content-between mb-2"
    >
      <h1 class="title">Activities</h1>
      <SearchInput @search="handleSearch" />
      <nuxt-link to="/activity/create">
        <button class="btn-custom btn-blue">Create</button>
      </nuxt-link>
    </div>
    <hr class="mt-2 mb-0" />
    <div ref="table" class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-hover table-striped">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col">Title</th>
            <th scope="col">Image</th>
            <th scope="col">Date</th>
            <th scope="col">Published</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="table-row">
            <td class="color-primary d-flex mt-30px">
              <div class="td-content">
                <nuxt-link
                  :to="`/activity/${item.id}`"
                  class="cursor-pointer color-primary"
                  @click="handleRouting(item.id)"
                  >{{ item.title.trim() }}</nuxt-link
                >
              </div>
            </td>
            <td class="color-secondary w-25">
              <img
                :src="item.thumbnail_url"
                alt="image"
                width="146px"
                height="89px"
              />
            </td>
            <td class="color-secondary w-25 pt-42px">
              {{ formatDateTime(item.created_at) }}
            </td>
            <td class="color-secondary w-25 pt-42px">
              <div class="switch-toggle">
                <label class="switch">
                  <input
                    v-model="item.published"
                    type="checkbox"
                    @click="markPublic(item.id)"
                  />
                  <span class="slider round"></span>
                </label>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import moment from "moment";
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
  },
  methods: {
    handleRouting(id) {
      this.$router.push(`/activity/${id}`);
    },
    formatDateTime(date) {
      return moment(new Date(date)).format("DD.MM.YYYY HH:mm");
    },
    markPublic(id) {
      this.$api.activity.markPublicActivity(id).then((res) => {
        this.$toast.success("Change status public successfully!", {
          className: "my-toast",
        });
      });
    },
    handleSearch(content) {
      console.log("handlesearch");
      this.$emit("searchContent", content);
    },
    scrollToTop() {
      this.$refs.table.scrollTop = 0;
    },
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";

.td-content {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 400px;
  text-align: center;
}
.table {
  font-size: 14px;
  &-head {
    font-weight: 600;
  }
  &-row {
    &:hover {
      background-color: $color-blue-hover !important;
    }
  }
  input {
    width: 100%;
    height: 20px;
  }
  img {
    border-radius: 10px;
  }
}

hr {
  margin: 8px 0;
}
img {
  object-fit: cover;
}
.mt-30px {
  margin-top: 30px;
}
.pt-42px {
  padding-top: 42px !important; // 30px + 12px
}
</style>
