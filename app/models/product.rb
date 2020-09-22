class Product < ApplicationRecord
    has_many :order_details
    has_many :comments
    has_one_attached :image
end
