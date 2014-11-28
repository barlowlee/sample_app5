class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
																	 class_name:  "Relationship",
																	 dependent:   :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

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

	def feed
		# This first line was preliminary.  
		# Micropost.where("user_id = ?", id)
		Micropost.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_unhashed_remember_token)
		end
end
