class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate, :set_timezone
 
  protected

  def authenticate
#    authenticate_or_request_with_http_basic do |username, password|
#     username == "jeffcarp" && password == "timanous"
#    end
    @current_user ||= User.find 2 # bear with me here 
  end

  private
  
  def set_timezone
    Time.zone = @current_user.time_zone || "America/Los_Angeles" 
  end
  
end
