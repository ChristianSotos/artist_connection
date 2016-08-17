class User < ActiveRecord::Base
  	has_secure_password
  	has_attached_file :picture
  	has_many :songs

  	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, presence:true, uniqueness:{case_sensitive:false}, format:{with:EMAIL_REGEX}
	validates :first_name, :last_name, :artist_name, :password, :description, presence:true
	validates :phone_number, presence:true, numericality:{only_integer:true}
	validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
