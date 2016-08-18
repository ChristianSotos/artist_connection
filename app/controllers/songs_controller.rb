class SongsController < ApplicationController
	def index
	end
	def show
		render :partial => "partials/song_report"
	end
	def qty
		render :partial => "partials/qty"
	end
	def new
		session[:song_qty] = params[:qty].to_i
		@song = Song.new
		@genres = Genre.all.order(:name)
		render :partial => "partials/new_song"
	end

	def create
		session[:song_qty] = session[:song_qty] - 1
		if session[:song_qty] == 0
			render :partial => "partials/success" 
		else
			@song = Song.new
			render :partial => "partials/new_song"
		end
	end

	private
	def song_params
		params.require(:song).permit(:name, :audio_file, :key, :bpm, :public)
	end  
end
