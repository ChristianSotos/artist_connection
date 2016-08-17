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
  	session[:songs_qty] = params[:qty]
  end
end
