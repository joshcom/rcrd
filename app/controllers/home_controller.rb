class HomeController < ApplicationController

  layout 'home'

  def index
    respond_to do |format|
      format.html
    end
  end

end
