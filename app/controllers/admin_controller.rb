class AdminController < ApplicationController
  def index
  	@pending_songs = Song.offset(0).where(reviewed: false).order(created_at: :desc).limit(10)
  	@reviewed_songs = Song.offset(0).where(reviewed: true).order(created_at: :desc).limit(10)
  end

  def review_song
  	@song = Song.find(params[:id])
  	@artist = User.find(@song.user_id)
  end

end
