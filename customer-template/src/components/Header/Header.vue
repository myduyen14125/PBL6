<template>
  <header class="header flex items-center">
    <div class="container">
      <nav class="relative px-4 py-4 flex justify-between items-center">
        <a class="text-3xl font-bold leading-none" href="#">
          <img :src="logo" alt="Logo" />
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
          <button class="btn hover:bg-[#138496] hover:border-[#117a8b]">
            Đăng nhập
          </button>
        </router-link>
        <router-link to="/sign-up" class="hidden lg:inline-block">
          <button class="btn hover:bg-[#138496] hover:border-[#117a8b]">
            Đăng ký
          </button>
        </router-link>
      </nav>
      <div class="navbar-menu relative z-50 hidden">
        <div class="navbar-backdrop fixed inset-0 bg-gray-800 opacity-25"></div>
        <nav
          class="fixed top-0 left-0 bottom-0 flex flex-col w-5/6 max-w-sm bg-white border-r overflow-y-auto"
        >
          <div class="flex items-center mb-8 bg-primaryColor px-6">
            <a class="mr-auto text-3xl font-bold leading-none" href="#">
              <img :src="logo" alt="Logo" />
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
                    'block p-4 text-primaryColor bg-[#D0DEDB] leading-7 font-[700] hover:bg-[#D0DEDB] hover:text-primaryColor rounded-xl':
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
                class="block p-4 mb-2 text-center text-primaryColor leading-7 font-[700] hover:bg-[#D0DEDB] hover:text-primaryColor rounded-xl border-[2px] border-[#D0DEDB]"
              >
                Đăng nhập
              </router-link>
              <router-link
                to="/sign-up"
                class="block p-4 mb-2 text-center text-primaryColor leading-7 font-[700] hover:bg-[#D0DEDB] hover:text-primaryColor rounded-xl border-[2px] border-[#D0DEDB]"
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
