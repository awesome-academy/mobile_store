class OrdersController < ApplicationController

	def new
		@order = Order.new
	end

	def show
		@order = Order.find(params[:id])
		@feed_2_items = @order.feed_2.paginate(page: params[:page])
	end

	def create
	 	@order = Order.new(order_params)	
	 	if @order.save! 	
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

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		pr = order_params.merge(order_status: order_params[:order_status].to_i)
		if @order.update(pr)
			if current_user.admin?
				redirect_to admin_orders_path
			else 
				redirect_to user_path(current_user.id)
			end
		end
	end

	private

		def order_params
			params.require(:order).permit(:user_id, :total_price, :name, 
										  :address, :phone, :order_status)
		end

end




