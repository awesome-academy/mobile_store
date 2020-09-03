class User < ApplicationRecord
    has_many :orders
    has_many :order_details, through: :orders
    has_many :comments 
   
    before_save :downcase_email
	validates :name, presence: true, length: { maximum: 50 }
	validates :phone, presence: true, length: { maximum: 20 }
	validates :address, presence: true, length: { maximum: 250 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX },
				uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	private
	
	def downcase_email
		def downcase_email
	  self.email = email.downcase 
		  self.email = email.downcase 	  
		end		  
	end
end
