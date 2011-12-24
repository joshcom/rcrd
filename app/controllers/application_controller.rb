class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_timezone
  
  private
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def set_timezone
    Time.zone = current_user.time_zone if logged_in?
  end
  
end
