class CatsController < ApplicationController

# require 'csv'

  # GET /cats/:name
  # GET /cats/:name.json
  # GET /cats/:name.csv
  def show
    @records = Record.find(:all, :order => 'created_at DESC', :joins => :cats, :conditions => ["cats.name=? AND user_id=?", params[:name], current_user.id])
    @records_for_chart = Record.find(:all, :joins => :cats, :conditions => ["cats.name=? AND user_id=?", params[:name], current_user.id], :order => 'created_at ASC') 
    @record_days = @records.group_by { |r| r.created_at.beginning_of_day }
    @cat_name = params[:name]
    
    # Generate Karma Dataset for header graph
    @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
      get_karma_data
    end
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cat }
      format.csv { render :layout => false }
    end
  end

end
