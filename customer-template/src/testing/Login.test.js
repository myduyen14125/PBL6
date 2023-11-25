import { render, fireEvent } from "@testing-library/vue";
import MentorCard from "@/components/MentorCard/MentorCard.vue";

test("renders correctly", () => {
  const { getByText } = render(MentorCard);

  let btnSeeDetail = getByText("Xem chi tiết");
  fireEvent.click(btnSeeDetail);
});
