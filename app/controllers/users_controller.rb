class UsersController < ApplicationController

	before_filter :authenticate, :only => [:edit, :update, :index, :show]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only => :destroy

	def index
		@title = "Search"
    @users =  User.search(params[:search])
      
		end

	def home
		if signed_in?
			@user = current_user
			redirect_to current_user			
		else 
			#display home
		end 
	end 
 
  def new
    @user = User.new
    @title = "Welcome new user!"
  end
  
  def show
		@user = User.find(params[:id])		
		@title = @user.name
		@micropost = Micropost.new if signed_in?
		#@microposts = @user.microposts.paginate(:page => params[:page])
    @microposts = Micropost.find_all_by_recipient(@user).paginate(:page => params[:page])
		
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      sign_in @user
      flash[:success] = "Welcome to Uconn's own social network!"
      redirect_to @user
    else
      @title = "Sign up: Error"
      render 'new'
    end
  end

	def destroy
		user = User.find(params[:id])
		flash[:success] = "Deleted #{user.name}."
		user.destroy
		redirect_to users_path
	end 

	def edit 
 		@title = "Edit"
	end 

	def update
    debugger
    @user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Updated successfully"
			redirect_to @user
		else 
			@title = "Edit"
			render 'edit'
		end 
	end

def following 
	@title = "Following"
	@user = User.find(params[:id])
	@users = @user.following.paginate(:page => params[:page])
	render 'show_follow'
end  

def followers
	@title = "Followers"
	@user  = User.find(params[:id])
        @users = @user.followers.paginate(:page => params[:page])
	render 'show_follow'
end


	private 

	def admin_user
		redirect_to root_path unless current_user.admin?
	end 
	
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end 


end
