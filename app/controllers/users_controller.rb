class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Invalid Username or Password"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @donations = @user.donations
    @reviews = @user.reviews
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
