class UsersController < ApplicationController
	def show
		render :partial => "partials/artist_info"
	end
	def profile
		@songs = Song.where(user:current_user)
		@user = current_user
	end
	def register
		new_user = User.new(user_params)
		if new_user.save
			if session[:from_new_song]
				render :partial => "partials/qty"
			else
				rediect_to "/"
			end
		else
			flash[:errors] = new_user.errors.messages
			@user = User.new
			render :partial => "partials/register"
		end
	end

	def upload_pic
		@user = current_user
		render :partial => "partials/upload_picture"
	end

	def update_pic
		user = current_user
		user.update(pic_params)
		if !user.valid?
			flash[:errors] = "invalid picture type"
			render :partial => "partials/upload_picture"
		else
			redirect_to "/profile"
		end
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :artist_name, :phone_number, :email, :password, :password_confirmation, :description, :facebook, :twitter, :instagram, :soundcloud)
	end
	def pic_params
		params.require(:user).permit(:picture)
	end
end
