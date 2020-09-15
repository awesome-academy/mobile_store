class Product < ApplicationRecord
    has_many :order_details
    has_many :comments
    has_one_attached :image
    has_many :product_details
    validates :name, presence: true, length: { maximum: 50 }
    enum classify: {"Thời trang nam" => 0, "Thòi trang nữ" => 1, "thời trang trẻ em" => 2}
end
