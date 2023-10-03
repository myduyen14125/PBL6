<template>
  <header class="header flex items-center">
    <div class="container">
      <div class="flex items-center justify-between">
        <div>
          <img :src="logo" alt="Logo" />
        </div>
        <div class="navigation">
          <ul class="menu flex items-center gap-[1.7rem]">
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
            <li>
              <router-link to="/sign-in">
                <button class="btn hover:bg-[#138496] hover:border-[#117a8b]">
                  Đăng nhập
                </button>
              </router-link>
            </li>
            <li>
              <router-link to="/sign-up">
                <button class="btn hover:bg-[#138496] hover:border-[#117a8b]">
                  Đăng ký
                </button>
              </router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </header>
</template>

<script lang="ts" src="./Header.ts"></script>
