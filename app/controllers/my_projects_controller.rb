class MyProjectsController < ApplicationController
  before_action :authenticate_user

  def index
   @projects = current_user.projects.order(created_at: :desc)
  end

end
