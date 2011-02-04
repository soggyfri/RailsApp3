class Relationship < ActiveRecord::Base
	attr_accessible :friend_id
	
	belongs_to :user, :class_name => "User"
	belongs_to :friend, :class_name => "User"

	validates :user_id, :presence => true
	validates :friend_id, :presence => true


end
