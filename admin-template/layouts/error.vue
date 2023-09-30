<template>
  <div>
    <div class="py-80 container error-layout">
      <div class="d-flex align-items-center h-100">
        <div class="content-wrapper col-lg-6 pl-0">
          <h1 class="title">Error 404</h1>
          <!-- v-if="error.statusCode === 404" -->
          <p class="desc">
            The page you are looking for might have been removed, had its name
            changed, or is temporarily unavailable.
          </p>
          <button class="btn-custom btn-blue mt-4" @click="goBack()">
            Go Back
          </button>
        </div>
        <div class="wrapper-image col-lg-6 pr-0">
          <img src="~/assets/images/notfound-404.png" alt="" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'ErrorLayout',
  components: {
  },
  data() {
    return {
    }
  },
  methods: {
    goBack() {
      this.$router.go(-1)
    }
  }
}
</script>
<style lang="scss" scoped>
a {
  text-decoration: none;
  &:hover {
    text-decoration: none;
  }
}
.error-layout {
  height: 100vh;
}
</style>
