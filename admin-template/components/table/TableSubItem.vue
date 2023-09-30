<template>
  <div class="table-wrapper w-100">
    <div class="table-header d-flex align-items-center justify-content-between mb-2">
      <h1 class="title">{{ title }} </h1>
      <nuxt-link :to="`/${path}/create`">
        <button class="btn-custom btn-blue" >
          Create
        </button>
      </nuxt-link>
    </div>
    <hr class="mt-2 mb-0">
    <div class="table-overflow overflow-auto d-block h-90">
      <div class="layer-block"></div>
      <table class="table table-striped overflow-auto">
        <thead class="color-primary table-head">
          <tr>
            <th scope="col">Title name</th>
            <th scope="col">ID</th>
            <th scope="col">Date</th>
            <th scope="col">Update</th>
            <th scope="col">Delete</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in data" :key="index" class="table-row">
            <td class="color-primary w-25">
              <nuxt-link :to="`/${path}/${item.id}`" class="cursor-pointer color-primary" @click="handleRouting(item.id)">{{ item.title.trim() }}</nuxt-link>
            </td>
            <td class="color-secondary w-25">{{ item.id }}</td>
            <td class="color-secondary w-25">{{ formatDateTime(item.created_at) }}</td>
            <td class="color-secondary pl-4 w-25-2" @mouseover="item.isHoverIcon = true" @mouseleave="item.isHoverIcon = false">
              <nuxt-link :to="`/${path}/${item.id}/update`">
                <!-- <font-awesome-icon class="icon color-secondary" icon="fa-solid fa-pen-clip" /> -->
                <img :src="item.isHoverIcon ? imgSrcHover : imgSrc"/>
              </nuxt-link>
            </td>
            <td class="color-secondary pl-4 w-25-2">
              <font-awesome-icon class="icon cursor-pointer" icon="fa-solid fa-trash-alt" @click="deleteItem(item)"/>
            </td>
          </tr>
        </tbody>
      </table>
      <BaseModal
        v-if="showModal"
        :title="'Delete contact subject'"
        :description="'Do you want to delete this Contact Subject?'"
        :function-text="'Delete'"
        @function-action="removeItem(currentItemDelete.id)"
        @close="closeModal(item)"
      >
      </BaseModal>
    </div>
    
  </div>
</template>
<script>
import moment from 'moment';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  components: {
    BaseModal
  },
  props: {
    data: {
      type: Array,
      default: () => []
    },
    path: {
      type: String,
      default: ''
    },
    title: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      currentItemDelete: null,
      showModal: false,
      isHoverIcon: false,
      imgSrc: require('~/static/icons/penclip-gray.svg'),
      imgSrcHover: require('~/static/icons/penclip-blue.svg'),
    }
  },
  methods: {
    handleRouting(id) {
      this.$router.push(`/${this.path}/${id}`);
    },
    removeItem(id) {
      console.log("id", id)
      this.$emit('remove-item', id);
      this.closeModal()
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    },
    closeModal() {
      this.currentItemDelete = null
      this.showModal = false
    },
    deleteItem(item) {
      this.currentItemDelete = item
      this.showModal = true
    }
  }
   
}
</script>
<style lang="scss" scoped>
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
.icon {
  font-size: 18px;
  transition: 0.3s ease-out;
  &:hover {
    color: $color-blue;
  }
}
hr {
  margin: 8px 0;
}
.w-25-2 {
  width: calc(25% / 2);
}

</style>