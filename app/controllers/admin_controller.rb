class AdminController < ApplicationController
  def index
  	@pending_songs = Song.offset(0).where(reviewed: false).order(created_at: :desc)
  	@reviewed_songs = Song.offset(0).where(reviewed: true).order(created_at: :desc)
  end

  def review_song
  	@song = Song.find(params[:id])
  	# @artist = User.find(@song.user_id)
  	@reference = Reference.new
  end

  def add_review
  	song = Song.find(params[:id])
  	rating = params[:rating].to_i
  	admin = Admin.find(session[:admin_id])
  	song.update(analysis:params[:analysis], rating:rating, reviewed:"t", admin:admin)
  	redirect_to "/admin"
  end

  def add_reference
  	song = Song.find(params[:song_id])
  	ref = Reference.find(params[:ref_id])
  	sr = SongReference.create(song:song, reference:ref)
  	@song = Song.find(params[:song_id])
  	@reference = Reference.new
  	render :partial => "partials/references_form"
  end

  def del_ref
  	song = Song.find(params[:song_id])
  	ref = Reference.find(params[:ref_id])
  	sr = SongReference.where(song:song, reference:ref)
  	sr.destroy_all
  	@song = Song.find(params[:song_id])
  	@reference = Reference.new
  	render :partial => "partials/references_form"
  end

  def new_reference
  	ref = Reference.new(ref_params)
  	if ref.save
  		song = Song.find(params[:song_id])
  		SongReference.create(song:song, reference:ref)
  	end
  	@song = Song.find(params[:song_id])
  	@reference = Reference.new
  	render :partial => "partials/references_form"
  end

  private
  def ref_params
  	params.require(:reference).permit(:first_name, :last_name, :email, :phone_number, :field)
  end

end
