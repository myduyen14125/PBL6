describe("template spec", () => {
  var baseUrl = "http://localhost:5173";

  beforeEach(() => {
    cy.visit(baseUrl + "/sign-in");
    cy.get('input[name="email"]').type("tranngadn02+00@gmail.com");
    cy.wait(1000);
    cy.get('input[name="password"]').type("123456");
    cy.wait(1000);
    cy.get('button[type="submit"]').click();
    cy.wait(2000);

    cy.get(".header-menu").click();
    cy.wait(1000);
    cy.get('[data-test-id="user-info-link"]').click();

    cy.wait(1000);
  });

  it("Thêm kinh nghiệm làm việc thành công", () => {
    const dateValue = ["28/11/2020", "28/11/2023"];

    cy.get('[data-test-id="add-experience"]').click();
    cy.get(".experience_modal.show").should("be.visible");

    cy.get('.experience_modal.show [data-test-id="input-company"]').type(
      "Công ty trách nhiệm hữu hạn một thành viên Trần Thị Ngà"
    );
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-position"]').type(
      "Tổng giám đốc"
    );
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-description"]').type(
      "Tổng giám đốc công ty trách nhiệm hữu hạn một thành viên Trần Thị Ngà"
    );
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type(dateValue[0]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type(dateValue[1]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-date-editor").click();
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
  });

  it("Không điền đầy đủ field trước khi submit", () => {
    const dateValue = ["28/11/2020", "28/11/2023"];

    // Không điền tất cả các field
    cy.get('[data-test-id="add-experience"]').click();
    cy.get(".experience_modal.show").should("be.visible");
    cy.wait(1000);

    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
    // Chỉ điền tên công ty
    cy.get('.experience_modal.show [data-test-id="input-company"]').type(
      "Công ty ABC"
    );
    cy.wait(1000);

    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
    // Chỉ điền tên công ty, vị trí
    cy.get('.experience_modal.show [data-test-id="input-position"]').type(
      "Nhân viên"
    );
    cy.wait(1000);

    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
    // Chỉ điền tên công ty, vị trí, mô tả
    cy.get('.experience_modal.show [data-test-id="input-description"]').type(
      "Nhân viên công ty ABC"
    );
    cy.wait(1000);

    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
    // Không điền ngày bắt đầu
    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type(dateValue[0]);
    cy.wait(1000);
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    // Không điền ngày kết thúc
    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type(dateValue[1]);
    cy.wait(1000);
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    // điền đầy đủ
    cy.wait(1000);
    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type(dateValue[0]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type(dateValue[1]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-date-editor").click();
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
  });

  it("Điền sai dạng field", () => {
    const dateValue = ["28/11/2020", "28/11/2023"];

    cy.get('[data-test-id="add-experience"]').click();
    cy.get(".experience_modal.show").should("be.visible");

    cy.get('.experience_modal.show [data-test-id="input-company"]').type(
      "Công ty 3"
    );
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-position"]').type(
      "Quản lý"
    );
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-description"]').type(
      "Quản lý công ty 3"
    );
    cy.wait(1000);

    // TH1: điền chữ
    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type("ngaythangnam");
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type("ngay/thang/nam");
    cy.wait(1000);

    // điền sai định dạng: MM-DD-YYYY
    cy.get(".experience_modal.show .el-date-editor").click();
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type("06-22-2032");
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type("06-22-2032");
    cy.wait(1000);

    cy.get(".experience_modal.show .el-date-editor").click();
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
  });

  // it("Điền ngày quá hôm nay", () => {
  //   const dateValue1 = ["01/11/2023", "30/11/2023"];
  //   const dateValue2 = ["29/11/2023", "30/11/2023"];
  //   const dateValue3 = ["30/11/2023", "06/12/2023"];

  //   cy.get('[data-test-id="add-experience"]').click();
  //   cy.get(".experience_modal.show").should("be.visible");

  //   cy.get('.experience_modal.show [data-test-id="input-company"]').type(
  //     "Công ty 3"
  //   );
  //   cy.get('.experience_modal.show [data-test-id="input-position"]').type(
  //     "Quản lý"
  //   );
  //   cy.get('.experience_modal.show [data-test-id="input-description"]').type(
  //     "Quản lý công ty 3"
  //   );

  //   // TH1: 1/11/2023 - 30/11/2023
  //   cy.get(".experience_modal.show .el-date-editor").click();
  //   cy.get(
  //     '.experience_modal.show [data-test-id="experience-submit-btn"]'
  //   ).click();

  //   cy.get(".experience_modal.show .el-range-input")
  //     .eq(0)
  //     .clear()
  //     .type(dateValue1[0]);

  //   cy.get(".experience_modal.show .el-range-input")
  //     .eq(1)
  //     .clear()
  //     .type(dateValue1[1]);
  //   cy.wait(1000);

  //   cy.get(".experience_modal.show .el-date-editor").click();
  //   cy.get(
  //     '.experience_modal.show [data-test-id="experience-submit-btn"]'
  //   ).click();

  //   cy.wait(1000);
  // });

  it("Chỉnh sửa kinh nghiệm làm việc đầu tiên thành công", () => {
    const dateValue = ["28/11/2020", "28/11/2023"];

    cy.get('.experience-section [data-test-id="edit-experience"]')
      .eq(0)
      .then(($element) => {
        cy.wrap($element).trigger("mouseenter", {
          scrollBehavior: "center",
          timeout: 2000,
        });

        cy.wait(2000);

        cy.wrap($element).click();
        cy.wrap($element).trigger("mouseleave", {
          force: true,
        });
      });

    cy.get(".experience_modal.show").should("be.visible");

    cy.get('.experience_modal.show [data-test-id="input-company"]')
      .clear()
      .type("Công ty trách nhiệm hữu hạn Trần Thị Ngà");
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-position"]')
      .clear()
      .type("Phó tổng giám đốc");
    cy.wait(1000);

    cy.get('.experience_modal.show [data-test-id="input-description"]')
      .clear()
      .type(
        "Phó tổng giám đốc công ty trách nhiệm hữu hạn một thành viên Trần Thị Ngà"
      );
    cy.wait(1000);

    cy.get(
      ".experience_modal.show .el-date-editor .el-range__close-icon"
    ).click({ force: true });

    cy.get(".experience_modal.show .el-range-input")
      .eq(0)
      .clear()
      .type(dateValue[0]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-range-input")
      .eq(1)
      .clear()
      .type(dateValue[1]);
    cy.wait(1000);

    cy.get(".experience_modal.show .el-date-editor").click();
    cy.get(
      '.experience_modal.show [data-test-id="experience-submit-btn"]'
    ).click();

    cy.wait(1000);
  });

  it("Xóa kinh nghiệm làm việc cuối cùng thành công", () => {
    cy.get('.experience-section [data-test-id="delete-experience"]')
      .last()
      .then(($element) => {
        cy.wrap($element).trigger("mouseenter", {
          scrollBehavior: "center",
          timeout: 2000,
        });

        cy.wait(2000);

        cy.wrap($element).click();
        cy.wrap($element).trigger("mouseleave", {
          force: true,
        });
      });

    cy.get(".swal2-popup.swal2-modal.swal2-icon-warning.swal2-show").should(
      "be.visible"
    );

    cy.wait(1000);

    cy.get(".swal2-confirm.btn.btn-danger").click();
    cy.get(".experience-section").scrollIntoView();
  });
});
