class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # Find user
    @user = User.find(params[:id])
    
    # Generate Karma Dataset for header graph
    @karma_dataset = get_karma_data

    # Only current_user can edit user    
    if current_user != @user
      redirect_to root_url
    end
  end

  def create
    @user = User.new(params[:user])
    @user.karma = 0
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to '/', notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
