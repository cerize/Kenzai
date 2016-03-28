class MudasController < ApplicationController
  before_action :authenticate_user
  before_action :find_project
  before_action :find_muda, only: [:show, :edit, :update, :destroy]


  def index
    @mudas =  Muda.filter_project(@project).order("created_at DESC")
  end

  def new
    @muda = Muda.new
  end

  def create
    @muda = Muda.new muda_params
    @muda.user = current_user
    @muda.project = @project
    if @muda.save
      redirect_to project_muda_path(@project, @muda), notice: "Muda created"
    else
      flash[:alert] = "Error: Muda was not created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @muda.update muda_params
      redirect_to project_muda_path(@project, @muda), notice: "Muda Updated!"
    else
      flash[:alert] = "Error: Muda was not updated!"
      render :edit
    end
  end

  def destroy
    if current_user == @muda.user
      @muda.destroy
    end
    redirect_to project_mudas_path(@project)
  end

  # def user_mudas
  #   @user_mudas = current_user.mudas
  #   render :user_mudas
  # end
  #
  #
  private

  def muda_params
    params.require(:muda).permit(:title, :description)
  end

  def find_project
    @project = Project.find_by_id params[:project_id]
  end

  def find_muda
    @muda = Muda.find  params[:id]
  end
end
