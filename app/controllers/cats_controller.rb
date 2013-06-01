class CatsController < ApplicationController

  def show
    @name = params[:id]
    @records = Record.get_cats(@name)
    @trending_cats = Record.get_trending_cats[0..6]
  end

end
