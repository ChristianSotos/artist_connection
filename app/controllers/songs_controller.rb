class SongsController < ApplicationController
	def index
		top_offset = session[:top_songs_pagination]*5
		@songs = Song.offset(top_offset).order(rating: :desc, play_count: :desc).limit(5)
		if session[:user_id]
			user_offset = session[:top_songs_pagination]*5
			@user_songs = Song.offset(user_offset).where(user:current_user).limit(5)
		end
	end
	def show
		@genres = Genre.all.order(:name)
		@song = Song.find(params[:id])
		if @song.reviewed
			render :partial => "partials/song_report"
		else
			render :partial => "partials/song_edit"
		end
	end
	def update
		@song = Song.find(params[:id])
		if params[:field] == "name"
			@song.update(name: params[:value])
		elsif params[:field] == "key"
			@song.update(key: params[:value])
		elsif params[:field] == "bpm"
			@song.update(bpm: params[:value])
		elsif params[:field] == "public"
			@song.update(public: params[:value])
		elsif params[:field] == "genre"
			@song.update(genre: Genre.find(params[:value]))
		end
		render :partial => "partials/song_edit"
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
		new_song = Song.new(song_params)
		new_song.user = current_user
		new_song.genre = Genre.find(params[:song][:genre])

		if new_song.valid?
			new_song.save
			session[:song_qty] = session[:song_qty] - 1
			if session[:song_qty] == 0
				render :partial => "partials/success" 
			else
				@genres = Genre.all.order(:name)
				@song = Song.new
				render :partial => "partials/new_song"
			end
		else
			@genres = Genre.all.order(:name)
			@song = Song.new
			flash[:errors] = new_song.errors.full_messages
			render :partial => "partials/new_song"
		end

	end

	def upload_audio
		@song = Song.find(params[:id])
		render :partial => "partials/upload_song"
	end
	def update_audio
		@song = Song.find(params[:id])
		if !params[:song]
			redirect_to "/profile"
		else
			@song.update(audio_params)
			flash[:errors] = @song.errors.full_messages
			redirect_to "/profile"
		end
	end

	def play_count
		song = Song.find(params[:id])
		pc = song.play_count + 1
		song.update(play_count: pc)
	end

	def top_search
		# session[:top_songs_pagination]
		# top_offset = session[:top_songs_pagination] * 5
		if params[:genre] == '0'
			@songs = Song.offset(0).where("artist_name LIKE '%#{params[:search]}%'").order(rating: :desc, play_count: :desc).limit(5)
		else
			@songs = Song.offset(0).where("name LIKE '%#{params[:search]}'", genre:Genre.find(params[:genre])).order(rating: :desc, play_count: :desc).limit(5)
		end
		render :partial => "partials/top_songs"
	end

	private
	def song_params
		params.require(:song).permit(:name, :key, :bpm, :public)
	end 
	def audio_params
		params.require(:song).permit(:audio_file)
	end
end
