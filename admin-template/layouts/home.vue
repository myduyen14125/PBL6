<template>
  <div>
    <HomeNavbar />
    <Nuxt />
    <Footer />
  </div>
</template>

<script>
import HomeNavbar from '~/components/uncommon/HomeNavbar.vue';
import Footer from '~/components/common/Footer.vue';

export default {
  name: 'HomeLayout',
  components: {
    HomeNavbar,
    // eslint-disable-next-line vue/no-reserved-component-names
    Footer
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
