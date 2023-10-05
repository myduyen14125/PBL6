import { defineComponent } from "vue";
import Header from "../../components/Header/Header.vue";
import Footer from "../../components/Footer/Footer.vue";
import { RouterView } from "vue-router";

export default defineComponent({
  name: "GuestLayout",
  components: {
    Header,
    RouterView,
    Footer,
  },
  setup() {
    return {};
  },
});
