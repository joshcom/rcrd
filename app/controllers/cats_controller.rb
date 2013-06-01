class CatsController < ApplicationController

  def show
    @name = params[:id]
    @records = Record.get_cats(@name)
  end

end
