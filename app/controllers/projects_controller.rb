class ProjectsController < ApplicationController
  before_action :authenticate_user
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_management, only: [:edit, :update, :destroy]


  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.creator = current_user
    if @project.save
      current_user.projects << @project
      redirect_to project_path(@project), notice: "New Project Created!"
    else
      flash[:alert] = "Project could not be created."
      render :new
    end
  end

  def show
    if @project
      @sprint = Sprint.new
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
      else
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to my_projects_path
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
  
end
