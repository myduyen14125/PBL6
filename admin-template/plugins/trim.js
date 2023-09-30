// trim.js

export default {
  // directive definition
  directive: {
    // called when the bound element is inserted into the DOM
    mounted(el) {
      // listen for blur event on the input element
      el.addEventListener('blur', () => {
        // trim the input value
        el.value = el.value.trim()
        // update the v-model if it exists
        if (el.__vue__ && el.__vue__.$vnode.data.model) {
          el.__vue__.$vnode.data.model.callback(el.value.trim())
        }
      })
    }
  }
}
