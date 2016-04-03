class SprintsController < ApplicationController
  before_action :authenticate_user
  before_action :find_project, only: [:new, :create, :edit]
  before_action :find_sprint, only: [:show, :edit, :update, :destroy]
  before_action :authorize_management, only: [:edit, :update, :destroy]

  def new
    @sprint  = Sprint.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @sprint         = Sprint.new sprint_params
    @sprint.project = @project
    respond_to do |format|
      if @sprint.save
        format.js { render :create_success }
        schedule_background_job
      else
        format.js { render :create_fail }
      end
    end
  end

  def show
    @comment = Comment.new
    @comments = @sprint.comments
  end

  def edit
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @sprint.update sprint_params
        format.js   { render :update_success }
        schedule_background_job
      else
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    @sprint.destroy
    redirect_to project_path(@sprint.project)
  end

  private

  def sprint_params
    params.require(:sprint).permit(:title, :description, :start_date, :end_date)
  end

  def find_sprint
    @sprint = Sprint.find params[:id]
  end

  def find_project
    @project = Project.find params[:project_id]
  end

  def authorize_management
    unless can? :manage, @sprint.project
      redirect_to root_path, alert: "access denied!"
    end
  end

  def schedule_background_job
    DetermineSprintStateJob.perform_now(@sprint)
    DetermineSprintStateJob.set(wait_until: @sprint.start_date).perform_later(@sprint)
    DetermineSprintStateJob.set(wait_until: @sprint.end_date).perform_later(@sprint)
    true
  end

end
