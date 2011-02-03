class MicropostsController < ApplicationController 

	before_filter :authenticate
	before_filter :authorized_user, :only => :destroy

	def create
		debugger
		@micropost = current_user.microposts.build(params[:micropost])
	  if @micropost.save
			#TODO: why doesn't flash display?
			flash[:success] = "New post created"			
		else  
			flash[:error] = "Failed to create post"			
		end
		redirect_to root_path 

	end 

	def destroy 
		@micropost.destroy
		redirect_to root_path
	end 

	private 

	def authorized_user
		@micropost = Micropost.find(params[:id])
		redirect_to root_path unless current_user?(@micropost.user)
	end 

end
