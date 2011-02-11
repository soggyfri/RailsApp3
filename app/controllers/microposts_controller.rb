class MicropostsController < ApplicationController 

	before_filter :authenticate
	before_filter :authorized_user, :only => :destroy

	def create	
		@micropost = current_user.microposts.build(params[:micropost])
    @redirect_user = User.find(params[:micropost][:recipient])
	  if @micropost.save
			#Note: flash does not work when redirect_to root_path because
      #root_path -> / -> redirect_to current_user, flash is erased after the
      #first redirect so it won't appear by redirect_to current_user
			flash[:success] = "New post created"			
		else  
			flash[:error] = "Failed to create post"			
    end
    respond_to do |format|
		  format.html  { redirect_to @redirect_user }
      format.js      
    end

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
