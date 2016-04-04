class PlanningHighlightsController < ApplicationController
  before_action :authenticate_user
  before_action :find_planning_highlight, only: [:destroy]
  before_action :find_sprint, only: [:index, :new, :create, :destroy]

  # before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @planning_highlights = @sprint.planning_highlights
    @planning_highlight = PlanningHighlight.new
  end

  def new
    @planning_highlight = PlanningHighlight.new
    respond_to do |format|
      format.js  { render :new}
    end
  end

  def create
    @planning_highlight = PlanningHighlight.new planning_highlight_params
    @planning_highlight.sprint = @sprint
    if @planning_highlight.save
      redirect_to sprint_planning_highlights_path(@sprint), notice: "Highlight created!"
    else
      redirect_to sprint_planning_highlights_path(@sprint), alert: "Error happened: Highlight could not be created."
    end
  end

  def destroy
    find_planning_highlight.destroy
    redirect_to sprint_planning_highlights_path(@sprint), notice: "Highlight deleted!"
  end

  private

  def planning_highlight_params
    params.require(:planning_highlight).permit(:description)
  end

  def find_planning_highlight
    @planning_highlight = PlanningHighlight.find params[:id]
  end

  def find_sprint
    @sprint = Sprint.find params[:sprint_id]
  end

  # def authorize_user
  #   unless can? :manage, @planning_highlight
  #     redirect_to root_path, alert: "access denied!"
  #   end
  # end

end
