class UsersController < ApplicationController

  def edit
    # Me for now
    @user = User.find(2)
    puts @user.inspect
  end

end
