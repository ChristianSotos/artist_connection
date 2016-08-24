class UsersController < ApplicationController
	def show
		@artist = User.find(params[:id])
		@artist_songs = Song.where(user:@artist).order(rating: :desc, play_count: :desc)
		render :partial => "partials/artist_info"
	end
	def profile
		@songs = Song.where(user:current_user)
		@user = current_user
	end
	def register
		if Admin.find_by(email: params[:user][:email])
			render :partial => "partials/register"
		end
		new_user = User.new(user_params)
		if new_user.save
			session[:user_id] = new_user.id
			if session[:from_new_song]
				session[:from_new_song] = false
				render :partial => "partials/qty"
			else
				rediect_to "/songs/index"
			end
		else
			flash[:reg_errors] = new_user.errors.messages
			@user = User.new
			render :partial => "partials/register"
		end
	end
	def update
		@user = current_user
		if params[:field] == "first_name"
			@user.update(first_name: params[:value])
		elsif params[:field] == "last_name"
			@user.update(last_name: params[:value])
		elsif params[:field] == "email"
			@user.update(email: params[:value])
		elsif params[:field] == "phone_number"
			@user.update(phone_number: params[:value])
		elsif params[:field] == "description"
			@user.update(description: params[:value])
		elsif params[:field] == "artist_name"
			@user.update(artist_name: params[:value])
		end
		redirect_to "/profile"
	end

	def upload_pic
		@user = current_user
		render :partial => "partials/upload_picture"
	end

	def update_pic
		@user = current_user
		if !params[:user]
			redirect_to "/profile"
		else
			@user.update(pic_params)
			redirect_to "/profile"
		end
	end

	def sm_popup
		@user = current_user
		render :partial => "partials/sm_popup"
	end
	def update_sm
		user = current_user
		user.update(sm_params)
		redirect_to "/profile"
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :artist_name, :phone_number, :email, :password, :password_confirmation, :description, :facebook, :twitter, :instagram, :soundcloud)
	end
	def pic_params
		params.require(:user).permit(:picture)
	end
	def sm_params
		params.require(:user).permit(:facebook, :twitter, :instagram, :soundcloud)
	end
end
