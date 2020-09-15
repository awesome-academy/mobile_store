class Product < ApplicationRecord
    has_many :order_details, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one_attached :image
    has_many :product_details, dependent: :destroy
    validates :name, presence: true, length: { maximum: 50 }   
    enum classify: {"men" => 0, "woman" => 1, "kid" => 2}

    
    def discount_price
        if self.discount.present?
            self.price -= self.price* self.discount / 100
        else
           self.price 
        end
    end
    
    def self.buy_count
        
        count_buy = OrderDetail.group(:product_id).where("created_at >=?", 1.month.ago).count

        count_buy = count_buy.sort_by {|k, v| v}[-5..-1]
        
    end
end
