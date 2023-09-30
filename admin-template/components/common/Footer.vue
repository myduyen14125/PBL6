<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div class="footer-wrapper">
    <div class="container px-xl-0">
      <div class="d-flex">
        <div class="left-col">
          <ul class="path-block nav-link d-flex align-items-center p-0">
            <li class="nav-item"><nuxt-link to="/about">About Us</nuxt-link></li>
            <li class="nav-item"><nuxt-link to="/service">Service</nuxt-link></li>
            <li class="nav-item"><nuxt-link to="/product">Product</nuxt-link></li>
            <li class="nav-item"><nuxt-link to="/news">News</nuxt-link></li>
            <li class="nav-item"><nuxt-link to="/recruitment">Recruitment</nuxt-link></li>
            <li class="nav-item"><nuxt-link to="/contact">Contact Us</nuxt-link></li>
          </ul>
        </div>
        <div class="right-col">
          <div class="logo"><nuxt-link to="/"><img src="~/assets/icons/icon-logo.png" alt=""></nuxt-link></div>
          <div class="list-icon mt-4">
            <ul class="d-flex align-items-center p-0">
              <li class="nav-item d-flex justify-content-center align-items-center">
                <nuxt-link to="#" class="d-flex align-items-center">
                  <img src="~/assets/icons/facebook-f.svg" alt="">
                </nuxt-link>
              </li>
              <li class="nav-item d-flex justify-content-center align-items-center">
                <nuxt-link to="#" class="d-flex align-items-center">
                  <img src="~/assets/icons/twitter.svg" alt="">
                </nuxt-link>
              </li>
              <li class="nav-item d-flex justify-content-center align-items-center">
                <nuxt-link to="#" class="d-flex align-items-center">
                  <img src="~/assets/icons/google.svg" alt="">
                </nuxt-link>
              </li>
              <li class="nav-item d-flex justify-content-center align-items-center">
                <nuxt-link to="#" class="d-flex align-items-center">
                  <img src="~/assets/icons/youtube.svg" alt="">
                </nuxt-link>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <hr />
      <p class="text-center color-secondary">Copyright© IT Mentor, Inc. All rights reserved.</p>
    </div>
  </div>
</template>
<style lang="scss" scoped>
a {
  text-decoration: none;
  color: $color-primary;
  transition: 0.3s ease-out;
  &:hover {
    color: $color-blue;
  }
}
ul {
  li {
    display: inline-block;
    margin-right: 40px;
    a {
      font-size: 20px;
      font-weight: 500;
    }
  }
}
hr {
  margin: 60px 16px;
  background: $color-primary;
}
.footer {
  &-wrapper {
    height: 415px;
    background-color: $bg-blue-lighter;
    padding: 80px 0;
    color: $color-primary;
  }
}
.policy-block {
  margin-top: 100px;
  li {
    margin-left: 30px;
    font-weight: 400;
    font-size: 18px;
    &:nth-child(1) {
      margin-left: 0;
    }
  }
}
.right-col {
  .logo {
    font-size: 20px;
    font-weight: 500;
  }
  input {
    background: $bg-blue-lighter !important;
    color: $color-primary;
    border-radius: 90px;
    padding: 4px 16px;
    outline: none;
  }
}
.list-icon {
  li {
    width: 36px;
    height: 36px;
    margin-right: 12px;
    border: 1px solid $color-primary;
    border-radius: 50%;
    &:nth-child(4) {
      margin-right: 0;
    }
  }
}
</style>