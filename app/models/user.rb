class User < ActiveRecord::Base
	has_many :microposts
	before_save { self.email = email.downcase }
	before_create :create_remember_token
		# this is a private method below, in user.rb

	validates :name, presence: true, length: { maximum: 50 }
		# this is the verbose form of the same method:
		#	validates(:name, { :presence => true })	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	has_secure_password

	def User.new_unhashed_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(unhashed_token)
		Digest::SHA1.hexdigest(unhashed_token.to_s)		
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_unhashed_remember_token)
		end
end
