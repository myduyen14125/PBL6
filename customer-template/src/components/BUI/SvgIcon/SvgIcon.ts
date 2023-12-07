import { defineComponent } from "vue";

export default defineComponent({
  name: "SvgIcon",
  props: {
    icon: String,
    class: {
      type: String,
      default: "",
    },
  },
  setup() {
    const types = {
      birthdayIcon: "birthdayIcon",
      briefcaseIcon: "briefcaseIcon",
      calendar: "calendar",
      calendarMenu: "calendarMenu",
      calendarIcon: "calendarIcon",
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
      edit: "edit",
      delete: "delete",
      closeModal: "closeModal",
      handIcon: "handIcon",
      blogIcon: "blogIcon",
      bookIcon: "bookIcon",
      cameraIcon: "cameraIcon",
      greenTriangle: "greenTriangle",
      bgDots: "bgDots",
      bgBlur: "bgBlur",
      eye: "eye",
      eyeSlash: "eyeSlash",
    };

    return {
      types,
    };
  },
});
