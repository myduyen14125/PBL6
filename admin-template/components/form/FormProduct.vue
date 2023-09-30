<template>
  <div class="overflow-auto h-90">
    <ValidationObserver ref="form">
      <form
        class="form-wrapper mx-auto h-100"
        method="POST"
        @submit.prevent="onSubmit()"
      >
        <div class="d-flex">
          <div class="col-lg-12 px-0">
            <div class="form-group color-primary">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:200"
                name="title"
              >
                <label for="name">
                  Title
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.title"
                  type="text"
                  class="form-control color-secondary"
                  name="name"
                  placeholder="Enter product title"
                  @blur="trimInput(data, 'title')"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                :rules="thumbnailUrl ? '' : 'required'"
                name="image"
              >
                <label>
                  Upload thumbnail image
                  <span class="text-danger __label">*</span>
                </label>
                <vue-image-upload
                  :width="526"
                  :height="400"
                  imgtype=""
                  class="img-thumbnail"
                  :imgsrc="thumbnailUrl"
                  @get-data-url="(data) => getDataUrl(data, 'thumbnail')"
                ></vue-image-upload>
                <span v-if="!thumbnailUrl && errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                :rules="logoUrl ? '' : 'required'"
                name="logo image"
              >
                <label for="logo">
                  Upload logo image
                  <span class="text-danger __label">*</span>
                </label>
                <vue-image-upload
                  :width="172"
                  :height="172"
                  imgtype="logo"
                  class="img-logo"
                  :imgsrc="logoUrl"
                  @get-data-url="(data) => getDataUrl(data, 'logo')"
                ></vue-image-upload>
                <span v-if="!logoUrl && errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                :rules="backgroundUrl ? '' : 'required'"
                name="background image"
              >
                <label>
                  Upload background image
                  <span class="text-danger __label">*</span>
                </label>
                <vue-image-upload
                  :width="1920"
                  :height="700"
                  imgtype="background"
                  class="img-background"
                  :imgsrc="backgroundUrl"
                  @get-data-url="(data) => getDataUrl(data, 'background')"
                ></vue-image-upload>
                <span v-if="!backgroundUrl & errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|url"
                name="link product"
              >
                <label>
                  Link Product
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.link"
                  type="text"
                  class="form-control color-secondary"
                  placeholder="Import product's link"
                  maxlength="1000"
                  @blur="trimInput(data, 'link')"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                ref="description"
                v-slot="{ errors }"
                rules="required|max:500"
                name="link product"
              >
                <label for="content">
                  Description
                  <span class="text-danger __label">*</span>
                </label>
                <textarea
                  v-model="data.description"
                  class="form-control color-secondary"
                  name="message"
                  rows="4"
                  placeholder="Enter product description"
                  @blur="trimInput(data, 'description')"
                ></textarea>
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <!-- <div v-if="product.id" class="form-group color-primary mt-4 d-flex align-items-center">
              <div class="content-title mr-3 font-14">Published</div>
              <div class="switch-toggle">
                <label class="switch">
                  <input v-model="data.published" type="checkbox" @click="markPublic()">
                  <span class="slider round cursor-pointer"></span>
                </label>
              </div>
            </div> -->
            <!-- Button submit -->
            <div class="form-group mt-4">
              <button type="submit" class="btn-custom btn-blue">
                {{ product.id ? 'Update' : 'Create' }}
              </button>
            </div>
          </div>
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import VueImageUpload from '@/components/common/VImageCropUpload.vue'

export default {
  name: 'FormContact',
  components: {
    ValidationObserver,
    ValidationProvider,
    VueImageUpload,
  },
  props: {
    product: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {}
  },
  computed: {
    data() {
      return this.product
    },
    thumbnailUrl: {
      get() {
        return this.data.thumbnail_url ? this.data.thumbnail_url : ''
      },
      set(newValue) {
        // this.data.thumbnail_url = newValue
        this.$set(this.data, 'thumbnail_url', newValue)
      },
    },
    logoUrl: {
      get() {
        return this.data.logo_url ? this.data.logo_url : ''
      },
      set(newValue) {
        this.$set(this.data, 'logo_url', newValue)
      },
    },
    backgroundUrl: {
      get() {
        return this.data.background_url ? this.data.background_url : ''
      },
      set(newValue) {
        this.$set(this.data, 'background_url', newValue)
      },
    },
  },
  methods: {
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            this.$emit('submit', this.product)
          }
          else {
            console.log('error', this.$refs.form)
            const error = document.querySelector('.validate-text')
            error.scrollIntoView({ behavior: 'smooth', block: 'center' })     
          }
        })        
      } catch (error) {
        // Display all errors in the UI
        Object.values(this.$refs).forEach((ref) => {
          if (ref.errors) {
            ref.errors.forEach((error) => {
              ref.setError(error)
            })
          }
        })
      }
    },
    markPublic() {
      this.$emit('mark-public', this.product.id)
    },
    async uploadAndPreviewFile(type) {
      const file =
        type === 'thumbnail'
          ? this.$refs.thumbnailInput.files[0]
          : type === 'logo'
          ? this.$refs.logoInput.files[0]
          : type === 'background'
          ? this.$refs.backgroundInput.files[0]
          : null
      const formData = new FormData()
      formData.append('file', file)

      const response = await this.uploadFile(formData)
      console.log(response)
      if (type === 'thumbnail') {
        this.thumbnailUrl = URL.createObjectURL(file)
        this.data.thumbnail_url = response
      } else if (type === 'logo') {
        this.logoUrl = URL.createObjectURL(file)
        this.data.logo_url = response
      } else if (type === 'background') {
        this.backgroundUrl = URL.createObjectURL(file)
        this.data.background_url = response
      }
    },
    uploadFile(data) {
      return this.$api.upload.uploadFile(data).then((res) => res.data.data)
    },
    getDataUrl(data, type) {
      if (type === 'thumbnail') {
        this.thumbnailUrl = data
      } else if (type === 'logo') {
        this.logoUrl = data
      } else if (type === 'background') {
        this.backgroundUrl = data
      }
    },
  },
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
.form-group {
  label {
    font-size: 14px;
  }
  input {
    width: 780px;
    &::placeholder {
      color: $color-secondary;
    }
  }
  textarea {
    width: 780px;
    &::placeholder {
      color: $color-secondary;
    }
  }
}
.img {
  &-thumbnail {
    width: 263px;
    height: 200px;
    padding: 0;
  }
  &-logo {
    width: 86px;
    height: 86px;
    padding: 0;
  }
  &-background {
    width: 780px;
    height: 340px;
    padding: 0;
  }
}
</style>