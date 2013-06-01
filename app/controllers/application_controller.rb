class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate, :set_timezone
 
  protected

  def authenticate
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  private
  
  def set_timezone
    if @current_user
      Time.zone = @current_user.time_zone 
    else
      Time.zone = "America/Los_Angeles" 
    end
  end
  
end
