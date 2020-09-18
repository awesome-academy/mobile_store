class Admin::OrdersController < ApplicationController
	before_action :require_admin

	def index
		@orders = Order.paginate(page: params[:page])
	end

	private
	def require_admin
		unless current_user.admin?
		  redirect_to root_path
		end
	end
end