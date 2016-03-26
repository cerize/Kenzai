class SprintsController < ApplicationController

  def new
    @project = Project.find params[:project_id]
    @sprint  = Sprint.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @project        = Project.find params[:project_id]
    @sprint         = Sprint.new sprint_params
    @sprint.project = @project
    respond_to do |format|
      if @sprint.save
        format.js { render :create_success }
      else
        format.js { render :create_fail }
      end
    end
  end

  def show
    find_sprint
  end

  private

  def sprint_params
    params.require(:sprint).permit(:title, :description, :start_date, :end_date)
  end

  def find_sprint
    @sprint = Sprint.find params[:id]
  end

end
