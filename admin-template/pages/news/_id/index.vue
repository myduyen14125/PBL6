<!-- eslint-disable vue/no-v-html -->
<template>
  <div class="h-100 position-relative">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img
          src="@/assets/icons/icon-back.svg"
          alt=""
          width="20px"
          height="20px"
          class="mr-1 cursor-pointer"
          @click="goBack()"
        />
        <h1 class="title">News detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(news.id)">
        Update
      </button>
    </div>
    <hr class="my-2" />
    <div class="content">
      <div class="d-flex align-items-center mb-2">
        <div class="content-title">
          <img class="content-image" :src="news.thumbnail_url" alt="" />
        </div>
        <h1 v-if="news.title" class="title w-60 break-word white-space ml-4">
          {{ news.title.trim() }}
        </h1>
      </div>
      <div class="mb-2">
        <img
          class="content-image-detail"
          :src="news.detail_thumbnail_url"
          alt=""
        />
      </div>
      <ul>
        <li class="list-item py-2 d-flex align-items-center h-38">
          <div class="content-title pl-3 w-90px mr-4">Created at:</div>
          <div class="content-desc">{{ formatDateTime(news.created_at) }}</div>
        </li>
        <li class="list-item py-2 d-flex align-items-center h-38">
          <div class="color-yellow content-title pl-3 w-90px mr-4">
            Publish at:
          </div>
          <div class="content-desc">
            {{ news.published_at ? formatDateTime(news.published_at) : "-" }}
          </div>
        </li>
        <li class="list-item py-2 d-flex align-items-center h-57">
          <div class="content-title pl-3 mr-4">Category</div>
          <div class="content-desc" :class="news.category_id ? 'category' : ''">
            {{ getCategoryName(news.category_id) }}
          </div>
        </li>
        <li class="list-item py-2 d-flex">
          <div class="content-title pl-3 mr-4">Content</div>
          <div
            class="content-desc break-word html-content ql-editor"
            v-html="news.content"
          ></div>
        </li>
        <li class="list-item py-2 d-flex align-items-center h-57">
          <div class="content-title pl-3 mr-4">Published</div>
          <div class="switch-toggle">
            <label class="switch">
              <input
                v-model="news.published"
                type="checkbox"
                @click="markPublic()"
              />
              <span class="slider round"></span>
            </label>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import moment from "moment";
import { mapActions, mapGetters } from "vuex";
export default {
  name: "NewsDetail",
  layout: "secret",
  data() {
    return {
      news: {},
    };
  },
  computed: {
    ...mapGetters({
      categories: "newsCategory/getCategories",
    }),
  },
  created() {
    this.$api.news.getNewsById(this.$route.params.id).then((res) => {
      this.news = res.data.data;
    });
  },
  mounted() {
    this.fetchCategoryList();
  },
  methods: {
    ...mapActions({
      fetchCategoryList: "newsCategory/fetchList",
    }),
    getCategoryName(id) {
      const category = this.categories.find((item) => item.id === id);
      return category ? category.title : "-";
    },
    markPublic() {
      this.$api.news.markPublicNews(this.news.id).then((res) => {
        this.$toast.success("Change status public successfully!", {
          className: "my-toast",
        });
      });
    },
    goBack() {
      this.$router.go(-1);
    },
    goToUpdate(id) {
      this.$router.push(`/news/${id}/update`);
    },
    formatDateTime(date) {
      return moment(new Date(date)).format("DD.MM.YYYY HH:mm");
    },
  },
};
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
      height: 248.38px;
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
    width: 60% !important;
    text-align: justify;
    // margin-left: 14px;
  }
}

::v-deep .html-content {
  padding: 0;
  img {
    max-width: 100%;
    height: auto;
  }
}
.w-90px {
  width: 120px;
}
</style>
