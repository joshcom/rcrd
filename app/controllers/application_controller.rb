class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
 
  private

  def current_user 
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def authenticate_admin
    redirect_to root_url if !@current_user
  end
  
end
