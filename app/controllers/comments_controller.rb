class CommentsController < ApplicationController

  before_action :authenticate_user
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :find_sprint, only: [:create, :edit, :update, :destroy]

  # before_action :authorize_user, only: [:edit, :update, :destroy]



  def create
    @comment = Comment.new comment_params
    @comment.sprint = @sprint
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js { render :create_success }
      else
        format.js   { render :create_fail }
      end

    end
  end

  def edit
    respond_to do |format|
      format.html { render :edit }
      format.js { render }
    end
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html { redirect_to sprint_path(@sprint) }
        format.js   { render :update_success }
      else
        #flash[:notice] = "Changes were not saved"
        format.html { render :edit }
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    find_comment.destroy
    respond_to do |format|
      format.html { redirect_to sprint_path(@sprint) }
      format.js   { render }

    end
  end

private

def comment_params
  params.require(:comment).permit(:description)
end

def find_comment
  @comment = Comment.find params[:id]
end

def find_sprint
  @sprint = Sprint.find params[:sprint_id]
end

# def authorize_user
#   unless can? :manage, @comment
#     redirect_to root_path, alert: "access denied!"
#   end
# end







end
