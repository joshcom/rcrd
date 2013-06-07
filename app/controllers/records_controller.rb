class RecordsController < ApplicationController

  before_filter :authenticate_admin

  helper ApplicationHelper 

  def index
    @records = Record.where('target > ?', Date.today - 1.month).order('target DESC')
  end

  def show 
    @record = Record.find params[:id]  
  end

  def new
    @record = User.find(2).records.new(target: Record.current_time_zone.now)
    @trending = Record.get_trending_cats || []
    @last_7_days = Record.where('target > ?', Date.today - 7.days)
  end

  def create      
    puts params[:record].inspect

    @record = Record.new(params[:record])

    if @record.save
      redirect_to action: 'new', notice: 'Record was successfully created.'
    else        
      @records = Record.all
      redirect_to action: 'new', notice: 'Sorry, there was an issue saving your record.'
    end
  end

  def update
    @record = Record.find(params[:id])

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
