<template>
  <div>
    <!-- <TopNavbar :is-navbar-white="true"/> -->
    <Nuxt />
  </div>
</template>

<script>
import TopNavbar from '~/components/common/TopNavbar.vue';
export default {
  name: 'DefaultLayout',
  components: {
    // eslint-disable-next-line vue/no-unused-components
    TopNavbar,
  },
}
</script>
<style lang="scss">
/* home route and active route will show in bold as it matches / and /about */
// a.nuxt-link-active {
//   font-weight: bold !important;
// }

/* exact link will show the primary color for only the exact matching link */
a.nuxt-link-exact-active {
  // color: $color-blue !important;
  // font-weight: bold !important;
}
</style>
