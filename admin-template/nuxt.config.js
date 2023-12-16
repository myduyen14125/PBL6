import i18nConfig from "./locales/config";

export default {
  ssr: false,
  // server: {
  //   port: 3006,
  //   host: "0.0.0.0",
  //   // https: {
  //   //   key: fs.readFileSync(path.resolve(__dirname, 'server.key')),
  //   //   cert: fs.readFileSync(path.resolve(__dirname, 'server.crt'))
  //   // }
  // },

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: "IT Mentor",
    htmlAttrs: {
      lang: "en",
    },
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { hid: "description", name: "description", content: "" },
      { name: "format-detection", content: "telephone=no" },
    ],
    link: [
      { rel: "icon", type: "image/x-icon", href: "/icon-logo.png" },
      {
        rel: "stylesheet",
        href: "https://drive.google.com/uc?export=view&id=1yTLwNiCZhIdCWolQldwq4spHQkgZDqkG",
      },
    ],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    "quill/dist/quill.snow.css",
    "@/assets/css/base.css",
    "@/assets/css/font.css",
    "@fortawesome/fontawesome-svg-core/styles.css",
    "vue-slick-carousel/dist/vue-slick-carousel.css",
    "vue-slick-carousel/dist/vue-slick-carousel-theme.css",
    "vue-select/dist/vue-select.css",
  ],
  styleResources: {
    scss: ["@/assets/scss/*.scss"],
  },

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    "~/plugins/fontawesome.js",
    "~/plugins/vue-select.js",
    { src: "~/plugins/vue-isotope", ssr: false },
    "~/plugins/api.js",
    "~/plugins/handleLazyLoad.js",
    "~/plugins/helpers.js",
    { src: "~plugins/vue-quill-editor.js", ssr: false },
    { src: "~/plugins/v-click-outside.js", mode: "client" },
    { src: "~/plugins/vee-validate.js", mode: "client" },
    { src: "~/plugins/vue-image-crop-upload.js", mode: "client" },
    { src: "~/plugins/vue-paginate.js" },
    { src: "~/plugins/eventBus.js", mode: "client" },
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    "@nuxtjs/eslint-module",
    "@nuxtjs/moment",
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/bootstrap
    "bootstrap-vue/nuxt",
    // https://go.nuxtjs.dev/axios
    "@nuxtjs/axios",
    "@nuxtjs/auth-next",
    ["nuxt-i18n", i18nConfig],
    "@nuxtjs/style-resources",
    "nuxt-leaflet",
    "@nuxtjs/dotenv",
    "@nuxtjs/toast",
  ],
  toast: {
    position: "top-right",
    duration: 2000,
  },
  router: {
    // edit router base
    // middleware: ['auth'],
    middleware: ["protect-admin"],
  },
  layout: "error",

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    baseURL: process.env.BASE_URL_API,
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    /* ** You can extend webpack config here */
    extend(config, ctx) {},
    // npx nuxt build -a //analyze: true, transpile: [ ({ isClient }) => isClient && "vee-validate/dist/rules" ],
    babel: { compact: true },
    transpile: ["defu"],
  },
  auth: {
    redirect: {
      callback: "/",
      login: "/",
      home: "/",
      logout: "/login",
    },
    strategies: {
      local: {
        scheme: "refresh",
        token: {
          property: "data.access_token",
          maxAge: "data.expires_in",
        },
        refreshToken: {
          property: "data.refresh_token",
          data: "refresh_token",
        },
        user: {
          property: "data",
          autoFetch: true,
        },
        endpoints: {
          login: { url: "/auth/login", method: "post" },
          user: { url: "/user", method: "get" },
          refresh: { url: "/admin/refresh_tokens", method: "post" },
          logout: { url: "/oauth/revoke", method: "post" },
        },
      },
    },
  },
};
