<template>
  <div class="h-100 position-relative">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="goBack()">
        <h1 class="title">Product detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(product.id)">
        Update
      </button>
    </div>
    <hr class="my-2">
    <div class="content">
     <div class="d-flex align-items-center mb-4">
      <div class="content-title">
        <img class="content-image mr-3" :src="product.thumbnail_url" alt="">
      </div>
      <h1 v-if="product.title" class="title w-60 break-word white-space ml-4">{{ product.title.trim() }}</h1>
     </div>
     <div class="mb-2">
      <img class="content-image-detail mr-3" :src="product.background_url" alt="Background image">
     </div>
     <ul>
        <li class="list-item px-3 py-2 d-flex align-items-center h-38">
          <div class="content-title w-90px mr-3">Created at:</div>
          <div class="content-desc">{{ formatDateTime(product.created_at) }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center h-38">
          <div class="color-yellow content-title w-90px mr-3">Publish at:</div>
          <div class="content-desc">{{ product.published_at ? formatDateTime(product.published_at) : '-' }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center">
          <div class="content-title mr-3">Logo</div>
          <img class="content-image-logo" :src="product.logo_url" alt="Logo image">
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">Description</div>
          <div class="content-desc">{{ product.description }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3 ">Link product</div>
          <div class="content-desc break-word product-link"><a :href="product.link" target="_blank">{{ product.link }}</a></div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center h-57">
          <div class="content-title mr-3">Published</div>
          <div class="switch-toggle">
            <label class="switch">
              <input v-model="product.published" type="checkbox" @click="markPublic()">
              <span class="slider round"></span>
            </label>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import moment from 'moment';
export default {
  name: 'Contact',
  layout: 'secret',
  data() {
    return {
      product: {},
    }
  },
  created() {
    this.$api.product.getProductById(this.$route.params.id)
    .then((res) => {
      this.product = res.data.data
    })
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    goToUpdate(id) {
      this.$router.push(`/product/${id}/update`)
    },
    markPublic() {
      this.$api.product.markPublicProduct(this.product.id)
        .then((res) => {
          this.$toast.success('Change status public successfully!', {
            className: 'my-toast',
          })
        })
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    }
  }
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
.content {
  overflow: auto;
  height: 90%;
  &-image {
    width: 263px;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    &-detail {
      width: 780px;
      height: 340px;
      object-fit: cover;
      border-radius: 10px;
    }
    &-logo {
      width: 86px;
      height: 86px;
      object-fit: cover;
      border-radius: 10px;
    }
  }
  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 296px;
  }
  &-desc {
    color: $color-secondary;
    // width: calc(100% - 236px - 50px);
    width: 60%;
    text-align: justify;
    // margin-left: 14px;
  }
}

.product-link {
  a {
    color: $color-blue;
  }
}
.w-90px {
  width: 95px;
}
</style>