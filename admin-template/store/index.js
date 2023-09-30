import Vuex from 'vuex'
import subjectModule from './contact-subject'
import newsCategoryModule from './news-category'
import positionModule from './position'
import serviceCategoryModule from './service-category'

const createStore = () => {
  return new Vuex.Store({
    state: {},
    mutations: {},
    actions: {},
    getters: {},
    modules: {
      subject: subjectModule,
      newsCategory: newsCategoryModule, // News category
      position: positionModule, // Job position
      serviceCategory: serviceCategoryModule // Service category
    }
  })
}

export default createStore