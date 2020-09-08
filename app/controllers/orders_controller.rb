class OrdersController < ApplicationController

	def new
		@order = Order.new
	end

	def create
	 	@order = Order.new(order_params)	
	 	if @order.save 	
			session[:cart].each do |order_detail|
				@order_detail = @order.order_details.new(
			 		product_id: order_detail.first.to_i,
			 		quantity: order_detail.last,
			 		order_id: @order.id
			 	)
			 	if @order_detail.save!
					flash[:success] = "Đặt hàng thành công"
				end 	
		 	end
			session[:cart] = nil
			redirect_to root_path
		else
			redirect_to new_order_path
		end
	end

	private

		def order_params
			params.require(:order).permit(:user_id, :total_price, :name, :address, :phone)
		end

end




