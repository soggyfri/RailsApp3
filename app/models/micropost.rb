class Micropost < ActiveRecord::Base
	attr_accessible :content, :recipient
		
	belongs_to :user
	
	validates :content, :presence => true, :length => { :maximum => 200 }
	validates :user_id, :presence => true            #the creator of the micropost
	validates :recipient, :presence => true          #id of the person whos wall contains the post

	default_scope :order => "microposts.created_at DESC"
	
	scope :from_users_followed_by, lambda { |user| followed_by(user) }

	private 

	def self.followed_by(user)
		followed_ids = user.following.map(&:id).join(", ")
		where("user_id IN (#{followed_ids}) OR user_id = :user_id", { :user_id => user})
	end 
end
