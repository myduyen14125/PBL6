var baseUrl = "http://localhost:5173";

const testCasesSignIn = [
  // Sai định dạng email, test case 17 -> 28
  { email: "myduyen14125", password: "1234A@", message: "Email không hợp lệ" },

  // Case 5 -> 16
  // Password < 6 kí tự
  { email: "myduyen14125+1@gmail.com", password: '12', message: "Mật khẩu phải có ít nhất 6 ký tự" },

  // Password > 20 kí tự
  { email: "myduyen14125+1@gmail.com", password: "1111111111111111111111", message: "Mật khẩu phải có tối đa 20 ký tự" },

  // Password không có chữ hoa và kí tự đặc biệt 
  { email: "myduyen14125+1@gmail.com", password: "123456", message: "Mật khẩu không có chữ hoa và kí tự đặc biệt" },

  // Password không có chữ hoa
  { email: "myduyen14125+1@gmail.com", password: "12345a@", message: "Mật khẩu không có chữ in hoa" },

  // Password không có kí tự đặc biệt
  { email: "myduyen1412+1@gmail.com", password: "1234Aa", message: "Mật khẩu không có kí tự đặc biệt" },
];

const testCasesSignInSubmit = [
  // Case sai email . mật khẩu
  { email: "myduyen14125+1@gmail.com", password: "1234A@@", message: "Email/ mật khẩu sai" },

  // Case đúng email, mật khẩu
  { email: "myduyen14125+1@gmail.com", password: "1234A@", message: "Đúng mail mật khẩu, mentee" },

  // Case đúng email, mật khẩu
  { email: "myduyen14125+mentor@gmail.com", password: "1234A@", message: "Đúng mail mật khẩu, mentor" },
]

// Case 1,2,3
describe("Login Tests", () => {
  it(`Test Case Not Input`, () => {
    cy.visit(baseUrl + "/sign-in");
    cy.get('input[name="email"]').focus().blur();
    cy.wait(2000);
    cy.get('input[name="password"]').focus().blur();
    cy.wait(2000);
    cy.get('button[type="submit"]').click();
  });
});

describe("Login Tests", () => {
  testCasesSignIn.forEach((testCase, index) => {
    it(`${index + 4} : ${testCase.message}`, () => {
      cy.visit(baseUrl + "/sign-in");
      cy.get('input[name="email"]').type(testCase.email);
      cy.wait(1000);
      cy.get('#eye-icon').click();
      cy.wait(1000);
      cy.get('input[name="password"]').type(testCase.password);
      cy.wait(3000);
      // Add assertions or further validation as needed
    });
  });
});

describe("Login Tests", () => {
  testCasesSignInSubmit.forEach((testCase, index) => {
    it(`${index + 10} : ${testCase.message}`, () => {
      cy.visit(baseUrl + "/sign-in");
      cy.get('input[name="email"]').type(testCase.email);
      cy.wait(1000);
      cy.get('#eye-icon').click();
      cy.wait(1000);
      cy.get('input[name="password"]').type(testCase.password);
      cy.wait(1000);
      cy.get('button[type="submit"]').click();
      cy.wait(5000);
      if (index != 0) {
        cy.get('.swal2-confirm').click();
        cy.wait(1000);
        cy.get('#dropdownMenuButton1').click();
        cy.wait(2000);
      }
    });
  });
});
