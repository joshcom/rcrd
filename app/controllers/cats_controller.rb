class CatsController < ApplicationController

  def show
    @name = params[:id]
    @records = Record.get_cats(@name).order('created_at desc')
  end

end
