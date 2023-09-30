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
                  placeholder="Enter activity title"
                  @blur="trimInput(data, 'title')"
                />
                <span class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                ref="imageValidator"
                v-slot="{ errors }"
                :rules="thumbnailUrl ? '' : 'required'"
                name="image"
              >
                <label for="phone">
                  Upload thumbnail image
                  <span class="text-danger __label">*</span>
                </label>
                <vue-image-upload
                  :width="526"
                  :height="400"
                  imgtype=""
                  class="img-thumbnail"
                  :imgsrc="thumbnailUrl"
                  @get-data-url="getDataUrl"
                ></vue-image-upload>
                <span v-if="!thumbnailUrl" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>

            </div>
            <!-- <div v-if="activity.id" class="form-group color-primary mt-4 d-flex align-items-center">
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
                {{ activity.id ? 'Update' : 'Create' }}
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
  components: {
    ValidationObserver,
    ValidationProvider,
    VueImageUpload,
  },
  props: {
    activity: {
      type: Object,
      default: () => ({
        title: '',
        thumbnail_url: '',
        published: false,
      }),
    },
  },
  data() {
    return {}
  },
  computed: {
    data() {
      return this.activity
    },
    thumbnailUrl: {
      get() {
        return this.data.thumbnail_url ? this.data.thumbnail_url : ''
      },
      set(newValue) {
        this.$set(this.data, 'thumbnail_url', newValue);
      },
    },
  },
  mounted() {
    console.log("thumbnail url: " + this.thumbnailUrl)
  },
  methods: {
    // onSubmit() {
    //   this.$emit('submit', this.activity)
    // },
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            this.$emit('submit', this.activity)
          }
        })
      } catch (error) {
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
      this.$emit('mark-public', this.activity.id)
    },
    getDataUrl(dataUrl) {
      this.thumbnailUrl = dataUrl
      console.log("dataUrl: " + dataUrl)
      console.log("thumbnail url: ", this.thumbnailUrl)
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
}
</style>