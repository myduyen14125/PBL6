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
      cameraIcon: "cameraIcon",
      greenTriangle: "greenTriangle",
    };

    return {
      types,
    };
  },
});
