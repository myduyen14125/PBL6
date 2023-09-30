<template>
  <div class="table-wrapper w-100">
    <div class="table-header d-flex align-items-center justify-content-between mb-2">
      <h1 class="title">Products </h1>
      <SearchInput @search="handleSearch"/>
      <nuxt-link to="/product/create">
        <button class="btn-custom btn-blue" >
          Create product
        </button>
      </nuxt-link>
    </div>
    <hr class="mt-2 mb-0">
    <div ref="table" class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-striped">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col">Title</th>
            <th scope="col">Description</th>
            <th scope="col">Link Product</th>
            <th scope="col">Date</th>
            <th scope="col">Published</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="table-row">
            <td class="color-primary">
              <span class="td-content">
                <nuxt-link :to="`/product/${item.id}`" class="cursor-pointer color-primary" @click="handleRouting(item.id)">{{ item.title.trim() }}</nuxt-link>
              </span>
            </td>
            <td v-if="item.description" class="color-secondary">
              <span class="td-content">{{ formatDescription(item.description.trim()) }}</span>
            </td>
            <td class="color-secondary">
              <span class="td-link">{{ item.link }}</span>
            </td>
            <td class="color-secondary w-20 pt-18px">{{ formatDateTime(item.created_at) }}</td>
            <td class="color-secondary w-15">
              <div class="switch-toggle">
                <label class="switch">
                  <input 
                    v-model="item.published" 
                    type="checkbox" 
                    @click="markPublic(item.id)">
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
import moment from 'moment';
import SearchInput from '../uncommon/SearchInput.vue';

export default {
  components: {
    SearchInput,
  },
  props: {
    data: {
      type: Array,
      default: () => []
    },
  },
  methods: {
    handleRouting(id) {
      this.$router.push(`/product/${id}`);
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    },
    formatDescription(description) {
      if (description.length > 100) {
        return description.slice(0, 100) + '...';
      }
      else {
        return description;
      }
    },
    markPublic(id) {
      this.$api.product.markPublicProduct(id)
        .then((res) => {
          this.$toast.success('Change status public successfully!', {
            className: 'my-toast',
          })
        })
    },
    handleSearch(content) {
      this.$emit('searchContent', content);
    },
    scrollToTop() {
      this.$refs.table.scrollTop = 0;
    }
  }
   
}
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
</style>