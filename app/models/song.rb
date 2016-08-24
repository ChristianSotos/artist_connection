class Song < ActiveRecord::Base
	has_attached_file :audio_file
	belongs_to :genre
	belongs_to :user
	belongs_to :admin
	has_many :song_references
	has_many :references, through: :song_references

	validates :name, presence:true
	validates :user, :genre, presence:true
	#validates_attachment_presence :audio_file
	validates_attachment_content_type :audio_file, :content_type => ["audio/mp3", "audio/mp4", "audio/m4a", "audio/x-m4a", "audio/m4p", "audio/x-m4p", "audio/mpeg", "audio/x-mpeg"]

	before_create do
		self.reviewed = false
		self.play_count = 0
	end
end
