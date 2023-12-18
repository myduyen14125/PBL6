<template>
  <div class="table-wrapper w-100">
    <div
      class="table-header d-flex align-items-center justify-content-between mb-2"
    >
      <h1 class="title">Jobs</h1>
      <ComboBox
        :options-prop="typeList"
        :placeholder="'Select working type'"
        @selection-change="handleSelectType"
      />
      <SearchInput @search="handleSearch" />
      <nuxt-link to="/job/create">
        <button class="btn-custom btn-blue">Create job</button>
      </nuxt-link>
    </div>
    <hr class="mt-2 mb-0" />
    <div ref="table" class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-striped">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col">Job name</th>
            <th scope="col">Type</th>
            <th scope="col">Introduction</th>
            <th scope="col">Salary</th>
            <th scope="col">Deadline</th>
            <th scope="col">Published</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="table-row">
            <td class="color-primary w-25">
              <span class="td-content">
                <nuxt-link
                  :to="`/job/${item.id}`"
                  class="cursor-pointer color-primary"
                  @click="handleRouting(item.id)"
                  >{{ item.title.trim() }}</nuxt-link
                >
              </span>
            </td>
            <td v-if="item.working_type" class="color-secondary w-15 pt-18px">
              {{ formatWorkingType(item.working_type) }}
            </td>
            <td class="color-secondary w-25">
              <span class="td-content">{{ item.introduction.trim() }}</span>
            </td>
            <td class="color-secondary w-10 pt-18px">
              {{ formatSalary(item.salary) }}
            </td>
            <td class="color-secondary w-15 pt-18px">
              {{ formatDateTime(item.deadline) }}
            </td>
            <td class="color-secondary">
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
  },
  data() {
    return {
      typeList: [
        {
          id: "PART_TIME",
          title: "Part time",
        },
        {
          id: "FULL_TIME",
          title: "Full time",
        },
      ],
    };
  },
  methods: {
    handleRouting(id) {
      this.$router.push(`/job/${id}`);
    },
    formatDateTime(date) {
      return moment(new Date(date)).format("DD.MM.YYYY");
    },
    markPublic(id) {
      this.$api.job.markPublicJob(id).then((res) => {
        this.$toast.success("Change status public successfully!", {
          className: "my-toast",
        });
      });
    },
    handleSearch(content) {
      this.$emit("searchContent", content);
    },
    handleSelectType(type) {
      this.$emit("selectType", type);
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
  width: 280px;
  justify-content: center;
  display: inline-block;
  padding-top: 6px;
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
}

hr {
  margin: 8px 0;
}
.pt-18px {
  padding-top: 18px !important;
}
</style>
