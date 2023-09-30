import Vue from 'vue';
import VeeValidate, { Validator } from 'vee-validate';

// Set up localization
Validator.localize('en', {
  messages: {
    date_format: 'Please enter a valid date format: dd-mm-yyyy',
  },
});
Validator.extend('noSpaces', {
  getMessage: field => 'The ' + field + ' field may not contain spaces.',
  validate: value => {
    const regexSplitPair = /(<.*?>)([\s\S]*?)(<\/.*?>)/g;
      const tagPairs = value.match(regexSplitPair);
      for (let i = 0; i < tagPairs.length; i++) {
        const regexSpaceInside = /<.*>(\s*)<\/.*>/g;
        if (!regexSpaceInside.test(tagPairs[i])) {
          return true;
        }
      }
      return false;
  },
});

Vue.use(VeeValidate, {
  // Configuration options
  errorBagName: 'veeErrors', // change if property conflicts.
  
});

