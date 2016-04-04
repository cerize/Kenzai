class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :find_sprint
  before_action :find_task, only: [:edit, :update, :destroy]
  before_action :authorize_management

  def new
    @task  = Task.new
    @tasks = @sprint.tasks
    respond_to do |format|
      format.js { render :new }
    end
  end

  # will render the task tree
  def index
    @tasks = @sprint.tasks
    respond_to do |format|
      format.html { render }
      format.json { render }
    end
  end

  # def tree_data
  #   render json:
  # end

  def create
    @task   = Task.new task_params
    @task.sprint = @sprint
    respond_to do |format|
      if @task.save
        format.js { render :create_success }
      else
        format.js { render :create_fail }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @task.update task_params
        format.js   { render :update_success }
      else
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to project_sprint_path(@sprint.project, @sprint)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :task_id)
  end

  def find_task
    @task = Task.find params[:id]
  end

  def find_sprint
  @sprint = Sprint.find params[:sprint_id]
  end

  def authorize_management
    unless can? :manage, @sprint.project
      redirect_to root_path, alert: "access denied!"
    end
  end

end
