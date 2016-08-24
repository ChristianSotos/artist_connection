class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	user = User.find(session[:user_id])
  	user
  end
  def get_genres
  	genres = Genre.all.order(:name)
  	genres
  end
  def get_song song_id
    song = Song.find(song_id)
    song
  end
  def get_references 
    references = Reference.all
    references
  end
  def get_song_references song_id
    song = Song.find(song_id)
    references = song.references
    return references
  end
  helper_method :current_user, :get_genres, :get_song, :get_references, :get_song_references
end
