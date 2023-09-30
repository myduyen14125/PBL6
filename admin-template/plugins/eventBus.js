import Vue from 'vue';

// Create a new Vue instance to use as an event bus
const eventBus = new Vue();

// Export the event bus as a plugin
export default ({ app }, inject) => {
  inject('eventBus', eventBus);
};
