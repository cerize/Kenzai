class SprintsController < ApplicationController

  def new
    @project = Project.find params[:project_id]
    @sprint = Sprint.new
    respond_to do |format|
      format.js { render :new }
    end
  end



end
