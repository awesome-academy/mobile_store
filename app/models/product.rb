class Product < ApplicationRecord
    has_one_attached :image
    has_many :order_details
    has_many :comments    
end
