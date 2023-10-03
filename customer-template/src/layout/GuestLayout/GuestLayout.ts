import { defineComponent } from "vue";
import Header from "../../components/Header/Header.vue";
import { RouterView } from "vue-router";

export default defineComponent({
  name: "GuestLayout",
  components: {
    Header,
    RouterView,
  },
  setup() {
    return {};
  },
});
