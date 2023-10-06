<template>
  <header class="header d-flex align-items-center">
    <div class="container">
      <nav
        class="position-relative px-4 py-4 d-flex justify-content-between align-items-center"
      >
        <a href="/">
          <img :src="logo" alt="Logo" width="60" height="60" />
        </a>
        <ul
          class="d-none ms-lg-auto d-lg-flex align-items-lg-center w-lg-auto gap-4 mb-lg-0"
        >
          <li v-for="item in navLinks" :key="item.path" class="list-style-none">
            <router-link :to="item.path" class="router-link">
              {{ item.name }}
            </router-link>
          </li>
        </ul>
        <ul
          class="ms-auto ms-lg-0 me-4 d-flex align-items-center w-auto gap-4 mb-0"
        >
          <li>
            <el-tooltip
              class="box-item"
              effect="light"
              content="Lịch hẹn của tôi"
              placement="bottom"
            >
              <router-link to="#"
                ><span><SvgIcon icon="calendarMenu" /></span
              ></router-link>
            </el-tooltip>
          </li>
          <li>
            <el-tooltip
              class="box-item"
              effect="light"
              content="Tin nhắn"
              placement="bottom"
            >
              <router-link to="#"
                ><div class="dropdown">
                  <div
                    type="button"
                    id="dropdownMenuButton1"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                  >
                    <SvgIcon icon="messengerMenu" />
                  </div>
                  <ul
                    class="dropdown-menu dropdown-menu-end message-dropdown"
                    aria-labelledby="dropdownMenuButton1"
                  >
                    <li><h5 class="border-bottom p-3 m-0">Tin nhắn</h5></li>
                    <l1 v-for="n in 2" :key="n">
                      <MessageCard />
                    </l1>
                  </ul></div
              ></router-link>
            </el-tooltip>
          </li>
        </ul>

        <router-link to="/sign-in" class="d-none d-lg-inline-block me-lg-4">
          <button class="btn btn-primary">Đăng nhập</button>
        </router-link>
        <router-link to="/sign-up" class="d-none d-lg-inline-block">
          <button class="btn btn-primary">Đăng ký</button>
        </router-link>
        <div class="d-lg-none">
          <button
            class="navbar-burger d-flex align-items-center text-primaryColor p-3 rounded-3"
          >
            <SvgIcon icon="toggleMenu" />
          </button>
        </div>
      </nav>
      <div class="navbar-menu position-relative z-50 d-none">
        <div class="navbar-backdrop position-fixed"></div>
        <nav class="sidebar">
          <div class="sidebar-header">
            <a class="mr-auto text-3xl font-bold leading-none" href="#">
              <img :src="logo" alt="Logo" width="60" height="60" />
            </a>
            <button class="navbar-close p-3 rounded-3">
              <SvgIcon icon="closeMenu" />
            </button>
          </div>
          <div>
            <ul class="pl-0">
              <li
                v-for="item in navLinks"
                :key="item.path"
                class="mb-1 px-6 list-style-none"
              >
                <router-link :to="item.path" class="router-link">
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
