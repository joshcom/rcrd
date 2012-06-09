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
  
  def stats
      @jeff = User.find_by_email 'gcarpenterv@gmail.com'
      @jon = User.find 5
      
      two_months_ago = 2.months.ago.in_time_zone("Pacific Time (US & Canada)").strftime("%Y-%m-%d 00:00:00")
      
      # Jesus, this is terrible.
      # I could not have tried to make this more inelegant.
      workouts_in_last_2_months = Record.find(:all, :joins => :cats, :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'workout', @jeff.id, two_months_ago]).count  
      weeks_since = (Time::days_in_month(2.months.ago.in_time_zone("Pacific Time (US & Canada)").strftime('%m').to_i,  2.months.ago.in_time_zone("Pacific Time (US & Canada)").strftime('%Y').to_i) / 7) + (Time::days_in_month(1.month.ago.in_time_zone("Pacific Time (US & Canada)").strftime('%m').to_i,  1.month.ago.in_time_zone("Pacific Time (US & Canada)").strftime('%Y').to_i) / 7)
      @jeff_avg_workouts_per_week_last_2_months = workouts_in_last_2_months / weeks_since
      
      jeff_drinks_this_month = Record.find(:all, :joins => :cats, :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'drink', @jeff.id, Time.zone.now.strftime("%Y-%m-01 00:00:00")])
      @jeff_drinks_this_month = 0
      jeff_drinks_this_month.each do |r|
        r.cats.each do |c|
          if c.name == 'drink'
            @jeff_drinks_this_month += c.magnitude
          end
        end
      end
      
      jon_drinks_this_month = Record.find(:all, :joins => :cats, :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'drink', @jon.id, Time.zone.now.strftime("%Y-%m-01 00:00:00")])
      @jon_drinks_this_month = 0
      jon_drinks_this_month.each do |r|
        r.cats.each do |c|
          if c.name == 'drink'
            if !c.magnitude
              @jon_drinks_this_month += 1
            else
              @jon_drinks_this_month += c.magnitude
            end
          end
        end
      end
       
  end

end
