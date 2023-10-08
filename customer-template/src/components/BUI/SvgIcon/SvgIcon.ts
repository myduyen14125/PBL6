import { defineComponent } from "vue";

export default defineComponent({
  name: "SvgIcon",
  props: {
    icon: String,
  },
  setup() {
    const types = {
      birthdayIcon: "birthdayIcon",
      briefcaseIcon: "briefcaseIcon",
      calendar: "calendar",
      calendarMenu: "calendarMenu",
      calendarFull: "calendarFull",
      changePassIcon: "changePassIcon",
      closeMenu: "closeMenu",
      facebook: "facebook",
      heartIcon: "heartIcon",
      helpIcon: "helpIcon",
      locationIcon: "locationIcon",
      logoutIcon: "logoutIcon",
      messenger: "messenger",
      messengerMenu: "messengerMenu",
      searchIcon: "searchIcon",
      userInfoIcon: "userInfoIcon",
      toggleMenu: "toggleMenu",
      youtube: "youtube",
    };

    return {
      types,
    };
  },
});
