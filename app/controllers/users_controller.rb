class UsersController < ApplicationController

  def edit
    # Me for now
    @user = User.find current_user.id 
  end

  def update
    @user = User.find params[:id] 

    if @user.update_attributes(params[:user])
      redirect_to :settings, notice: "User was successfully updated."
    else
      redirect_to :settings, notice: "Sorry dude, there was a problem"
    end
  end

  def create
    @user = User.new(params[:user])
    puts @user.inspect
    if @user.save
      cookies.permanent.signed[:user_id] = @user.id
      redirect_to root_url, notice: "Signed up!"
    else
      render template: "sessions/new"
    end
  end

end
