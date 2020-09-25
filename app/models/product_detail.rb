class ProductDetail < ApplicationRecord
  belongs_to :product
  enum size: {"XS" => 0, "S" => 1, "M" => 2,"L" => 3, "XL" => 4, "XXL" => 5}
end
