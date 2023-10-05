<template>
  <header class="header flex items-center">
    <div class="container">
      <nav class="relative px-4 py-4 flex justify-between items-center">
        <a class="text-3xl font-bold leading-none" href="#">
          <img :src="logo" alt="Logo" width="60" height="60" />
        </a>
        <div class="lg:hidden">
          <button class="navbar-burger flex items-center text-primaryColor p-3">
            <SvgIcon icon="toggleMenu" />
          </button>
        </div>
        <ul
          class="hidden lg:ml-auto lg:mr-5 lg:flex lg:items-center lg:w-auto lg:space-x-6 gap-[1.7rem]"
        >
          <li v-for="item in navLinks" :key="item.path">
            <router-link
              :to="item.path"
              :class="{
                'text-activeNavColor leading-7 font-[700] hover:text-activeNavColor':
                  $route.path === item.path,
                'text-white leading-7 font-[700] hover:text-activeNavColor':
                  $route.path !== item.path,
              }"
            >
              {{ item.name }}
            </router-link>
          </li>
        </ul>
        <router-link to="/sign-in" class="hidden lg:inline-block lg:mr-3">
          <button class="btn btn-primary">Đăng nhập</button>
        </router-link>
        <router-link to="/sign-up" class="hidden lg:inline-block">
          <button class="btn btn-primary">Đăng ký</button>
        </router-link>
      </nav>
      <div class="navbar-menu relative z-50 hidden">
        <div
          class="navbar-backdrop fixed inset-none bg-gray-800 opacity-25"
        ></div>
        <nav
          class="fixed top-0 right-0 bottom-0 flex flex-col w-5/6 max-w-sm bg-white border-r overflow-y-auto"
        >
          <div class="flex items-center mb-8 bg-primaryColor px-6">
            <a class="mr-auto text-3xl font-bold leading-none" href="#">
              <img :src="logo" alt="Logo" width="60" height="60" />
            </a>
            <button class="navbar-close p-3">
              <SvgIcon icon="closeMenu" />
            </button>
          </div>
          <div>
            <ul>
              <li v-for="item in navLinks" :key="item.path" class="mb-1 px-6">
                <router-link
                  :to="item.path"
                  :class="{
                    'block p-4 text-primaryColor bg-[#D0DEDB] leading-7 font-[700] rounded-xl':
                      $route.path === item.path,
                    'block p-4 text-gray-600 leading-7 font-[700] hover:bg-[#D0DEDB] hover:text-primaryColor rounded-xl':
                      $route.path !== item.path,
                  }"
                >
                  {{ item.name }}
                </router-link>
              </li>
            </ul>
          </div>
          <div class="mt-auto">
            <div class="pt-6 px-6">
              <router-link
                to="/sign-in"
                class="btn btn-outline-primary btn-block mb-2"
              >
                Đăng nhập
              </router-link>
              <router-link
                to="/sign-up"
                class="btn btn-outline-primary btn-block mb-2"
              >
                Đăng ký
              </router-link>
            </div>
          </div>
        </nav>
      </div>
    </div>
  </header>
</template>

<script lang="ts" src="./Header.ts"></script>
<style scoped lang="css" src="./style.css"></style>
