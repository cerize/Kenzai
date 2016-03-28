class UserStoriesController < ApplicationController
  before_action :authenticate_user
  before_action :find_sprint
  before_action :find_user_story, only: [:edit, :update, :destroy]
  before_action :authorize_management

  def new
    @user_story  = UserStory.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @user_story   = UserStory.new user_story_params
    @user_story.sprint = @sprint
    respond_to do |format|
      if @user_story.save
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
      if @user_story.update user_story_params
        format.js   { render :update_success }
      else
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    @user_story.destroy
    redirect_to project_sprint_path(@sprint.project, @sprint)
  end

  private

  def user_story_params
    params.require(:user_story).permit(:title, :description)
  end

  def find_user_story
    @user_story = UserStory.find params[:id]
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
