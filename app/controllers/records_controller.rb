class RecordsController < ApplicationController

  def index
    @records = Record.where('created_at > ?', Date.today - 1.month).order('created_at DESC')
  end
    
end
