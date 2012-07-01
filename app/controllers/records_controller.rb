class RecordsController < ApplicationController

  before_filter :require_login, { :except => :index }

  require 'csv'

  # index temporarily in HomeController

  def edit
    @record = Record.find(params[:id])
  end

  def create      
    @record = Record.new(params[:record])
    @record.raw = params[:record][:raw]
    
    if !current_user.time_zone
      current_user.time_zone = "Eastern Time (US & Canada)"
      current_user.save
      @record.time_zone = current_user.time_zone
    end
    
    things = params[:record][:raw].split(',')
    things.each do |t|
      matches = t.match(/(\d*\.*\d*)(\D{2,}.*)/)
      @cat = Cat.new
      @cat.name = matches[2].strip
      @cat.magnitude = matches[1] unless !matches[1] 
      if @cat.magnitude && @cat.magnitude > 1
        @cat.name = @cat.name.singularize
      end
      
      # !
      # because magnitudes are stored as ints, decimals are rounded off
      
      if Karma.exists?(['name=? AND user_id=?', @cat.name, current_user.id])
        @karma = Karma.find(:first, :conditions => ['name=? AND user_id=?', @cat.name, current_user.id])
        if @cat.magnitude
          @cat.karma = @karma.points*@cat.magnitude
        else
          @cat.karma = @karma.points
        end

        current_user.karma += @cat.karma
        current_user.save
      end
      
      @record.cats << @cat
    end
    
    @record.user_id = current_user.id
     
    respond_to do |format|
      if @record.save
        format.html { redirect_to :root, notice: 'Record was successfully created.' }
        format.json { render json: @record, status: :created, location: @record }
      else        
        @records = Record.all
        format.html { render action: "index" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find(params[:id])
    @record.raw = params[:record][:raw]
    
    # return overall karma, then delete cat
    @record.cats.each do |cat|
      if cat.karma
        current_user.karma = current_user.karma - cat.karma
      end
      cat.destroy
    end
    current_user.save
    
    things = params[:record][:raw].split(',')
    things.each do |t|
      matches = t.match(/(\d*\.*\d*)(\D{2,}.*)/)
      @cat = Cat.new
      @cat.name = matches[2].strip
      @cat.magnitude = matches[1] unless !matches[1] 
      if @cat.magnitude && @cat.magnitude > 1
        @cat.name = @cat.name.singularize
      end
      
      # !
      # because magnitudes are stored as ints, decimals are rounded off
      
      if Karma.exists?(['name=? AND user_id=?', @cat.name, current_user.id])
        @karma = Karma.find(:first, :conditions => ['name=? AND user_id=?', @cat.name, current_user.id])
        if @cat.magnitude
          @cat.karma = @karma.points*@cat.magnitude
        else
          @cat.karma = @karma.points
        end
        # update overall karma
        current_user.karma += @cat.karma
        current_user.save
      end
      
      @record.cats << @cat
    end

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to '/', notice: 'Record was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    
    # update overall karma
    @record.cats.each do |cat|
      if cat.karma
        current_user.karma = current_user.karma - cat.karma
      end
    end
    current_user.save
    
    @record.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :ok }
    end
  end
  
  def export
    records = Record.limit(10)
    filename ="records_#{Date.today.strftime('%d%b%y')}"
    csv_data = CSV.generate do |csv|
      # csv << Record.csv_header
      records.each do |c| 
        csv << 'stuff'
      end
    end 
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end
    
end
