<template>
  <div class="table-wrapper w-100">
    <div class="table-header d-flex align-items-center justify-content-between mb-2">
      <h1 class="title">{{ title }}</h1>
      <div class="d-flex">
        <ComboBox 
          v-if="subjectList.length > 0" 
          :options-prop="subjectList"
          :placeholder="'Select subject'"
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
      <!-- <nuxt-link to="/contact/create">
        <button class="btn-custom btn-blue" >
          Create contact
        </button>
      </nuxt-link> -->
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
            <th scope="col">Subject</th>
            <th scope="col">Date</th>
            <th scope="col">Status</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="cursor-pointer table-row" @click="handleRouting(item.id)">
            <td class="color-primary d-flex justify-content-center">
              <span class="td-content">
                <nuxt-link :to="`/contact/${item.id}`" class="cursor-pointer color-primary">{{ item.name.trim() }}</nuxt-link>
              </span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.email }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.phone }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ item.content.trim() }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-subject">{{ getSubjectName(item.subject_id) }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-content">{{ formatDateTime(item.created_at) }}</span>
            </td>
            <td>
              <div 
                class="status mx-auto"
                :class="{
                  'status-done': item.status === 'DONE',
                  'status-doing': item.status === 'DOING',
                  'status-todo': item.status === 'TODO'
                }"
              >
                  {{ item.status }}
              </div>
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
    ComboBox,
  },
  props: {
    data: {
      type: Array,
      default: () => []
    },
    title: {
      type: String,
      default: 'Contact'
    }
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
      subjectList: 'subject/getSubjects'
    })
  },
  mounted() {
    this.fetchSubjectList();
  },
  methods: {
    ...mapActions({
      fetchSubjectList: 'subject/fetchList'
    }),
    handleRouting(id) {
      this.$router.push(`/contact/${id}`);
    },
    getSubjectName(id) {
      const subject = this.subjectList.find(item => item.id === id);
      return subject ? subject.title : '-';
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
.w-1-6 {
  width: 16.6666666667% !important;
  // background: red;
}
.w-2of1-6 {
  width: 11.1111111111% !important;
  // background: yellow;
}
.w-1of1-6 {
  width: 5.5555555556% !important;
}
.td-content {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 180px;
  justify-content: center;
  display: inline-block;
}
.td-subject {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 120px;
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