class UsersController < ApplicationController

  def new
    @title = "Welcome new user!"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end
