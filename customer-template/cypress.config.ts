import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      baseUrl: "http://localhost:5173";
      // implement node event listeners here
    },
  },
});
