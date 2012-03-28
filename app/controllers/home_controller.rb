class HomeController < ApplicationController

  def index 
    # kids, never do this at home.
    if current_user
      @records = Record.find(:all, :conditions => ["user_id=?", current_user.id], :order => 'created_at DESC', :limit => 30)  
      @record_days = @records.group_by { |r| r.created_at.beginning_of_day }
      if !current_user.karma
        current_user.karma = 0
        current_user.save
      end
      @record ||= Record.new
      @record.created_at = Time.zone.now.strftime("%H:%M %d/%m/%Y")
      template = 'records/index'
      layout = 'application'
    else
      template = 'home/index'
      layout = 'home'
    end
    
    respond_to do |format|
      format.html { render :template => template, :layout => layout }   
    end
  end

end
