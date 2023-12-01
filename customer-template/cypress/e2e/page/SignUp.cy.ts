var baseUrl = "http://localhost:5173";

const testCasesSignUp = [
  // Sai định dạng email, test case 17 -> 28
  {
    email: "myduyen14125",
    name: "My Duyen Mentee",
    password: "1234A@",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Email không hợp lệ",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Mật khẩu phải có ít nhất 6 ký tự",
  },

  // Password > 20 kí tự
  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "1111111111111111111111",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Mật khẩu đạt tối đa 20 ký tự",
  },

  // Password không có chữ hoa và kí tự đặc biệt
  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "123456",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Mật khẩu không có chữ hoa và kí tự đặc biệt",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345a@",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Mật khẩu không có chữ in hoa",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345aa",
    gender: true,
    date_of_birth: "1999-01-01",
    role: "mentee",
    message: "Mật khẩu không có kí tự đặc biệt",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345A@",
    gender: true,
    date_of_birth: "12-05-2024",
    role: "mentee",
    message: "Ngày sinh lớn hơn ngày hiện tại",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345A@",
    gender: true,
    date_of_birth: "40-5-2023",
    role: "mentee",
    message: "Ngày sinh không hợp lệ",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345A@",
    gender: true,
    date_of_birth: "31-2-2023",
    role: "mentee",
    message: "Ngày sinh không hợp lệ",
  },

  {
    email: "myduyen14125+3@gmail.com",
    name: "My Duyen Mentee",
    password: "12345A@",
    gender: true,
    date_of_birth: "05-12-2022",
    role: "mentee",
    message: "Đăng ký thành công",
  },
];

// Case not input
describe("SignUp Tests", () => {
  it(`Test Case Not Input`, () => {
    cy.visit(baseUrl + "/sign-up");
    cy.get('input[name="email"]').focus().blur();
    cy.wait(1000);
    cy.get('input[name="name"]').focus().blur();
    cy.wait(1000);
    cy.get('input[name="password"]').focus().blur();
    cy.wait(1000);
    cy.get('button[type="submit"]').click();
    cy.wait(5000);
  });
});

let testEmail = ['myduyen14125', 'myduyen14125+3@gmail.com'];
let testPassword = ['1', '123', '111111111111111111111', '123456', '1234Aa', '12345a@', '1234A@'];
let testDateOfBirth = ['12-05-2024', '40-5-2023', '31-2-2023', '05-12-2022'];
let testSucess = [{
  email: "myduyen14125+30@gmail.com",
  name: "My Duyen Mentee",
  password: "1234A@",
  gender: true,
  date_of_birth: "12-05-2002",
  role: "mentee",
  message: "Đăng ký thành công",
}];

describe("SignUp Tests", () => {
  it(`Test form input`, () => {
    cy.visit(baseUrl + "/sign-up");
    for (let i = 0; i < testEmail.length; i++) {
      cy.get('input[name="email"]').type(testEmail[i]);
      cy.wait(1000);
      if (i < testEmail.length - 1) cy.get('input[name="email"]').clear();
    }
    cy.get('input[name="name"]').type("My Duyen Test");
    cy.wait(1000);
    cy.get("#eye-icon").click();
    cy.wait(1000);
    for (let i = 0; i < testPassword.length; i++) {
      cy.get('input[name="password"]').type(testPassword[i]);
      cy.wait(1000);
      if (i < testPassword.length - 1) cy.get('input[name="password"]').clear();
    }
    cy.get("#select-gender-signup").click();
    cy.wait(1000);
    cy.get("#select-gender-signup-female").click();
    cy.wait(1000);
    cy.get("#date-picker-signup").click();
    for (let i = 0; i < testDateOfBirth.length; i++) {
      cy.get("#date-picker-signup").type(testDateOfBirth[i]);
      cy.wait(1000);
      cy.get("#date-picker-signup").blur();
      cy.wait(1000);
      if (i < testDateOfBirth.length - 1) cy.get("#date-picker-signup").clear();
    }
    cy.get('#select-role-signup').click();
    cy.get("#select-role-signup-mentee").click();
    cy.wait(1000);
    cy.get('button[type="submit"]').click();
    cy.wait(5000);
    if (cy.get(".swal2-confirm")) {
      cy.get(".swal2-confirm").click();
      cy.wait(2000);
    }
  });
});

describe("SignUp Tests", () => {
  testSucess.forEach((testCase, index) => {
    it(`${index + 10} : ${testCase.message}`, () => {
      cy.visit(baseUrl + "/sign-up");
      cy.get('input[name="email"]').type(testCase.email);
      cy.wait(1000);
      cy.get('input[name="name"]').type(testCase.name);
      cy.wait(1000);
      cy.get('#eye-icon').click();
      cy.wait(1000);
      cy.get('input[name="password"]').type(testCase.password);
      cy.wait(1000);
      cy.get('#select-gender-signup').click();
      cy.wait(1000);
      if (testCase.gender) {
        cy.get('#select-gender-signup-female').click();
      }
      else {
        cy.get('#select-gender-signup-male').click();
      }
      cy.wait(1000);
      // select date of birth
      cy.get('#date-picker-signup').click();
      cy.get('#date-picker-signup').type(testCase.date_of_birth);
      cy.wait(1000);

      cy.get('#select-role-signup').click();
      cy.wait(1000);
      if (testCase.role == "mentee") {
        cy.get('#select-role-signup-mentee').click();
      }
      else {
        cy.get('#select-role-signup-mentor').click();
      }
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
