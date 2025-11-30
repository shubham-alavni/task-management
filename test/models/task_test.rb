require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(first_name: "John", last_name: "Doe", email: "test@example.com", password: "password")
    @task = Task.new(title: "Test Task", user: @user, due_date: Date.today + 1, completed: false)
  end

  test "should be valid with valid attributes" do
    assert @task.valid?
  end

  test "should be invalid without title" do
    @task.title = nil
    assert_not @task.valid?
    assert_includes @task.errors[:title], "can't be blank"
  end

  test "should be invalid if due_date is in the past" do
    @task.due_date = Date.yesterday
    assert_not @task.valid?
    assert_includes @task.errors[:due_date], "can't be in the past"
  end

  test "should belong to user" do
    assert_equal @user, @task.user
  end

  test "completed scope returns completed tasks" do
    @task.completed = true
    @task.save!
    completed_tasks = Task.completed
    assert_includes completed_tasks, @task
  end

  test "pending scope returns pending tasks" do
    @task.completed = false
    @task.save!
    pending_tasks = Task.pending
    assert_includes pending_tasks, @task
  end
end
