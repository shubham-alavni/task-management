require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_url
    assert_response :success
    assert_select "form[action=?]", signup_path
  end

  test "should create user with valid params" do
    assert_difference("User.count", 1) do
      post signup_url, params: {
        user: {
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "Welcome, John Doe!", response.body
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post signup_url, params: {
        user: {
          first_name: "",
          last_name: "",
          email: "",
          password: "",
          password_confirmation: ""
        }
      }
    end
    assert_response :unprocessable_entity
    assert_select "form[action=?]", signup_path
  end

  test "should redirect if already logged in" do
    user = User.create!(first_name: "Jane", last_name: "Smith", email: "jane.smith@example.com", password: "password", password_confirmation: "password")
    post login_url, params: { email: user.email, password: "password" }
    get signup_url
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "You are already logged in.", response.body
  end
end
