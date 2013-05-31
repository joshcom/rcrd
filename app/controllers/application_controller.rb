class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_timezone, :authenticate
 
  protected

  def authenticate
#    authenticate_or_request_with_http_basic do |username, password|
#     username == "jeffcarp" && password == "timanous"
#    end
  end

  private
  
  def set_timezone
    if logged_in?
      Time.zone = current_user.time_zone 
    else 
      Time.zone = "America/Los_Angeles" 
    end
  end
  
end
