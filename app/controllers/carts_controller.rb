class CartsController < ApplicationController	
	after_action :add_ajax, only: [:edit, :destroy]
	def update

		@product = Product.find(params[:id])
		if session[:cart].nil?
			session[:cart] = {}
			session[:cart][params[:id]] = 1
			
		else
			add_product_to_cart

		end
		respond_to do |format|
				format.html {redirect_to product_path(@product)}
				format.js
		end
	end

	def index
		@order_details = session[:cart]
		
	end 
             
	def edit

		total
		@product = Product.find(params[:id])
		 @order_details = session[:cart]
		 @product_id = params[:id]
		 @price= @product.discount_price
		if !params[:val].nil?
			
			session[:cart][params[:id]] += 1
			@quantity = session[:cart][params[:id]]	
			@total = @total + @price
			@total_quantity = @total_quantity +1
		else 
			@quantity =	session[:cart][params[:id]]
			if @quantity >0
				session[:cart][params[:id]] -= 1
				@quantity = session[:cart][params[:id]]
				@total = @total - @price
				@total_quantity = @total_quantity -1

			end
		end
		
	end

	def destroy
		@product_will_delete = Product.find(params[:id])
		session[:cart].delete(params[:id])
		total

	end 

	private

	def add_product_to_cart
		if session[:cart].has_key?(params[:id])
			session[:cart][params[:id]] += 1
		else 		
			session[:cart][params[:id]] = 1
		end
	end

	def add_ajax

		respond_to do |format|
				format.html {redirect_to carts_path}
				format.js
		end
	end
	
	def total
		@total = 0
		@total_quantity = 0
			session[:cart].each do |order_detail|

			 	@product = Product.find(order_detail.first.to_i)
			 	@price = @product.discount_price
			 	@quantity = order_detail.last
			 	@total += @price*@quantity
			 	@total_quantity += @quantity
			end
	end


end
