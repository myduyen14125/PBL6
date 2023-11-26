import { defineConfig } from "cypress";

export default defineConfig({
  viewportHeight: 720,
  viewportWidth: 1280,
  scrollBehavior: false,
  e2e: {
    setupNodeEvents(on, config) {
      baseUrl: "http://localhost:5173";
      // implement node event listeners here
    },
  },
});
