class CatsController < ApplicationController

  def show
    @name = params[:id]
    @records = current_user.records.get_cats(@name)
    @trending_cats = Record.get_trending_cats(current_user)[0..7]
    @trending_cats.delete @name
  end

end
