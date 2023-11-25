import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    host: true
  },
  resolve: {
    alias: {
      "@": "/src"
    }
  },
  test: {
    // enable jest-like global test APIs
    globals: true,
    environment: 'happy-dom'
  }
});
