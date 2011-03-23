class UserImage < ActiveRecord::Base
	belongs_to :user
	
	
  has_attached_file :photo,
                    :styles => {:thumb => "150x150>"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :whiny_thumbnails => true

	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 1.megabytes

end
