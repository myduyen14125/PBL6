<template>
  <div class="modal-wrapper position-absolute bg-white text-center">
    <!-- <nuxt-link to="/account" class="color-primary">Account</nuxt-link>
    <hr class="my-2"> -->
    <div class="cursor-pointer color-secondary logout" @click="handleLogout()">Log out</div>
  </div>
</template>
<script>
export default {
  name: 'UserInfo',
  methods: {
    handleLogout() {
      this.$auth.logout().then(() => {
        this.$router.push('/login')
      })
    },
  },
}
</script>
<style lang="scss" scoped>
.modal-wrapper {
  right: 0px;
  top: calc(40px + 18px);
  width: 140px;
  padding: 1rem;
  box-shadow: 3px 16px 24px rgba(71, 79, 98, 0.12);
  border-radius: 16px;
  font-weight: 500;
}
a {
  &:hover {
    color: $color-blue;
  }
}
.logout {
  font-size: 14px;
  &:hover {
    color: $color-primary;
  }
}
</style>