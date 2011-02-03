require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

	has_many  :microposts, :dependent => :destroy
  
  has_many  :relationships, :foreign_key => "user_id", :dependent => :destroy
  has_many  :friends, :through => :relationships, :foreign_key => "friend_id", :class_name => "User"

=begin
	has_many  :reverse_relationships, :foreign_key => "friend_id",
                                    :class_name  => "Relationship",
	                                  :dependent   => :destroy
=end

 # has_many :followers, :through => :reverse_relationships, :source => :follower

#TODO: put limitations on email format with regexp
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..20 }
  
  before_save :encrypt_password

	def feed
#		microposts
		Micropost.from_users_followed_by(self)
	end 

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    ( user && user.salt == cookie_salt ) ? user : nil
  end

	def following?(followed)
		relationships.find_by_followed_id(followed)
	end 

	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end 

	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
  end

  def friend?(user)
    relationships.find_by_friend_id(user)
  end


  private
  
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
end 
