<template>
  <div class="login-wrapper d-flex align-items-center bg-gray">
    <div class="left-col d-flex flex-column align-items-center">
      <div class="logo text-center">
        <img src="~/assets/icons/icon-logo.png" alt="" />
      </div>
      <div class="image mt-5">
        <img src="~/assets/images/login/sticker-1.png" alt="" />
      </div>
    </div>
    <div
      class="right-col d-flex justify-content-center align-items-center bg-white h-100"
    >
      <LoginForm />
    </div>
  </div>
</template>

<script>
import LoginForm from "~/components/form/LoginForm.vue";
export default {
  name: "PagesIndex",
  components: {
    LoginForm,
  },
  layout: "unauth",
  mounted() {
    this.$handleAllLazyLoad();
  },
};
</script>

<style lang="scss">
.login-wrapper {
  height: 100vh;
  .logo {
    img {
      width: 150px;
    }
  }
  .left-col {
    width: 45%;
  }
  .right-col {
    width: 55%;
    box-shadow: 0px 16px 24px rgba(71, 79, 98, 0.12);
    border-radius: 80px 0px 0px 80px;
  }
}
</style>
