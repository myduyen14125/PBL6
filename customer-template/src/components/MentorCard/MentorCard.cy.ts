import MentorCard from './MentorCard.vue'

describe('<MentorCard />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(MentorCard)
  })
})