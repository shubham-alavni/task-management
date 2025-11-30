require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(first_name: "Test", last_name: "User", email: "test@example.com", password: "password")
  end

  test "should get new" do
    get login_url
    assert_response :success
    assert_select "form[action=?]", login_path
  end

  test "should login with valid credentials" do
    post login_url, params: { email: @user.email, password: "password" }
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "Logged in successfully.", response.body
    assert_equal @user.id, session[:user_id]
  end

  test "should not login with invalid credentials" do
    post login_url, params: { email: @user.email, password: "wrongpass" }
    assert_response :unprocessable_entity
    assert_select "form[action=?]", login_path
    assert_match "Invalid email or password.", response.body
    assert_nil session[:user_id]
  end

  test "should logout" do
    post login_url, params: { email: @user.email, password: "password" }
    delete logout_url
    assert_redirected_to login_path
    follow_redirect!
    assert_match "Logged out.", response.body
    assert_nil session[:user_id]
  end
end
