<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div
    class="sidebar mt-4 mr-4 bg-white"
    :class="isToggleNavbar ? 'sidebar-toggle' : ''"
  >
    <div class="menu">
      <h4 class="menu-title color-gray px-4">Page</h4>
      <ul class="menu-list mt-2-5 color-secondary">
        <li
          v-for="(item, index) in menu"
          :key="index"
          @mouseover="item.isShowTitle = true"
          @mouseleave="item.isShowTitle = false"
        >
          <div
            class="menu-item d-flex align-items-center cursor-pointer"
            :class="item.isShowTitle && isToggleNavbar ? 'w-fit-content' : ''"
          >
            <nuxt-link
              :to="item.link"
              class="d-flex align-items-center w-100 h-100 px-4 position-relative"
            >
              <font-awesome-icon
                v-if="item.icon"
                class="menu-item-icon"
                :icon="item.icon"
              />
              <div v-else class="menu-item-icon">
                <img
                  class="mb-1"
                  :src="
                    $route.path == item.link ||
                    $route.path.includes(item.link + '/')
                      ? item.iconSrcActive
                      : item.iconSrc
                  "
                />
              </div>
              <span
                v-if="!isToggleNavbar || item.isShowTitle"
                class="mr-2 ml-3"
                >{{ item.title }}</span
              >
              <notification-icon
                v-if="item.count"
                :count="item.count"
                :is-toggle="isToggleNavbar"
                :is-show-title="item.isShowTitle"
              />
              <font-awesome-icon
                v-if="item.subMenu && !isToggleNavbar"
                class="dropdown-icon"
                :class="item.isToggleSubItem ? 'rotate-icon' : ''"
                icon="fa-solid fa-angle-right"
                @click="toggleSubItem(item)"
              />
            </nuxt-link>
          </div>
          <!-- sub menu -->
          <ul
            v-if="
              item.subMenu && item.isToggleSubItem == true && !isToggleNavbar
            "
            class="pl-4"
          >
            <li v-for="sub in item.subMenu" :key="sub.id">
              <nuxt-link
                :to="sub.link"
                class="menu-item d-flex align-items-center cursor-pointer px-4"
              >
                <font-awesome-icon class="mr-2 sub-icon" :icon="sub.icon" />
                <span class="mr-2">{{ sub.title }}</span>
              </nuxt-link>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import NotificationIcon from "../uncommon/NotificationIcon.vue";

export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: "Sidebar",
  components: {
    // eslint-disable-next-line vue/no-unused-components
    NotificationIcon,
  },
  props: {
    isToggleNavbar: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      menu: [
        {
          title: "Mentors",
          // icon: 'fa-solid fa-address-book',
          iconSrc: "/icons/job-gray.svg",
          iconSrcActive: "/icons/job-white.svg",
          link: "/mentor",
          isToggleSubItem: true,
          subMenu: [
            {
              title: "Contact subject",
              icon: "fa-solid fa-circle",
              link: "/contact-subject",
            },
          ],
          isShowTitle: false,
          count: 0,
        },
        {
          title: "Mentees",
          // icon: 'fa-solid fa-address-book',
          iconSrc: "/icons/job-gray.svg",
          iconSrcActive: "/icons/job-white.svg",
          link: "/mentee",
          isToggleSubItem: true,
          subMenu: [
            {
              title: "Contact subject",
              icon: "fa-solid fa-circle",
              link: "/contact-subject",
            },
          ],
          isShowTitle: false,
          count: 0,
        },
        {
          title: "Blogs",
          // icon: 'fa-solid fa-table-list',
          iconSrc: "/icons/news-gray.svg",
          iconSrcActive: "/icons/news-white.svg",
          link: "/news",
          isToggleSubItem: true,
          subMenu: [
            {
              title: "News category",
              icon: "fa-solid fa-circle",
              link: "/news-category",
            },
          ],
          isShowTitle: false,
        },
        {
          title: "Appointment",
          // icon: 'fa-solid fa-shield',
          iconSrc: "/icons/product-gray.svg",
          iconSrcActive: "/icons/product-white.svg",
          link: "/product",
          isShowTitle: false,
        },
        {
          title: "Activity",
          // icon: 'fa-solid fa-users',
          iconSrc: "/icons/activity-gray.svg",
          iconSrcActive: "/icons/activity-white.svg",
          link: "/activity",
          isShowTitle: false,
        },
        {
          title: "Statistic",
          // icon: 'fa-solid fa-gear',
          iconSrc: "/icons/recruitment-gray.svg",
          iconSrcActive: "/icons/recruitment-white.svg",
          link: "/recruitment",
          isToggleSubItem: true,
          subMenu: [
            {
              title: "Position",
              icon: "fa-solid fa-circle",
              link: "/recruitment-position",
            },
          ],
          isShowTitle: false,
          count: 0,
        },
        {
          title: "Service",
          // icon: 'fa-solid fa-envelope',
          iconSrc: "/icons/24htime-gray.svg",
          iconSrcActive: "/icons/24htime-white.svg",
          link: "/service",
          isToggleSubItem: true,
          subMenu: [
            {
              title: "Service category",
              icon: "fa-solid fa-circle",
              link: "/service-category",
            },
          ],
          isShowTitle: false,
          count: 0,
        },
      ],
    };
  },
  mounted() {
    // Call the API and update the value of item.count in the callback
    // this.getNotification('contact')
    // this.getNotification('service')
    // this.getNotification('application')
    this.deactiveToggleSubItem();
  },
  methods: {
    getNotification(field) {
      return this.$api[field]
        .getNotificationCount()
        .then((res) => {
          return res.data.data.count;
        })
        .then((count) => {
          if (field === "application") field = "recruitment";
          this.menu.find(
            (item) => item.title.toLocaleLowerCase() === field
          ).count = count;
        });
    },
    toggleSubItem(item) {
      item.isToggleSubItem = !item.isToggleSubItem;
    },
    deactiveToggleSubItem() {
      this.menu.forEach((item) => {
        if (
          item.isToggleSubItem !== this.$route.path.includes(item.link + "-")
        ) {
          item.isToggleSubItem = false;
        }
      });
    },
  },
};
</script>
<style lang="scss" scoped>
a {
  color: $color-secondary;
}
.sidebar {
  width: 300px;
  height: calc(100vh - 80px - 24px - 40px);
  box-shadow: 0px 16px 24px rgba(71, 79, 98, 0.12);
  border-radius: 0px 8px 8px 0px;
  padding: 12px 0;
}
.sidebar-toggle {
  width: 90px !important;
}
.menu {
  &-title {
    font-size: 16px;
    font-weight: 600;
    line-height: 175%;
  }
  &-item {
    position: relative;
    height: 40px;
    transition: 0.3s ease-out;
    z-index: 13;
    &:hover {
      background: $color-gray-lighter;
      border-radius: 0px 32px 32px 0px;
    }
    .dropdown-icon {
      position: absolute;
      right: 32px;
      transition: 0.3s ease-out;
    }
    .sub-icon {
      width: 10px;
      height: 10px;
      margin-bottom: 1px;
    }
    &-icon {
      width: 20px;
    }
  }
}
.rotate-icon {
  transform: rotate(90deg);
  transition: 0.3s ease-out;
}
</style>
