class Relationship < ActiveRecord::Base
	attr_accessible :followed_id
	
	belongs_to :user, :class_name => "User"
	belongs_to :friend, :class_name => "User"

	validates :follower_id, :presence => true
	validates :followed_id, :presence => true


end
