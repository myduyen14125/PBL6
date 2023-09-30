<template>
  <div>
    <TopNavbar :is-navbar-white="true" @toggle="toggleNavbar"/>
    <div class="d-flex pt-80 bg-gray vh-100">
      <Sidebar :is-toggle-navbar="isToggleNavbar"/>
      <transition name="fade">
        <div class="nuxt-wrapper mt-4 mr-4 w-100 bg-white" :class="!isToggleNavbar ? 'nuxt-wrapper-main' : 'nuxt-wrapper-full'">
          <nuxt key="$route.fullPath" />
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import TopNavbar from '~/components/common/TopNavbar.vue';
import Sidebar from '~/components/common/Sidebar.vue';

export default {
  name: 'DefaultLayout',
  components: {
    TopNavbar,
    Sidebar
  },
  data() {
    return {
      isToggleNavbar: false,
    };
  },
  methods: {
    toggleNavbar(isToggleNavbar) {
      this.isToggleNavbar = isToggleNavbar;
    }
  }
}
</script>
<style lang="scss" scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
.vh-100 {
  height: 100vh;
}
.nuxt-wrapper {
  height: calc(100vh - 80px - 24px - 40px);
  padding: 12px 22px;
  box-shadow: 0px 16px 24px rgba(71, 79, 98, 0.12);
  border-radius: 8px;
}
.nuxt-wrapper-main {
  width: calc(100vw - 300px - 48px) !important;
}
.nuxt-wrapper-full {
  width: calc(100vw - 72px - 48px) !important;
}
</style>
