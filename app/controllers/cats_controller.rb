class CatsController < ApplicationController

  before_filter :authenticate

  def show
    @name = params[:name]
    @records = current_user.records.where("raw LIKE ?", '%'+@name+'%')
    @trending_cats = current_user.get_trending_cats[0..7]
    @trending_cats.delete @name
    
    # cat_settings is experimental
    # @cat_settings = current_user.time_zone[@name]
    @cat_settings = {"dashboard" => true, "public" => true, "binary_day_averages" => false, "magnitude_day_averages" => true}    
  end

  def update
  end

end
