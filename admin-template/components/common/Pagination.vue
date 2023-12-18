<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div class="pagination mt-2 mb-2">
    <div
      class="pagination__prev mr-3"
      :disabled="currentPageLocal === 1"
      @click.prevent="changePage(1)"
    >
      <font-awesome-icon icon="fa-solid fa-chevron-left" />
      <font-awesome-icon
        class="chevron-double-left"
        icon="fa-solid fa-chevron-left"
      />
    </div>
    <div
      class="pagination__prev mr-2-5"
      :disabled="currentPageLocal === 1"
      @click.prevent="changePage(currentPageLocal - 1)"
    >
      <font-awesome-icon icon="fa-solid fa-chevron-left" />
    </div>

    <div v-for="(pageNumber, index) in pages" :key="index">
      <span
        v-if="pageNumber"
        class="pagination__link"
        :class="[
          { active: pageNumber === currentPageLocal },
          { 'pagination__link--dots': pageNumber == '...' },
        ]"
        @click.prevent="changePage(pageNumber)"
      >
        {{ pageNumber }}</span
      >
    </div>

    <div
      class="pagination__next ml-2-5"
      :disabled="currentPageLocal === totalPages"
      @click.prevent="changePage(currentPageLocal + 1)"
    >
      <font-awesome-icon icon="fa-solid fa-chevron-right" />
    </div>
    <div
      class="pagination__next ml-3"
      :disabled="currentPageLocal === totalPages"
      @click.prevent="changePage(totalPages)"
    >
      <font-awesome-icon
        class="chevron-double-right"
        icon="fa-solid fa-chevron-right"
      />
      <font-awesome-icon icon="fa-solid fa-chevron-right" />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    currentPage: {
      type: Number,
      required: true,
    },
    totalPages: {
      type: Number,
      required: true,
    },
    pagesToShow: {
      type: Number,
      default: 10,
    },
  },
  data() {
    return {
      pages: [],
      currentPageLocal: null,
    };
  },
  computed: {
    // pages() {
    //   const pages = []
    //   for (let i = 1; i <= this.totalPages; i++) {
    //     pages.push({ index: i, isShow: this.showPage(i) })
    //   }
    //   return pages
    // },
  },
  watch: {
    currentPageLocal: {
      handler() {
        this.handlePages();
      },
    },
    currentPage: {
      handler() {
        this.currentPageLocal = this.currentPage;
      },
    },
    totalPages: {
      handler() {
        this.handlePages();
      },
    },
  },
  created() {
    this.currentPageLocal = this.currentPage;
    this.currentPageLocal = this.$route.query.page
      ? parseInt(this.$route.query.page)
      : 1;
  },
  mounted() {
    this.handlePages();
  },
  methods: {
    changePage(pageNumber) {
      const regexNumber = /^[0-9]*$/;
      if (!regexNumber.test(pageNumber)) {
        return;
      }
      this.$emit("page-changed", pageNumber);
    },
    handlePages() {
      this.pages = [];
      for (let i = 1; i <= this.totalPages; i++) {
        if (this.showPage(i)) {
          this.pages.push(i);
        }
      }
      this.pages = this.pages.reduce((acc, curr) => {
        if (acc.length && curr - acc[acc.length - 1] > 1) {
          acc.push("...");
        }

        acc.push(curr);
        return acc;
      }, []);
    },
    showPage(currentPageLocal) {
      if (currentPageLocal === 1 || currentPageLocal === this.totalPages) {
        return true;
      }
      if (
        this.currentPageLocal === 1 ||
        this.currentPageLocal === this.totalPages
      ) {
        if (Math.abs(currentPageLocal - this.currentPageLocal) <= 2) {
          return true;
        }
      } else if (Math.abs(currentPageLocal - this.currentPageLocal) <= 1) {
        return true;
      }
    },
  },
};
</script>

<style scoped lang="scss">
.chevron-double-left {
  position: relative;
  left: -5px;
}
.chevron-double-right {
  position: relative;
  right: -5px;
}
.pagination {
  display: flex;
  justify-content: center;
  list-style: none;
  margin: 0;
  padding: 0;
  position: absolute;
  bottom: 0;
  left: 42%;

  &__prev,
  &__next {
    background-color: transparent;
    border: none;
    color: $color-blue;
    cursor: pointer;
    font-size: 1rem;
    display: inline-flex;
    align-items: center;

    &:hover {
      text-decoration: underline;
    }

    &[disabled] {
      color: $color-gray;
      cursor: default;
      pointer-events: none;
    }
  }

  &__link {
    background-color: transparent;
    border: none;
    color: $color-secondary;
    cursor: pointer;
    font-size: 1rem;
    margin: 0 2px;
    padding: 2px 6px;
    text-align: center;
    display: inline-flex;
    align-items: center;
    transition: all 0.2s ease-in-out;
    &--dots {
      cursor: default !important;
      &:hover {
        background-color: transparent !important;
      }
    }
    &.active {
      background-color: $bg-blue-lighter;
      color: $color-blue;
      border-radius: 5px;
      cursor: default;
      &:hover {
        background-color: $bg-blue-lighter;
      }
    }

    &:hover {
      background-color: $color-gray-lighter;
      border-radius: 5px;
      text-decoration: none;
    }
  }

  .fa-chevron-left,
  .fa-chevron-right {
    font-size: 1rem;
  }
}
</style>
