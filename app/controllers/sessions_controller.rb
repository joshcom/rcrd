class SessionsController < ApplicationController

  def new 
    if params[:passcode] == ENV["RCRD_PASSCODE"]
      cookies.permanent.signed[:user_id] = 2
    end
    redirect_back_or_to root_url
  end
  
  def destroy
    cookies.permanent.signed[:user_id] = nil
    redirect_to root_url
  end

end
