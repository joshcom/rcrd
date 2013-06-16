class RecordsController < ApplicationController

  before_filter :authenticate

  helper ApplicationHelper 

  def index
    @records = current_user.records.where('target > ?', Date.today - 1.month).order('target DESC')
  end

  def show 
    @record = current_user.records.find params[:id]  
  end

  def new
    @record = current_user.records.new(target: current_user.current_time_zone.now)
    @last_7_days = current_user.records.where('target > ?', Date.today - 7.days)
  end

  def create      
    @record = current_user.records.new(params[:record])
    @record.target = Time.now.utc.strftime('%c') # shoddy workaround
    if @record.save
      flash[:notice] = "Record was successfully created."
      redirect_to action: 'new'
    else        
      flash[:notice] = "Sorry, there was an issue saving your record."
      redirect_to action: 'new'
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
