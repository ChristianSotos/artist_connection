class SessionController < ApplicationController
	def login_popup
		render :partial => "partials/login"
	end
	def login
	end
	def logout
	end
	def new_submit
		if session[:user_id]
			render :partial => "partials/qty"
		else
			@user = User.new
			render :partial => "partials/register"
		end
	end
end
