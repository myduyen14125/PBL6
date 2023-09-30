<template>
  <div class="tableview">
    <table>
      <thead>
        <tr>
          <th v-for="(item, index) in listHeader" :key="index">
            {{ item }}
          </th>
        </tr>
      </thead>
      <tbody>
        <slot name="tbody" v-bind:listData="listData" />
      </tbody>
    </table>
    <div class="tableview__pagination">
      <vue-paginate v-show="!showLoading" :baseUrl="requestUrl" ref="vuePaginate" optionParam="" :startFetch="true"
        startPageCount="1" :paging="3" @before-fetch="showLoading = $event" @fetch-success="parseDataClass"
        @total-count="totalNews = $event" @click-page="scrollToTopPage">
      </vue-paginate>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    listHeader: {
      type: Array,
    },
    requestUrl: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      showLoading: true,
      totalNews: null,
      listData: []
    }
  },
  computed: {
  },
  methods: {
    parseDataClass(data) {
      this.listData = data
      console.log("data", data)
    },
    scrollToTopPage() {

    }
  }
}
</script>

<style lang="scss" scoped>
.tableview {
  width: 100%;
  margin-top: 8px;

  table {
    width: 100%;

    thead {
      background-color: $secondary-0;
      border-bottom: 8px solid $neutral-0;

      tr {

        th {
          @include text-style(14px, 38px, 600, $text-primary, 0);
        }
      }
    }

    tbody {
      border-bottom: 8px solid $neutral-0;

      tr {
        border-bottom: 8px solid $neutral-0;

        &:hover {
          background-color: $secondary-0;
        }

        &:last-child {
          border-bottom: none;
        }

        td {
          padding: 13px 21px;
        }
      }
    }
  }

}
</style>