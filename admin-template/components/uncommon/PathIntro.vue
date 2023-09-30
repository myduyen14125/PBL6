<template>
  <div class="intro-wrapper py-80">
    <div class="container px-xl-0">
      <div class="path">
        <nuxt-link to="/">
          <span class="root">Home</span>
        </nuxt-link>
        <img src="@/assets/images/chevron-right.svg" alt="" />
        <span class="child">{{ childPath }}</span>
      </div>
      <div class="d-flex justify-content-between pt-80">
        <div class="left hiddenLeft">
          <span class="data-label">{{ dataLabel }}</span>
          <h2 class="title mt-2-5">{{ title }}</h2>
        </div>
        <div class="right hiddenRight">
          <p class="desc">{{ desc }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    childPath: {
      type: String,
      default: '',
    },
    dataLabel: {
      type: String,
      default: '',
    },
    title: {
      type: String,
      default: '',
    },
    desc: {
      type: String,
      default: '',
    },

  },
  mounted() {
    this.$handleAllLazyLoad();
  },
}
</script>
<style lang="scss" scoped>
.intro-wrapper {
  .left {
    width: 40%;
  }
  .right {
    width: 55%;
  }
}
</style>