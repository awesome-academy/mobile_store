class Order < ApplicationRecord
    belongs_to :user
    has_many :order_details
    validates :name, presence: true, length: { maximum: 50 }
    validates :address, presence: true, length: { maximum: 300 }
    number_regex = /\d[0-9]\)*\z/
 	validates_format_of :phone, presence: true, :with =>  number_regex, 
 						:message => "Only positive number without spaces are allowed"
 	scope :order_by_time, -> { order(created_at: :desc)}
 	enum order_status: {"Đang chờ xử lý" => 0, "Bị hủy bởi người bán" => 1, "Đã xác nhận" => 2,
 						"Giao hàng thanh công" => 3, "Giao hàng thất bại" => 4,
 						"Đã hoàn lại" => 5, "Bị hủy bởi người mua" => 6}
 	def feed_2
		self.order_details.reject{|order_detail| Product.find_by( id: order_detail.product_id).nil?}
		# a = []
		# self.order_details.each do |order_detail|
		# 	product = Product.find_by( id: order_detail.product_id)
 	# 	byebug
		# 	a << product if product.present?
		# end
		# a
	end
end
