class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username:(params[:username]))
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
  else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Succesfully Logged Out"
    redirect_to root_path
  end

end