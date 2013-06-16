class CatsController < ApplicationController

  before_filter :authenticate

  def show
    @name = params[:name]
    @records = current_user.records.where("raw LIKE ?", '%'+@name+'%')
    @trending_cats = current_user.get_trending_cats[0..7]
    @trending_cats.delete @name
  end

end
