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
      redirect_to action: :new, notice: "There was a problem with your email or password."
    end
  end
  
  def destroy
    cookies.permanent.signed[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

end
