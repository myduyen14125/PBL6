import { createApp } from "vue";
import { createPinia } from "pinia";
import router from "./router";
import App from "./App.vue";

import SvgIcon from "./components/BUI/SvgIcon/SvgIcon.vue";
import "./assets/css/button.css";
import "./assets/css/form.css";
import "./assets/index.css";
import "./assets/main.css";
import "./style.css";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/css/bootstrap.min.css";

const app = createApp(App);

app.component("SvgIcon", SvgIcon);

app.use(createPinia());
app.use(router);

app.mount("#app");
