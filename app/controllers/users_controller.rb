class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to my_projects_path, notice: "Account created!"
    else
      flash[:alert] = "Sorry, the account could not be created."
      render :new
    end
  end

  def show
    find_user
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by_id params[:id]
  end

end
