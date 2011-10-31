class CatsController < ApplicationController

  # GET /cats/name
  # GET /cats/name.json
  def show
    @name = params[:name]
    @cats = Cat.find(:all, :conditions => ['name = "'+params[:name]+'"'])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cat }
    end
  end

end
