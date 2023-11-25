const baseUrl = "http://localhost:5173";

describe("template spec", () => {
  it("passes", () => {
    cy.visit(baseUrl + "/sign-in");
    cy.get('input[name="email"]').type("myduyen14125+1@gmail.com");
    cy.wait(1000);
    cy.get('input[name="password"]').type("123456");
    cy.wait(1000);
    cy.get('button[type="submit"]').click();
    // wait to check get api success or not, then cy.url() to /Home
    cy.wait(2000);
  });
});