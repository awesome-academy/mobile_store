class User < ApplicationRecord
    has_many :orders
    has_many :order_details, through: :orders
    has_many :comments     		
	attr_accessor :remember_token
	before_save :downcase_email
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },uniqueness: true					  
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_secure_password	
	
	class << self
	    def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end	

		def new_token
			SecureRandom.urlsafe_base64
		end
	end
	# Returns a random token.
	
	def remember
		self.remember_token = User.new_token
		update_attributes remember_digest: User.digest(remember_token)
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attributes remember_digest: nil
	end

	def current_user?(user)
		user && user == self
	end
	
	def feed
		self.orders
	end

	private

		def downcase_email
	          self.email = email.downcase 
	    end
 
end
