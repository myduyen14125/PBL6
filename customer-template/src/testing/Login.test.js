import { render, fireEvent } from '@testing-library/vue';
import MentorCard from '@/components/MentorCard/MentorCard.vue';

test('renders correctly and handles click event', async () => {
  const { getByText, getByTestId } = render(MentorCard);

  // Ensure that the component renders correctly
//   <div
//   id="mentor-card"
//   :class="{
//     'mentor-card tooltip-container': hover,
//     'mentor-card': !hover,
//   }"
  
//   ref="tooltipContainer"
//   @click="() => router.push(`/user/${mentor._id}`)"
// >
  // const card is get that div with id = mentor-card
  const card = getByTestId('mentor-card');  
  // console.log(card);

  // Simulate a click event on the card
  await fireEvent.click(card);

  // Check if the click event is handled correctly
  // You may need to adjust this based on your actual logic
  // For example, check if the router push is called with the correct path
  // Here, we are just checking if the click event was triggered
  expect(card).toHaveProperty('clicked', true);
});



  // get form element, email input, password input, submit button
  // const form = getByText('form');
  // // console.log if has form
  // console.log(form);

  // const emailInput = getByText('input[name="email"]');
  // const passwordInput = getByText('input[name="password"]');
  // const submitButton = getByText('button[type="submit"]');
  // // check if form is rendered
  // expect(form).toBeInTheDocument();
  // // check if email input is rendered
  // expect(emailInput).toBeInTheDocument();
  // // check if password input is rendered
  // expect(passwordInput).toBeInTheDocument();
  // // check if submit button is rendered
  // expect(submitButton).toBeInTheDocument();
  // // fill in email input abc@gmail.com
  // fireEvent.input(emailInput, { target: { value: 'myduyen14125+1@gmail.com' } });
  // // fill in password input 123456
  // fireEvent.input(passwordInput, { target: { value: '123456' } });
  // // click submit button
  // fireEvent.click(submitButton);
  // // check if email input is rendered
  