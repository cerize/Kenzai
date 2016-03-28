class SnippetsController < ApplicationController
  before_action :authenticate_user
  before_action :find_project
  before_action :find_snippet, only: [:show, :edit, :update, :destroy]


  def index
    @snippets =  Snippet.filter_project(@project).order("created_at DESC")
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new snippet_params
    @snippet.user = current_user
    @snippet.project = @project
    if @snippet.save
      redirect_to project_snippet_path(@project, @snippet), notice: "Snippet created"
    else
      flash[:alert] = "Error: Snippet was not created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update snippet_params
      redirect_to project_snippet_path(@project, @snippet), notice: "Snippet Updated!"
    else
      flash[:alert] = "Error: Snippet was not updated!"
      render :edit
    end
  end

  def destroy
    if current_user == @snippet.user
      @snippet.destroy
    end
    redirect_to project_snippets_path(@project)
  end

  # def user_snippets
  #   @user_snippets = current_user.snippets
  #   render :user_snippets
  # end
  #
  #
  private

  def snippet_params
    params.require(:snippet).permit(:title, :description)
  end

  def find_project
    @project = Project.find_by_id params[:project_id]
  end
  
  def find_snippet
    @snippet = Snippet.find  params[:id]
  end

end
