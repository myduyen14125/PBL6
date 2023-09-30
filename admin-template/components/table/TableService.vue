<template>
  <div class="table-wrapper w-100">
    <div class="table-header d-flex align-items-center justify-content-between mb-2">
      <h1 class="title">Service </h1>
      <div class="d-flex">
        <ComboBox 
          v-if="categoryList.length > 0" 
          :options-prop="categoryList"
          :placeholder="'Select category'"
          class="mr-4"
          @selection-change="handleSelect"
        />
        <ComboBox 
          :options-prop="statusList"
          :placeholder="'Select status'"
          @selection-change="handleSelectStatus"
        />
      </div>
      <SearchInput @search="handleSearch"/>
    </div>
    <hr class="mt-2 mb-0">
    <div ref="table" class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-striped">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Phone</th>
            <th scope="col">Content</th>
            <th scope="col">Category</th>
            <th scope="col">Applied date</th>
            <th scope="col">Status</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="cursor-pointer table-row" @click="handleRouting(item.id)">
            <td class="color-primary d-flex justify-content-center">
              <span class="td-content">
                <nuxt-link :to="`/service/${item.id}`" class="cursor-pointer color-primary">{{ item.name.trim() }}</nuxt-link>
              </span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.email }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.phone }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.content }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-subject">{{ getCategoryName(item.category_id) }}</span>
            </td>
            <td class="color-secondary w-15">
              <span class="td-content">{{ formatDateTime(item.created_at) }}</span>
            </td>
            <td>
              <div 
                class="status mx-auto"
                :class="{
                  'status-done': item.status === 'DONE',
                  'status-doing': item.status === 'DOING',
                  'status-todo': item.status === 'TODO'
                }">{{ item.status }}</div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import moment from 'moment';
import { mapActions, mapGetters } from 'vuex';
import SearchInput from '../uncommon/SearchInput.vue';
import ComboBox from '../uncommon/ComboBox.vue';

export default {
  components: {
    SearchInput,
    ComboBox
  },
  props: {
    data: {
      type: Array,
      default: () => []
    },
  },
  data() {
    return {
      statusList: [
        {
          id: 'TODO',
          title: 'Todo'
        },
        {
          id: 'DOING',
          title: 'Doing'
        },
        {
          id: 'DONE',
          title: 'Done'
        }
      ]
    }
  },
  computed: {
    ...mapGetters({
      categoryList: 'serviceCategory/getCategories'
    })
  },
  mounted() {
    this.fetchCategoryList();
  },
  methods: {
    ...mapActions({
      fetchCategoryList: 'serviceCategory/fetchList'
    }),
    handleRouting(id) {
      this.$router.push(`/service/${id}`);
    },
    getCategoryName(id) {
      const category = this.categoryList.find(item => item.id === id);
      return category ? category.title : '-';
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    },
    handleSearch(content) {
      this.$emit('searchContent', content);
    },
    handleSelect(id) {
      this.$emit('selectCategory', id);
    },
    handleSelectStatus(status) {
      this.$emit('selectStatus', status);
    },
    scrollToTop() {
      this.$refs.table.scrollTop = 0;
    }
  }
   
}
</script>
<style lang="scss" scoped>
.td-content {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 170px;
  justify-content: center;
  display: inline-block;
}
.td-subject {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 100px;
  justify-content: center;
  display: inline-block;
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
}

hr {
  margin: 8px 0;
}

</style>