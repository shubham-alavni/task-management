class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[edit update destroy mark_complete]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted."
  end

  # custom member action to toggle/mark complete
  def mark_complete
    @task.update(completed: params[:completed].present? ? ActiveModel::Type::Boolean.new.cast(params[:completed]) : true)
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: @task.completed ? "Task marked complete." : "Task marked incomplete." }
      # format.turbo_stream # optional if using Turbo
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end
end
