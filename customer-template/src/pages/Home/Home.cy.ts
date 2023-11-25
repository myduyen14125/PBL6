import Home from './Home.vue'

describe('<Home />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(Home)
  })
})