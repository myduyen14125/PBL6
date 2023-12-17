<template>
  <div class="table-wrapper w-100">
    <div
      class="table-header d-flex align-items-center justify-content-between mb-2"
    >
      <h1 class="title">Appointments</h1>
      <div class="ml-auto d-flex flex-wrap align-items-center">
        <div class="d-flex mr-3">
          <ComboBox
            v-if="statusList.length > 0"
            :options-prop="statusList"
            :placeholder="'Select Status'"
            @selection-change="handleSelect"
          />
        </div>
      </div>
    </div>
    <hr class="mt-2 mb-0" />
    <div ref="table" class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-striped">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col" class="text-start">Mentee</th>
            <th scope="col" class="text-start">Mentor</th>
            <th scope="col" class="text-start">Status</th>
            <th scope="col" class="text-start">Date</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(item, index) in data"
            :key="index"
            class="table-row"
            @click="handleRouting"
          >
            <td class="color-primary text-start">
              <span class="td-content">
                <div class="text-start">
                  <p>{{ item?.mentee?.name }}</p>
                  <p>{{ item?.mentee?.email }}</p>
                </div>
              </span>
            </td>
            <td class="color-secondary text-start">
              <span class="td-content"
                ><div class="text-start">
                  <p>{{ item?.mentor?.name }}</p>
                  <p>{{ item?.mentor?.email }}</p>
                </div></span
              >
            </td>
            <td class="color-secondary">
              <span class="text-start">{{ item?.status }}</span>
            </td>
            <td class="color-secondary w-20 pt-18px text-start">
              <p>
                {{ formatDateTime(item?.schedule?.start_at, "DD/MM/YYYY") }}
              </p>
              <p>
                {{
                  `${formatDateTime(
                    item?.schedule?.start_at,
                    "HH:mm"
                  )} - ${formatDateTime(item?.schedule?.end_at, "HH:mm")}`
                }}
              </p>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import moment from "moment";
import ComboBox from "../uncommon/ComboBox.vue";

export default {
  components: { ComboBox },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      statusList: [
        {
          id: "canceled",
          title: "Canceled",
        },
        {
          id: "finished",
          title: "Finished",
        },
        {
          id: "confirmed",
          title: "Confirmed",
        },
        {
          id: "pending",
          title: "Pending",
        },
      ],
    };
  },
  methods: {
    handleRouting(id) {
      this.$router.push(`/appointment/${id}`);
    },
    formatDateTime(date, format) {
      return moment(date).format(format);
    },
    handleSelect(status) {
      this.$emit("changeSelect", status);
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
  text-align: center;
  display: inline-block;
  padding-top: 6px;
}
.td-link {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 200px;
  text-align: center;
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

.text-start {
  text-align: start;
}
</style>
