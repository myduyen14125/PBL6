<template>
  <div class="search-wrapper color-gray position-relative">
    <form @submit.prevent="handleSubmit">
      <input
        v-model="content"
        maxlength="200"
        class="search-input"
        type="text"
        placeholder="Search..."
      />
      <div class="search-icon d-flex justify-content-center align-items-center">
        <img
          src="~/assets/icons/Search.svg"
          alt="icon search"
          class="cursor-pointer"
          @click="handleSubmit"
        />
      </div>
    </form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      content: "",
    };
  },
  methods: {
    handleSubmit() {
      this.content = this.content.trim();
      this.$emit("search", encodeURIComponent(this.content.trim()));
    },
  },
};
</script>

<style lang="scss" scoped>
.search {
  font-size: 16px;
  &-wrapper {
    width: 332px;
    height: 40px;
  }

  &-input {
    width: 100%;
    height: 40px;
    border-radius: 23px;
    padding: 4px 16px;
    padding-right: 50px;
    background-color: $color-blue-hover;
    &:focus {
      background-color: $color-white;
    }
  }

  &-icon {
    position: absolute;
    border-radius: 23px;
    top: 0px;
    right: 0;
    width: 50px;
    height: 40px;
  }
}
</style>
