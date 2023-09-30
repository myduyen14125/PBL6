<template>
  <div class="wrapper-upload cursor-pointer" :class="$attrs.imgsrc !== '' ? '' : 'bg-default'"  @click="toggleShow">
    <div class="d-flex align-items-center">
      <div class="btn-upload cursor-pointer">
        <img src="~/assets/icons/cloud-upload.svg" alt="icon upload" />
      </div>
      <div v-if="show" @click.stop>
        <vue-image-crop-upload
          v-model="show"
          field="file"
          :url="getUploadUrl"
          :headers="headers"
          :width="$attrs.width"
          :height="$attrs.height"
          :lang-type="'en'"
          :max-size="25000"
          :value.sync="show"
          @crop-success="cropSuccess"
          @crop-upload-success="cropUploadSuccess"
          @crop-upload-fail="cropUploadFail"
        ></vue-image-crop-upload>
      </div>
      <div 
        :class="[
          {'image-thumbnail': $attrs.imgtype === ''},
          {'image-logo': $attrs.imgtype === 'logo'},
          {'image-background': $attrs.imgtype === 'background'},
          {'image-detail': $attrs.imgtype === 'detail'},
        ]" 
        class="image">
        <img v-if="$attrs.imgsrc !== ''" :src="$attrs.imgsrc" alt="" />
        <img v-else-if="imgDataUrl" :src="imgDataUrl" />
      </div>
      <!-- <img :src="imgDataUrl" /> -->
    </div>
  </div>
</template>

<script>
// import { ValidationProvider } from 'vee-validate'

export default {
  name: 'VImageCropUpload',
  components: {
    // ValidationProvider,
  },
  props: {
    isLogo: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      show: false,
      headers: {
        smail: '*_~',
      },
      imgDataUrl: '', // the datebase64 url of created image
      canUpload: false,
    }
  },
  computed: {
    getUploadUrl() {
      return process.env.BASE_URL_API + '/storages'
    },
  },
  methods: {
    toggleShow() {
      this.show = !this.show
    },
    cropSuccess(imgDataUrl, field) {
      this.imgDataUrl = imgDataUrl
    },
    cropUploadSuccess(jsonData, field) {
      this.$emit('get-data-url', jsonData.data)
      this.show = false
      return jsonData.data
    },
    cropUploadFail(status, field) {},
  },
}
</script>
<style lang="scss" scoped>
.wrapper-upload {
  position: relative;
  border: 1px solid $color-gray-lighter;
  border-radius: 10px;
  // background: linear-gradient(0deg, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(('~/assets/images/no-result.png'));
}
.bg-default::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(('~/assets/images/no-result.png'));
  background-size: contain;
  background-repeat: no-repeat; 
  background-position: center; 
  border-radius: 10px;
}

.image {
  border-radius: 10px;
  // img {
  //   border-radius: 10px;
  //   height: 86px;
  // }
  &-thumbnail {
    box-sizing: border-box;
    img {
      width: 263px;
      height: 200px;
      border-radius: 10px;
    }
  }
  &-logo {
    box-sizing: border-box;
    img {
      border-radius: 10px;
      width: 86px;
      height: 86px;
    }
  }
  &-background {
    box-sizing: border-box;
    img {
      border-radius: 10px;
      height: 340px;
      width: 780px;
    }
  }
  &-detail {
    box-sizing: border-box;
    img {
      border-radius: 10px;
      width: 780px;
      height: 248.38px;
    }
  }
}

.btn-upload {
  position: absolute;
  top: calc(50% - 25px);
  left: calc(50% - 25px);
  cursor: pointer;
  z-index: 10;
}
</style>
