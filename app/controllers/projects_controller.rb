class ProjectsController < ApplicationController
  before_action :authenticate_user
  before_action :find_project, only: [:show, :edit, :update, :destroy, :cancel, :complete, :map]
  before_action :authorize_management, only: [:edit, :update, :destroy, :cancel, :complete]


  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.creator = current_user
    if @project.save
      current_user.projects << @project
      schedule_background_job
      redirect_to project_path(@project), notice: "New Project Created!"
    else
      flash[:alert] = "Project could not be created."
      render :new
    end
  end

  def show
    if @project
      @sprint = Sprint.new
      @sprints = @project.sprints.order(created_at: :desc)
      render :show
    else
      redirect_to root_path, alert: "Project Not Found"
    end
  end

  def edit
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @project.update project_params
        format.js   { render :update_success }
        schedule_background_job
      else
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to my_projects_path
  end

  def complete
    @project.finish!
    @project.actual_end_date = Date.today
    @project.save
    redirect_to my_projects_path
  end

  def cancel
    @project.cancel!
    redirect_to my_projects_path
  end

  def map
    respond_to do |format|
      format.html { render }
      format.json { render }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :start_date, :end_date)
  end

  def find_project
    @project = current_user.projects.find_by_id params[:id]
  end

  def authorize_management
    unless can? :manage, @project
      redirect_to root_path, alert: "access denied!"
    end
  end

  def schedule_background_job
    DetermineProjectStateJob.perform_now(@project)
    DetermineProjectStateJob.set(wait_until: @project.start_date).perform_later(@project)
    DetermineProjectStateJob.set(wait_until: @project.end_date).perform_later(@project)
    true
  end

end
