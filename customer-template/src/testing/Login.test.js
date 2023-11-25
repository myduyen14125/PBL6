import { render, fireEvent } from '@testing-library/vue';
import SignIn from '@/pages/SignIn/SignIn.vue';

// Mock router-link to avoid errors
jest.mock('vue-router', () => ({
  RouterLink: {
    render: () => {},
  },
}));

test('it should log in with valid credentials', async () => {
  const { getByLabelText, getByText } = render(SignIn);

  // Fill in the email and password fields
  await fireEvent.update(getByLabelText('Email'), 'abcd');
  await fireEvent.update(getByLabelText('Mật khẩu'), '123456');

  // Click the submit button
  await fireEvent.click(getByText('Đăng nhập'));

  // You may need to wait for an asynchronous operation to complete (e.g., API request)
  // For simplicity, you can use a setTimeout or async/await with Jest's fake timers

  // Assuming your login logic sets some kind of flag or state when successful
  // Here, we are checking if the success message is displayed (modify as needed)
  expect(getByText('Đăng nhập thành công')).toBeInTheDocument();
});

// You can add more tests for invalid credentials, form validation, etc.
