class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
 
  private

  def current_user 
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def authenticate
    redirect_to root_url, notice: "Not logged in" if !current_user
  end
  
end
