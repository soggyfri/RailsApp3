class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:friend_id])
		current_user.addAsFriend!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end 
  end

  def destroy		
=begin
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html  { redirect_to @user }
			format.js 
		end
=end
  end

  def update
    #debugger
    @new_friend = Relationship.find(params[:id])
    if params[:commit] == "Allow"
      @new_friend.approved= true
      @new_friend.save

      symetric_friend = User.find(@new_friend.friend_id);
      rel = symetric_friend.relationships.build(:friend_id => @new_friend.user_id)
      rel.approved= true
      rel.save
    else #user clicked on the Deny button
      @new_friend.destroy
    end

    redirect_to root_path
  end

end
