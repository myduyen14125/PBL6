/* eslint-disable no-var */
const handleLazyLoad = (classBefore, classAfter, rootMargin) => {
  var observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // entry.target.classList.remove(classBefore);
        entry.target.classList.add(classAfter);
      }
      else {
        // entry.target.classList.remove(classAfter);
      }
    });
  // eslint-disable-next-line object-shorthand
  }, { rootMargin: rootMargin });

  const hiddenElements = document.querySelectorAll("." + classBefore);
  hiddenElements.forEach((el) => observer.observe(el));
}

const handleAllLazyLoad = () => {
  handleLazyLoad("hiddenBottom", "showTop", "0px 0px -100px 0px");
  handleLazyLoad("hiddenRight", "showLeft", "0px 0px -100px 0px");
  handleLazyLoad("hiddenLeft", "showRight", "0px 0px -100px 0px");
}

export default ({ app }, inject) => {
  // Inject $hello(msg) in Vue, context and store.
  inject('handleLazyLoad', handleLazyLoad);
  inject('handleAllLazyLoad', handleAllLazyLoad);
}