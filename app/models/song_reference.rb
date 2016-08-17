class SongReference < ActiveRecord::Base
  belongs_to :song
  belongs_to :reference
end
