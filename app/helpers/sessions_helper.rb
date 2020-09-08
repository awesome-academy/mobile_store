module SessionsHelper

	def current_user
	
			if (user_id = session[:user_id])
				@current_user ||= User.find_by(id: user_id)
			elsif (user_id = cookies.signed[:user_id])
				user = User.find_by(id: user_id)
				if user && user.authenticated?(cookies[:remember_token])
					log_in user
					@current_user = user
				end
			end
	end

	def log_in(user)
		session[:user_id] = user.id
	end
	def logged_in?
		current_user.present?
	end

end