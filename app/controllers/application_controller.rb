class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_timezone
  
  def get_karma_data
    karma_records = Record.find(:all, :conditions => ["user_id=? AND created_at > ?", current_user.id, 3.weeks.ago], :order => 'created_at DESC')  
    karma_dataset = Array.new
    karma_dataset << current_user.karma
    local_karma = current_user.karma
    karma_records.each do |r|
      r.cats.each do |c|
        if c.karma
          local_karma -= c.karma
        end
      end
      karma_dataset << local_karma
    end
    karma_dataset.reverse!
  end
  
  # ========== ========== ========== ==========
  
  private
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def set_timezone
    Time.zone = current_user.time_zone if logged_in?
  end
  
end
