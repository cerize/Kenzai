class ProjectsController < ApplicationController
  before_action :authenticate_user

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
    find_project
    if @project
      render :show
    else
      redirect_to root_path
    end
  end

  # render nothing: true
  private

  def project_params
    params.require(:project).permit(:title, :description, :start_date, :end_date)
  end

  def find_project
    @project = current_user.projects.find_by_id params[:id]
  end

end
