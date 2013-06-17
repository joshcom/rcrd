class UsersController < ApplicationController

  def edit
    # Me for now
    @user = User.find current_user.id 
  end

  def update
    @user = User.find params[:id] 
    puts params[:user].inspect 
    @user.time_zone = "fuck"
    if @user.update_attributes(params[:user])
      puts @user.inspect
      flash[:notice] = "User was successfully updated."
      redirect_to :settings
    else
      flash[:notice] = "Sorry dude, there was a problem"
      redirect_to :settings
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent.signed[:user_id] = @user.id
      redirect_to root_url, notice: "Signed up!"
    else
      render template: "sessions/new"
    end
  end

end
