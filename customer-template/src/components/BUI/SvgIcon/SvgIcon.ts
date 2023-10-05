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
    };

    return {
      types,
    };
  },
});
