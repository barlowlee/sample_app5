#example_user.rb
class User
	# attr_accessor :name, :email
# Getters
	def name
		name = @name
	end

	def email
		email = @email
	end

# Setters
	def name=(thing)
		@name = thing
	end

	def email=(thing)
		@email = thing
	end

	def initialize(any_particular_user = {})
		@name = any_particular_user[:name]
		@email = any_particular_user[:email]
	end

	def formatted_email
		"#{@name} <#{@email}"
	end
end