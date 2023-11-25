import Mentor from './Mentor.vue'

describe('<Mentor />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(Mentor)
  })
})