class User < ApplicationRecord
    has_many :orders
    has_many :order_details, through: :orders
    has_many :comments 
    has_secure_password
end
