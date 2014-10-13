module SessionsHelper
	def sign_in(user)
		local_remember_token = User.new_unhashed_remember_token
		cookies.permanent[:cookie_remember_token] = local_remember_token
		user.update_attribute(:remember_token, User.digest(local_remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		local_remember_token = User.digest(cookies[:cookie_remember_token])
		@current_user ||= User.find_by(remember_token: local_remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		current_user.update_attribute(:remember_token,
							User.digest(User.new_unhashed_remember_token))
		cookies.delete(:cookie_remember_token)
		self.current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
