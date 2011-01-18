class UsersController < ApplicationController

  def new
    @user = User.new
    @title = "Welcome new user!"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      sign_in @user
      flash[:success] = "Welcome to Uconn's own Facebook!"
      redirect_to @user
    else
      @title = "Sign up: Error"
      render 'new'
    end
  end

end
