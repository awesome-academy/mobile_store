class Order < ApplicationRecord
    belongs_to :user
    has_many :order_details

    validates :name, presence: true, length: { maximum: 50 }
    validates :address, presence: true, length: { maximum: 300 }
    number_regex = /\d[0-9]\)*\z/
 	validates_format_of :phone, presence: true, :with =>  number_regex, 
 						:message => "Only positive number without spaces are allowed"
 	
end
