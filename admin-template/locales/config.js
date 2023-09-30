export default {
  locales: [
    {
      code: 'ja',
      iso: 'ja-JP',
      name: 'Japanese',
      file: 'ja.json'
    },
    {
      code: 'vi',
      iso: 'vi-VN',
      name: 'Vietnamese',
      file: 'vi.json'
    },
    {
      code: 'en',
      iso: 'en-EN',
      name: 'English',
      file: 'en.json'
    }
  ],
  defaultLocale: 'en',
  detectBrowserLanguage: {
    useCookie: true,
    cookieKey: 'my_custom_cookie_name',
    alwaysRedirect: true,
    onlyOnRoot: true
    // useCookie: false,
    // cookieCrossOrigin: true,
    // cookieKey: 'my_custom_cookie_name'
  },
  baseUrl: '',
  seo: true,
  lazy: true,
  parsePages: false,
  vueI18n: {
    fallbackLocale: ['en', 'vi', 'ja']
  },
  langDir: 'locales/',
  encodePaths: false,
  // strategy: 'no_prefix',
}
