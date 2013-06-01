class RecordsController < ApplicationController

  before_filter :authenticate_admin

  helper ApplicationHelper 

  def index
    @records = Record.where('target > ?', Date.today - 1.month).order('target DESC')
  end

  def show 
    @record = Record.find params[:id]  
    @current_time_zone = @record.time_zone 
    @current_time_zone_text = @record.time_zone_text
    # This is inelegant, but offset the date with its time zone
    #@record.target += @record.time_zone.utc_offset.seconds
  end

  def new
    @current_time_zone = Record.current_time_zone
    @current_time_zone_text = Record.current_time_zone_text
    @record = User.find(2).records.new(target: @current_time_zone.now)
    @trending = Record.get_trending_cats
    @last_7_days = Record.where('target > ?', Date.today - 7.days).order('target DESC')
  end

  def create      
    @record = Record.new(params[:record])

    # Wind back the date since it was selected in non-UTC
    if params[:record][:selected_with_timezone]
      @record.target -= ActiveSupport::TimeZone.new(params[:record][:selected_with_timezone]).utc_offset.seconds
    end

    if @record.save
      redirect_to action: 'new', notice: 'Record was successfully created.'
    else        
      @records = Record.all
      render action: 'new', notice: 'Sorry, there was an issue saving your record.'
    end
  end

  def update
    @record = Record.find(params[:id])

    # Wind back the date since it was selected in non-UTC
    if params[:record][:selected_with_timezone]
      @record.target -= ActiveSupport::TimeZone.new(params[:record][:selected_with_timezone]).utc_offset.seconds
    end

    if @record.update_attributes(params[:record])
      redirect_to @record, notice: 'Record was successfully updated.'
    else
      redirect_to @record, notice: 'Sorry, there was a problem saving.'
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to action: 'new', notice: 'Record was successfully deleted.'
  end
end
