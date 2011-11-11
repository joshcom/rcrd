class CatsController < ApplicationController

  # GET /cats/name
  # GET /cats/name.json
  def show
    @name = params[:name]
    @cats = Cat.where(["\"name\" = '"+params[:name]+"'"])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cat }
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
