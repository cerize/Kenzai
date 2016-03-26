class UserStoriesController < ApplicationController

  def new
    @sprint      = Sprint.find params[:sprint_id]
    @user_story  = UserStory.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @sprint       = Sprint.find params[:sprint_id]
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

  private

  def user_story_params
    params.require(:user_story).permit(:title, :description)
  end

end
