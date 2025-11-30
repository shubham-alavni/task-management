
require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(first_name: "Test", last_name: "User", email: "test@example.com", password: "password")
    @task = @user.tasks.create!(title: "Sample Task", description: "Test desc", due_date: Date.tomorrow, completed: false)
    # Simulate login
    post login_url, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get tasks_url
    assert_response :success
    assert_select "h1", /Tasks/
  end

  test "should get new" do
    get new_task_url
    assert_response :success
    assert_select "form"
  end

  test "should create task with valid params" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { title: "New Task", description: "Desc", due_date: Date.today } }
    end
    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "Task created.", response.body
  end

  test "should not create task with invalid params" do
    assert_no_difference("Task.count") do
      post tasks_url, params: { task: { title: "", description: "Desc" } }
    end
    assert_response :unprocessable_entity
    assert_select "form"
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
    assert_select "form"
  end

  test "should update task with valid params" do
    patch task_url(@task), params: { task: { title: "Updated Task" } }
    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "Task updated.", response.body
    @task.reload
    assert_equal "Updated Task", @task.title
  end

  test "should not update task with invalid params" do
    patch task_url(@task), params: { task: { title: "" } }
    assert_response :unprocessable_entity
    assert_select "form"
    @task.reload
    assert_equal "Sample Task", @task.title
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end
    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "Task deleted.", response.body
  end

  test "should mark task complete" do
    patch mark_complete_task_url(@task), params: { completed: true }
    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "Task marked complete.", response.body
    @task.reload
    assert @task.completed
  end

  test "should mark task incomplete" do
    @task.update!(completed: true)
    patch mark_complete_task_url(@task), params: { completed: false }
    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "Task marked incomplete.", response.body
    @task.reload
    assert_not @task.completed
  end
end
