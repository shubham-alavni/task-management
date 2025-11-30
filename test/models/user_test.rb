require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "valid user" do
    assert @user.valid?
  end

  test "invalid without first_name" do
    @user.first_name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:first_name], "can't be blank"
  end

  test "invalid without last_name" do
    @user.last_name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:last_name], "can't be blank"
  end

  test "invalid without email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "invalid with duplicate email" do
    @user.save!
    user2 = @user.dup
    user2.email = @user.email
    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end

  test "has_secure_password works" do
    @user.save!
    assert @user.authenticate("password")
    assert_not @user.authenticate("wrongpassword")
  end

  test "has many tasks association" do
    @user.save!
    task = @user.tasks.create!(title: "Test Task", description: "desc")
    assert_includes @user.tasks, task
  end

  test "name method returns capitalized full name" do
    assert_equal "John Doe", @user.name
  end
end
