class SessionsController < ApplicationController

  def new 
  end

  def create
    puts params[:email]
    puts params[:password]
    redirect_to root_url, notice: "Sorry, there was an issue logging you in."
  end
  
  def destroy
    cookies.permanent.signed[:user_id] = nil
    redirect_to root_url
  end

end
