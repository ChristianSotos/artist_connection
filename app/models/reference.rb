class Reference < ActiveRecord::Base
	has_many :songs, through: :song_references

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, uniqueness:{case_sensitive:false}, format:{with:EMAIL_REGEX}
	validates :first_name, :last_name, presence:true
	validates :phone_number, numericality:{only_integer:true}
end
