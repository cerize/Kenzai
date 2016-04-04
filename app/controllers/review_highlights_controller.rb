class ReviewHighlightsController < ApplicationController
  before_action :authenticate_user
  before_action :find_review_highlight, only: [:destroy]
  before_action :find_sprint, only: [:index, :new, :create, :destroy]

  # before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @review_highlights = @sprint.review_highlights
    @review_highlight = ReviewHighlight.new
  end

  def new
    @review_highlight = ReviewHighlight.new
    respond_to do |format|
      format.js  { render :new}
    end
  end

  def create
    @review_highlight = ReviewHighlight.new review_highlight_params
    @review_highlight.sprint = @sprint
    if @review_highlight.save
      redirect_to sprint_review_highlights_path(@sprint), notice: "Highlight created!"
    else
      redirect_to sprint_review_highlights_path(@sprint), alert: "Error happened: Highlight could not be created."
    end
  end

  def destroy
    find_review_highlight.destroy
    redirect_to sprint_review_highlights_path(@sprint), notice: "Highlight deleted!"
  end

  private

  def review_highlight_params
    params.require(:review_highlight).permit(:description)
  end

  def find_review_highlight
    @review_highlight = ReviewHighlight.find params[:id]
  end

  def find_sprint
    @sprint = Sprint.find params[:sprint_id]
  end

  # def authorize_user
  #   unless can? :manage, @review_highlight
  #     redirect_to root_path, alert: "access denied!"
  #   end
  # end

end
