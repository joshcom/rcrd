class CatsController < ApplicationController

  # GET /cats/name
  # GET /cats/name.json
  def show
    @records = Record.find(:all, :order => 'created_at DESC', :joins => :cats, :conditions => ["cats.name=? AND user_id=?", params[:name], current_user.id])
    @record_days = @records.group_by { |r| r.created_at.beginning_of_day }
    @cat_name = params[:name]
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cat }
      format.csv { render :layout => false }
    end
  end
  
  # DELETE /cats/1
  # DELETE /cats/1.json
  def destroy
    @cat = Cat.find(params[:id])
    
    # update overall karma
#     @karma = Measure.find(:first, :conditions => ["name = ?", 'overall'])
    
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :ok }
    end
  end

end
