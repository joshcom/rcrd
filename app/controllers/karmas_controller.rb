class KarmasController < ApplicationController

  before_filter :require_login

  def index    
    # Fetch all user's karmas
    @karmas = current_user.karmas
    
    # Generate Karma Dataset for header graph
    @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
      puts 'generating new karma dataset'
      get_karma_data
    end
  end

  def show
    @karma = Karma.find(params[:id])

    # Generate Karma Dataset for header graph
    @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
      get_karma_data
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @karma }
    end
  end

  # GET /karmas/new
  # GET /karmas/new.json
  def new
    @karma = Karma.new

    # Generate Karma Dataset for header graph
    @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
      get_karma_data
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @karma }
    end
  end

  # GET /karmas/1/edit
  def edit
    @karma = Karma.find(params[:id])
    
    # Generate Karma Dataset for header graph
    @karma_dataset = Rails.cache.fetch("karma_data_"+current_user.id.to_s) do
      get_karma_data
    end
  end

  # POST /karmas
  # POST /karmas.json
  def create
  
    @karma = Karma.new(params[:karma])
    current_user.karmas << @karma

    respond_to do |format|
      if @karma.save
        format.html { redirect_to @karma, notice: 'Karma was successfully created.' }
        format.json { render json: @karma, status: :created, location: @karma }
      else
        format.html { render action: "new" }
        format.json { render json: @karma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /karmas/1
  # PUT /karmas/1.json
  def update
    @karma = Karma.find(params[:id])

    respond_to do |format|
      if @karma.update_attributes(params[:karma])
        format.html { redirect_to @karma, notice: 'Karma was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @karma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /karmas/1
  # DELETE /karmas/1.json
  def destroy
    @karma = Karma.find(params[:id])
    @karma.destroy

    respond_to do |format|
      format.html { redirect_to karmas_url }
      format.json { head :ok }
    end
  end
end
