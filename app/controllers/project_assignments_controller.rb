class ProjectAssignmentsController < ApplicationController
  def new
    @project = Project.find_by_id params[:project_id]
    respond_to  do |format|
      format.js { render :new }
    end
  end

  def search_member
    @project = Project.find_by_id params[:project_id]
    @user = User.search_by_email(params[:q]).first
    respond_to  do |format|
      format.js { render :search_result }
    end
  end

  def create
    @project = Project.find_by_id params[:project_id]
    @user = User.find_by_id params[:user_id]
    @project_assignment = ProjectAssignment.new(project: @project, user: @user)
    @project_assignment.save
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find_by_id params[:project_id]
    @user = User.find_by_id params[:user_id]
    @project_assignment = ProjectAssignment.find_record(@user, @project)
    @project_assignment.destroy
    redirect_to project_path(@project)
  end

end
