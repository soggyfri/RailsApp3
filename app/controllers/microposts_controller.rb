class MicropostsController < ApplicationController 

	before_filter :authenticate

	def create
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

	end 

end
