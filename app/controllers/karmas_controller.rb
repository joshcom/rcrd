class KarmasController < ApplicationController
  # GET /karmas
  # GET /karmas.json
  def index
    @karmas = Karma.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @karmas }
    end
  end

  # GET /karmas/1
  # GET /karmas/1.json
  def show
    @karma = Karma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @karma }
    end
  end

  # GET /karmas/new
  # GET /karmas/new.json
  def new
    @karma = Karma.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @karma }
    end
  end

  # GET /karmas/1/edit
  def edit
    @karma = Karma.find(params[:id])
  end

  # POST /karmas
  # POST /karmas.json
  def create
  
    @karma = Karma.new(params[:karma])

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
