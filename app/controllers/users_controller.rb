class UsersController < ApplicationController

  before_filter :authenticate_admin

  def edit
    # Me for now
    @user = User.find(2)
  end

  def update
    @user = User.find params[:id] 

    if @user.update_attributes(params[:user])
      redirect_to :settings, notice: "User was successfully updated."
    else
      redirect_to :settings, notice: "Sorry dude, there was a problem"
    end
  end

end
