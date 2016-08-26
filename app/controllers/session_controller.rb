class SessionController < ApplicationController
	def login_popup
		render :partial => "partials/login"
	end
	def login_popup_header
		session[:from_new_song] = false
		render :partial => "partials/login"
	end

	def index
		@featured_artists = Song.find_by_sql("SELECT SUM(play_count) AS plays, user_id FROM Songs GROUP BY(user_id) ORDER BY plays DESC LIMIT 6")
	end

	# page to view pricing and offerings
	def about
	end

	def login
		admin = Admin.find_by(email: params[:email])
		if admin && admin.authenticate(params[:password])
			session[:admin_id] = admin.id
			redirect_to '/admin'	
		else
			user = User.find_by(email: params[:email])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				if session[:from_new_song] == true
					session[:from_new_song] = false
					render :partial => "partials/qty"
				else
					redirect_to "/songs/index"
				end
			else
				flash[:login_error] = "Invalid Email/Password Combination"
				render :partial => "partials/login"
			end
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
			@user = User.new
			session[:from_new_song] = true
			render :partial => "partials/register"
		end
	end
end
