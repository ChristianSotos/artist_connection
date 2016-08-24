class SongsController < ApplicationController
	def index
		session[:from_new_song] = false
		@song_count = Song.where(public:true).count
		@current_page = 1
		@songs = Song.offset(0).where(public: true).order(rating: :desc, play_count: :desc).limit(5)
		if session[:user_id]
			@user_song_count = Song.where(user:current_user).count
			@user_current_page = 1
			@user_songs = Song.offset(0).where(user:current_user).limit(5)
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
			num = num-1
			session[:songs_made][num] = new_song
		else
			flash[:song_errors] = new_song.errors.full_messages
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
		gid= params[:genre].to_i
		query = "SELECT songs.id AS id, songs.genre_id AS genre_id, songs.name AS name, users.artist_name AS artist_name, songs.play_count AS play_count, songs.rating AS rating, songs.public AS public FROM songs JOIN users ON songs.user_id = users.id WHERE public = 't' "
		and_checker = false
		if gid > 0
			query += "AND genre_id = "+params[:genre]+" "
			and_checker = true
		end
		if params[:search]
			query += "AND (name LIKE '%"+params[:search]+"%' OR artist_name LIKE'%"+params[:search]+"%') "
		end
		page_offset = params[:pagination].to_i * 5
		@current_page = params[:pagination].to_i + 1
		query += "ORDER BY rating DESC, play_count DESC "
		@song_count = Song.find_by_sql(query).count
		query += "LIMIT 5 OFFSET #{page_offset}"
		@songs = Song.find_by_sql(query)
		render :partial => "partials/top_songs_search"
	end

	def user_pagination
		page_offset = params[:pagination].to_i * 5
		@user_current_page = params[:pagination].to_i + 1
		@user_song_count = Song.where(user:current_user).count
		@user_songs = Song.offset(page_offset).where(user:current_user).limit(5)
		render :partial => "partials/user_songs"
	end

	private
	def song_params
		params.require(:song).permit(:name, :key, :bpm, :public)
	end 
	def audio_params
		params.require(:song).permit(:audio_file)
	end
end
