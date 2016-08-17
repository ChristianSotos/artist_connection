class Admin < ActiveRecord::Base
	has_secure_password
	has_many :songs

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, presence:true, uniqueness:{case_sensitive:false}, format:{with:EMAIL_REGEX}
	validates :first_name, :last_name, :password, presence:true

end
