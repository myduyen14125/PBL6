<template>
  <header :class="{'white-nav bg-white': isScroll}">
    <client-only>
      <div
        class="
          navbar-wrapper
          container
          d-flex
          justify-content-between
          align-items-center
        "
      >
        <div class="logo">
          <nuxt-link to="/">
            <img src="~/assets/images/logo-it.png" alt="" />
          </nuxt-link>
        </div>
        
        <div class="right-nav d-flex align-items-center">
          <!-- contain switch language and button -->
          <!-- <select class="switch-wrapper cursor-pointer">
            <option class="px-3" value="en"><span class="switch--item">EN</span></option>
            <option class="px-3" value="vi"><span class="switch--item">VI</span></option>
            <option class="px-3" value="vi"><span class="switch--item">JA</span></option>
          </select> -->
          <button class="btn-custom btn-blue"><nuxt-link to="/login" @click.prevent.stop>Login</nuxt-link></button>
        </div>
      </div>
    </client-only>
  </header>
</template>
<script>
import { onMounted, ref } from 'vue'

export default {
  props: {
    isNavbarWhite: Boolean
  },

  setup(props) {
    
    const isScroll = props.isNavbarWhite ? ref(true) : ref(false)
    const handleScroll = () => {
      if (window.scrollY > 0) {
        isScroll.value = true
      } else {
        isScroll.value = false
      }
    }

    onMounted(() => {
      window.addEventListener('scroll', {
        // if isNavbarWhite is true, it will not do the handleScroll function
        handleEvent: () => {
          if (!props.isNavbarWhite) {
            handleScroll()
          }
        }
      })
    })
    return {
      isScroll,
      handleScroll
    }
  },
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/active-navbar.scss';
header {
  position: fixed;
  top: 0;
  right: 0;
  width: 100%;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: transparent;
  transition: 0.3s ease-out;
}
.navbar-wrapper {
  height: 80px;
  padding: 1rem 0;
  color: $color-white;
  transition: 0.3s ease-out;
  .logo {
    font-size: 1.5rem;
    font-weight: 700;
  }
  nav {
    ul {
      li {
        display: inline-block;
        margin-right: 40px;
        a {
          text-decoration: none;
          color: $color-white;
          font-size: 18px;
          font-weight: 400;
          padding-bottom: 8px;
          border-bottom: 3px solid transparent;
          transition: 0.3s ease-out;
          &:hover {
            border-bottom: 3px solid $color-white;
          }
        }
      }
    }
  }
  .right-nav {
    .switch-wrapper {
      span {
        margin-right: 0.5rem;
      }
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

</style>