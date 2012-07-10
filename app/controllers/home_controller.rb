class HomeController < ApplicationController

  def index 
    # this is a terrible fix, I know
    if current_user   
      @records = Record.find(:all, :conditions => ["user_id=? AND created_at > ?", current_user.id, 3.weeks.ago], :order => 'created_at DESC')  
      @record_days = @records.group_by { |r| r.created_at.beginning_of_day }
      @record ||= Record.new
      @record.created_at = Time.zone.now.strftime("%H:%M %d/%m/%Y")
      
      # Generate Karma Dataset for header graph
      @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
        get_karma_data
      end
      
      # Specify view
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
    @jon = User.find_by_email 'kenshin534@gmail.com'
  
    # Jeff In-n-Out Bugers
    # =================================
  
    in_n_out_burgers = Record.find(
      :all, 
      :joins => :cats, 
      :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'In-n-Out Burger', @jeff.id, Time.now.beginning_of_year()])
    
    @burgers = Array.new
    in_n_out_burgers.each do |b|
      @burgers << [b.created_at.strftime("%Y"),
                  b.created_at.strftime("%m").to_i - 1,
                  b.created_at.strftime("%d") ]
    end
    
      @jeff_in_n_out_this_year = Record.find(:all, :joins => :cats, :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'In-n-Out Burger', @jeff.id, Time.zone.now.beginning_of_year]).count

      # Jeff Drinks This Year
      # =================================

    jeff_drinks = Record.find(
      :all, 
      :joins => :cats, 
      :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'drink', @jeff.id, Time.now.beginning_of_year()])
    
    @jeff_drinks = Array.new
    jeff_drinks.each do |b|
      @jeff_drinks << [b.created_at.strftime("%Y"),
                  b.created_at.strftime("%m").to_i - 1,
                  b.created_at.strftime("%d") ]
    end
      
      # Jeff Longest Time Sober
      # =================================

      jeff_all_drinks = Record.find(
        :all, 
        :joins => :cats, 
        :conditions => ["cats.name=? AND records.user_id=? AND records.created_at >= ?", 'drink', @jeff.id, Time.now.beginning_of_year()],
        :order => "records.created_at DESC"
      )
      
      longest_time = 0
      last_one = false
      jeff_all_drinks.each do |r|
        if last_one
          this_difference = last_one - r.created_at
          if this_difference > longest_time
            longest_time = this_difference
            @jeff_sober_end = last_one
            @jeff_sober_begin = r.created_at 
          end
        end
        last_one = r.created_at
      end
      
      @sober_dates = Array.new
      @sober_dates << [@jeff_sober_begin.strftime("%Y"),
                  @jeff_sober_begin.strftime("%m").to_i - 1,
                  @jeff_sober_begin.strftime("%d") ]
      @sober_dates << [@jeff_sober_end.strftime("%Y"),
                  @jeff_sober_end.strftime("%m").to_i - 1,
                  @jeff_sober_end.strftime("%d") ]
      
      @jeff_longest_time_sober = (longest_time / 86400).to_i
      
      
=begin
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
      
=end
  end

end
