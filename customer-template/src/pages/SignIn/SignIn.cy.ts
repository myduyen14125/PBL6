import SignIn from './SignIn.vue'

describe('<SignIn />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(SignIn);
    // fill in the input email  = abcd and password = 1234
    cy.get('input[name="email"]').type("myduyen14125+1@gmail.com");
    cy.wait(300);
    cy.get('input[name="password"]').type("123456");
    cy.wait(500);
    cy.get('button[type="submit"]').click();
    // wait to check get api success or not, then cy.url() to /Home
    cy.wait(1000);
    cy.url().should("include", "/home");
  })
})