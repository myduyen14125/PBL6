import Index from './index.vue'

describe('<Index />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(Index)
  })
})