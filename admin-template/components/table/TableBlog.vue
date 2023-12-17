<template>
  <div>
    <div
      class="table-header d-flex flex-wrap align-items-center justify-content-between mb-2 gap-4"
    >
      <h1 class="title">{{ title }}</h1>
      <!-- <div class="d-flex">
        <ComboBox
          v-if="blogList.length > 0"
          :options-prop="blogList"
          :placeholder="'Select blog'"
          @selection-change="handleSelect"
        />
      </div> -->
      <SearchInput @search="handleSearch" />
      <nuxt-link to="/blogs/create">
        <button class="btn-custom btn-blue">Create blog</button>
      </nuxt-link>
    </div>
    <div class="table-wrapper w-100 position-relative">
      <div class="layer-new-block"></div>
      <div ref="table" class="table-overflow overflow-auto d-block h-90">
        <table class="table table-striped">
          <thead class="color-primary table-head">
            <tr>
              <th scope="col" class="text-start">Image</th>
              <th scope="col" class="text-start">Title</th>
              <th scope="col" class="text-start">Author</th>
              <th scope="col" class="text-start">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in data" :key="index">
              <td>
                <img v-if="item?.image" class="avatar" :src="item?.image" />
              </td>
              <td class="color-primary text-start">
                <span class="td-content">
                  <nuxt-link
                    :to="`/blogs/${item?._id}`"
                    class="cursor-pointer color-primary text-hover-color"
                    >{{ item?.title }}</nuxt-link
                  >
                </span>
              </td>
              <td class="cursor-pointer text-start">
                <nuxt-link
                  :to="`/mentor/${item?._id}`"
                  class="td-content color-secondary text-hover-color"
                  >{{ item?.user?.name }}</nuxt-link
                >
              </td>
              <td class="color-secondary pl-4 w-25-2 d-flex">
                <button
                  class="btn rounded bg-white border-2 border-secondary mr-3 bg-hover"
                >
                  <nuxt-link :to="`/blogs/${item._id}/update`">
                    <font-awesome-icon
                      class="icon color-secondary"
                      icon="fa-solid fa-pen-clip"
                    />
                  </nuxt-link>
                </button>

                <button
                  class="btn rounded bg-white border-2 border-secondary bg-hover"
                >
                  <font-awesome-icon
                    class="icon cursor-pointer"
                    icon="fa-solid fa-trash-alt"
                    @click="(e) => onDeleteBlog(e, item?._id)"
                  />
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import SearchInput from "../uncommon/SearchInput.vue";
// import ComboBox from "../uncommon/ComboBox.vue";
import Swal from "sweetalert2";

export default {
  components: {
    SearchInput,
    // ComboBox,
  },
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: "Quản lý mentor",
    },
  },
  data() {
    return {};
  },
  mounted() {},
  methods: {
    handleRouting(id) {
      this.$router.push(`/blogs/${id}`);
    },
    handleSearch(content) {
      this.$emit("searchContent", content);
    },
    onDeleteBlog(e, id) {
      e.stopPropagation();
      Swal.fire({
        title: "Are you sure you want to delete?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          this.deleteBlog(id);
        }
      });
    },
    deleteBlog(id) {
      // eslint-disable-next-line no-console
      this.$api.contact
        .deleteBlog(id)
        .then((res) => {
          this.$toast.success("Create successfully!", {
            className: "my-toast",
          });
          this.$emit("reloadTable");
        })
        .catch((err) => {
          this.$toast.error("Create failed!", {
            className: "my-toast",
          });
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.td-content {
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

.avatar {
  width: 40px;
  height: 40px;
}

.text-start {
  text-align: start;
}

.bg-hover:hover {
  background-color: cadetblue !important;
}

.text-hover-color:hover {
  color: black !important;
}
</style>
