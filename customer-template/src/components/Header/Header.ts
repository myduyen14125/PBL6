import { defineComponent } from "vue";
import logo from "../../assets/image/logo.png";

export default defineComponent({
  name: "Header",
  setup() {
    const navLinks = [
      {
        path: "/",
        name: "TRANG CHỦ",
      },
      {
        path: "/mentors",
        name: "TÌM KIẾM MENTOR",
      },
    ];
    return { logo, navLinks };
  },
});
