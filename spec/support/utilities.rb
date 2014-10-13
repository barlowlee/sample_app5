	# Returns the full title for static_pages_spec

	include ApplicationHelper

# This code was made unnecessary after exercise #4 at the end
#	of chapter 5, which essentially puts this functionality
#	in spec/helpers/application_helper_spec.rb

	# def full_title(page_title)
	# 	base_title = "ROR Tut. Samp. App"
	# 	if page_title.empty?
	# 		base_title
	# 	else
	# 		"#{base_title} | #{page_title}"
	# 	end		
	# end

	def sign_in(user, options={})
		if options[:no_capybara]
			# Sign in when not using Capybara
			remember_token = User.new_unhashed_remember_token
			cookies[:cookie_remember_token] = remember_token
			user.update_attribute(:remember_token, User.digest(remember_token))
		else
			visit signin_path
			fill_in "Email", 		with: user.email
			fill_in "Password", with: user.password
			click_button "Sign in"
		end
	end
