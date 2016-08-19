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
		session[:songs_made] = nil
		session[:song_qty] = params[:qty].to_i
		session[:songs_pending] = session[:song_qty]
		session[:songs_made] = Array.new(session[:song_qty])
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
			session[:songs_pending] = session[:songs_pending] - 1
			num = params[:songnum].to_i
			session[:songs_made][num-1] = new_song
		else
			flash[:errors] = new_song.errors.full_messages
		end
			@genres = Genre.all.order(:name)
			@song = Song.new
			render :partial => "partials/new_song"
	end
	#for end of new song submit
	def audio_upload
		session[:songs_pending] = session[:song_qty]
		@song = Song.new
	end
	def audio_submit
		song = Song.find(params[:id])
		if !params[:song]
			@song = Song.new
			redirect_to "/audio_upload"
		else
			song.update(audio_params)
			if song.valid?
				flash[:errors] = song.errors.full_messages
			end
			redirect_to "/audio_upload"
		end
	end

	#for updating audio file
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
			if @song.valid?
				flash[:errors] = @song.errors.full_messages
			end
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
