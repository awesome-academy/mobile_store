class Admin::OrdersController < ApplicationController
	before_action :require_admin

	def index

		@orders = Order.all
	end

	def show
 		

		@order = Order.find(params[:id])
		@feed_2_items = @order.feed_2
	
	end

	private
	
	def require_admin
		unless current_user.admin?
		  redirect_to root_path
		end
	end
end