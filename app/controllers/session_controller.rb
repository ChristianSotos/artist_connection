class SessionController < ApplicationController
	def login_popup
		render :partial => "partials/login"
	end

	def index
		
	end

	def login
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/"
		else
			flash[:login_error] = "Invalid Email/Password Combination"
			render :partial => "partials/login"
		end
	end
	def logout
		reset_session
		redirect_to "/"
	end
	def new_submit
		if session[:user_id]
			render :partial => "partials/qty"
		else
			session[:from_new_song] = true
			@user = User.new
			render :partial => "partials/register"
		end
	end
end
