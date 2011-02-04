class RelationshipsController < ApplicationController

  def create
   # debugger
		@user = User.find(params[:relationship][:friend_id])
		current_user.addAsFriend!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end 
  end

  def destroy		
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html  { redirect_to @user }
			format.js 
		end 
  end

  def update
    @new_friend = Relationship.find(params[:id])
    @new_friend.approved= true
    @new_friend.save

    symetric_friend = User.find(@new_friend.friend_id);
    rel = symetric_friend.relationships.build(:friend_id => @new_friend.user_id)
    rel.approved= true
    rel.save

    redirect_to root_path
  end

end
