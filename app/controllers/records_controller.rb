class RecordsController < ApplicationController

  helper ApplicationHelper 

  def index
    @records = Record.where('created_at > ?', Date.today - 1.month).order('created_at DESC')
  end

  def show 
    @record = Record.find params[:id]  
  end

  def new
    @record = User.find(2).records.new
    @trending = Record.get_trending_cats
    @last_7_days = Record.where('created_at > ?', Date.today - 7.days).order('created_at DESC')
  end

  def create      
    @record = Record.new(params[:record])
    # TODO: set record time zone
    if @record.save
      redirect_to action: 'new', notice: 'Record was successfully created.'
    else        
      @records = Record.all
      render action: 'new', notice: 'Sorry, there was an issue saving your record.'
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
    redirect_to :records
  end
end
