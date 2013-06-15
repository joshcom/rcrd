class SessionsController < ApplicationController

  def new # this serves as sessions#new and user#new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      cookies.permanent.signed[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to 'sessions/new' 
    end
  end
  
  def destroy
    cookies.permanent.signed[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

end
