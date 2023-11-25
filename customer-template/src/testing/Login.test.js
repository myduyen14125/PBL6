import { render, fireEvent } from "@testing-library/vue";
import MentorCard from "@/components/MentorCard/MentorCard.vue";

{
  /* <a
            class="d-block text-center color-primary text-decoration-none border-top pt-3"
            href="#"
            >Xem chi tiết</a
          > */
}
test("renders correctly", () => {
  const { getByText } = render(MentorCard);

  let btnSeeDetail = getByText("Xem chi tiết");
  fireEvent.click(btnSeeDetail);
});
