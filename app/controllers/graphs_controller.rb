class GraphsController < ApplicationController

  def index
    
  end

  def yours
    User.find(params[:id])
    
    @records = Record.find(:all, :conditions => ["user_id=?", current_user.id], :order => 'created_at ASC')
    
  end

end
