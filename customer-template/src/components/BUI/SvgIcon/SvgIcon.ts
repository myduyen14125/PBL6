import { defineComponent } from "vue";

export default defineComponent({
  name: "SvgIcon",
  props: {
    icon: String,
  },
  setup() {
    const types = {
      calendar: "calendar",
      toggleMenu: "toggleMenu",
      closeMenu: "closeMenu",
      facebook: "facebook",
      youtube: "youtube",
      messenger: "messenger",
      heartIcon: "heartIcon",
      birthdayIcon: "birthdayIcon",
      calendarMenu: "calendarMenu",
      messengerMenu: "messengerMenu",
      locationIcon: "locationIcon",
      briefcaseIcon: "briefcaseIcon",
      searchIcon: "searchIcon",
    };

    return {
      types,
    };
  },
});
