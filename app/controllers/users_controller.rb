class UsersController < ApplicationController

  def edit
    # Me for now
    @user = User.find(2)
  end

end
