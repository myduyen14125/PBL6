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
                  ref="titleInput"
                  v-model="data.title"
                  type="text"
                  class="form-control color-secondary"
                  name="name"
                  placeholder="Enter news title"
                  autofocus
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
                name="thumbnail image"
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
                <span v-if="!thumbnailUrl && errors[0]" class="text-danger __label validate-text"
                  >{{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                :rules="detailThumbnailUrl !== '' ? '' : 'required'"
                name="detail thumbnail image"
              >
                <label for="phone">
                  Upload detail thumbnail image
                  <span class="text-danger __label">*</span>
                </label>
                <vue-image-upload
                  :width="1052"
                  :height="335"
                  imgtype="detail"
                  class="img-detail"
                  :imgsrc="detailThumbnailUrl"
                  @get-data-url="(data) => getDataUrl(data, 'detailThumbnail')"
                ></vue-image-upload>
                <span v-if="!detailThumbnailUrl && errors[0]" class="text-danger __label validate-text"
                  >{{ errors[0] }}
                </span>
              </ValidationProvider>

              <!-- <ValidationProvider v-slot="{ errors }" name="image">
                <input
                  ref="detailThumbnailInput"
                  type="file"
                  accept="image/png, image/jpeg, image/jpg"
                  class="form-control color-secondary"
                  @change="uploadAndPreviewFile('detailThumbnail')"
                />
                <span class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
              <img
                v-if="detailThumbnailUrl"
                :src="detailThumbnailUrl"
                style="width: 100px; height: 100px; object-fit: cover"
              /> -->
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required"
                name="category"
              >
                <label for="role"
                  >Category <span class="text-danger __label">*</span></label
                >
                <v-select
                  v-model="selectedOption"
                  class="style-chooser"
                  placeholder="Choose Category"
                  :options="options"
                  :value="news.category_id ? news.category_id : null"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <label for="content">
                Content detail
                <span class="text-danger __label">*</span>
              </label>
              <AppEditor :content="data.content" @input="updateContent" @has-spaces="onHasSpaces"/>
            </div>
            <!-- <div v-if="news.id" class="form-group color-primary mt-4 d-flex align-items-center">
              <div class="content-title mr-3 font-14">Published</div>
              <div class="switch-toggle">
                <label class="switch">
                  <input v-model="data.published" type="checkbox" :disabled="data.category_id == null" @click="markPublic()">
                  <span class="slider round cursor-pointer"></span>
                </label>
              </div>
            </div> -->
            <!-- Button submit -->
            <div class="form-group mt-4">
              <button :disabled="hasErrors" type="submit" class="btn-custom btn-blue" >
                {{ news.id ? 'Update' : 'Create' }}
              </button>
            </div>
          </div>
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import AppEditor from '@/components/uncommon/AppEditor.vue'
import VueImageUpload from '@/components/common/VImageCropUpload.vue'

export default {
  components: {
    AppEditor,
    ValidationObserver,
    ValidationProvider,
    VueImageUpload,
  },
  props: {
    news: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      // thumbnailUrl: '',
      options: [],
      // selectedOption: null,
      hasErrors: false,
      hasSpaces: false,
    }
  },
  computed: {
    ...mapGetters({
      categories: 'newsCategory/getCategories',
    }),
    data() {
      return this.news
    },
    selectedOption: {
      get() {
        // return (
        //   this.options.find((item) => item.value === this.data.category_id) ||
        //   ''
        // )
        if (Object.prototype.hasOwnProperty.call(this.data, 'category_id')) {
          return (
            this.options.find((item) => item.value === this.data.category_id) || ''
          )
        } else {
          return ''
        }
      },
      set(value) {
        // Check if category_id exists in data
        if (!Object.prototype.hasOwnProperty.call(this.data, 'category_id')) {
          // Add category_id to data
          this.$set(this.data, 'category_id', '')
          this.data.category_id = value.value
        }
        this.data.category_id = value.value
      },
    },

    thumbnailUrl: {
      get() {
        return this.data.thumbnail_url ? this.data.thumbnail_url : ''
      },
      set(newValue) {
        this.$set(this.data, 'thumbnail_url', newValue)
      },
    },
    detailThumbnailUrl: {
      get() {
        return this.data.detail_thumbnail_url
          ? this.data.detail_thumbnail_url
          : ''
      },
      set(newValue) {
        this.$set(this.data, 'detail_thumbnail_url', newValue)
      },
    },
  },
  created() {
    this.fetchCategoryList()
    this.options = this.categories.map((item) => ({
      value: item.id,
      label: item.title,
    }))
  },
  mounted() {
    this.hasSpaces = false
    console.log("news: ", this.data)
  },
  methods: {
    ...mapActions({
      fetchCategoryList: 'newsCategory/fetchList',
    }),
    getCategoryName(id) {
      const category = this.categories.find((item) => item.id === id)
      return category ? category.title : '-'
    },
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            if (!Object.prototype.hasOwnProperty.call(this.data, 'category_id')) {
              // Add category_id to data
              this.$set(this.data, 'category_id', '')
            }
            this.data.category_id = this.selectedOption.value
            console.log("spaces: " + this.hasSpaces)
            if (this.hasSpaces) {
              return
            }
            else {
              this.$emit('submit', this.news);
            }

            this.hasErrors = false
          }
          else {
            const error = document.querySelector('.validate-text')
            error.scrollIntoView({ behavior: 'smooth', block: 'center' })     
          }
        })
        
      } catch (error) {
        this.hasErrors = true
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
      this.$emit('mark-public', this.news.id)
    },
    updateContent(value) {
      this.data.content = value
    },
    getDataUrl(data, type) {
      if (type === 'thumbnail') {
        this.thumbnailUrl = data
      } else {
        this.detailThumbnailUrl = data
      }
    },
    onHasSpaces(hasSpaces) {
      this.hasSpaces = hasSpaces
      console.log("hasSpaces: " + this.hasSpaces, "hasSpaceprop: " + hasSpaces)
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
  &-detail {
    width: 780px;
    height: 248.38px;
    padding: 0;
  }
}
</style>