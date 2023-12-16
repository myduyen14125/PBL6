<template>
  <header class="bg-white">
    <client-only>
      <div
        class="navbar-wrapper mx-4 pl-2 w-100 d-flex justify-content-between align-items-center"
      >
        <div class="left-nav d-flex">
          <div class="logo">
            <div v-if="!isToggleNavbar">
              <img
                src="~/assets/images/logo-it.png"
                alt="logo"
                height="100px"
              />
              <img
                class="ml-35px cursor-pointer"
                src="~/assets/icons/chevron-left.svg"
                @click="toggleNavbar"
              />
            </div>
            <div v-else>
              <img
                src="~/assets/images/logo/icon-logo.png"
                alt="logo"
                height="70px"
              />
              <img
                class="ml-1 cursor-pointer"
                src="~/assets/icons/chevron-right.svg"
                @click="toggleNavbar"
              />
            </div>
          </div>
        </div>

        <div class="right-nav d-flex align-items-center position-relative">
          <div v-if="$auth.loggedIn" class="d-flex align-items-center">
            <!-- <div class="notification">
              <font-awesome-icon class="color-gray-darker" icon="fa-solid fa-bell" />
            </div> -->
            <div
              v-click-outside="onCloseUserInfo"
              class="avatar ml-3 d-flex justify-content-center align-items-center"
              @click="isToggleUserInfo = !isToggleUserInfo"
            >
              <font-awesome-icon
                class="icon-user color-blue"
                icon="fa-solid fa-user"
              />
            </div>
          </div>
          <div v-else class="d-flex align-items-center">
            <!-- contain switch language and button -->
            <!-- V-if not loggin -->
            <button class="btn-custom btn-blue" @click="logOut">Logout</button>
          </div>
          <UserInfo v-if="isToggleUserInfo" />
        </div>
      </div>
    </client-only>
  </header>
</template>
<script>
import UserInfo from "../modal/UserInfo.vue";

export default {
  components: {
    UserInfo,
  },
  data() {
    return {
      isToggleUserInfo: false,
      isToggleNavbar: false,
    };
  },
  methods: {
    onCloseUserInfo() {
      this.isToggleUserInfo = false;
    },
    toggleNavbar() {
      this.isToggleNavbar = !this.isToggleNavbar;
      this.$emit("toggle", this.isToggleNavbar);
    },
    logOut() {
      sessionStorage.removeItem("IT_MENTOR_accessToken");
      this.$router.push({ path: "/login" });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "~/assets/scss/active-navbar.scss";

header {
  position: fixed;
  top: 0;
  right: 0;
  width: 100%;
  z-index: 99;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: transparent;
  transition: 0.3s ease-out;
}
.navbar-wrapper {
  height: 76px;
  padding: 1rem 0;
  color: $color-white;
  transition: 0.3s ease-out;
  .logo {
    font-size: 1.5rem;
    font-weight: 700;
  }
  .right-nav {
    .notification {
      font-size: 1.4rem;
      font-weight: 700;
    }
    .avatar {
      width: 40px;
      height: 40px;
      border: 1px solid $color-blue;
      border-radius: 50%;
      cursor: pointer;
    }
    button {
      padding: 0.5rem 1rem;
    }
  }
}

.switch {
  &-wrapper {
    border: none;
    background: transparent;
    color: $color-white;
    font-size: 18px;
    margin-right: 1rem;
  }
  &--item {
    font-size: 18px;
    font-weight: 400;
  }
}

.ml-35px {
  margin-left: 35px;
}
</style>
