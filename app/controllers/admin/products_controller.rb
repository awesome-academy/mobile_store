class Admin::ProductsController < ApplicationController
 	before_action :require_admin
 
 	def new
 		@product = Product.new
 	end 

 	def create	
 		pr = product_params.merge(classify: product_params[:classify].to_i)
 		@product = Product.new(pr)
 		@product.image.attach(params[:product][:image])
 		size = [0, 1, 2, 3, 4, 5]
		if @product.save!
			size.each do |size|
			@product_detail = @product.product_details.new(
				product_id: @product.id,
				size: size
			)
			@product_detail.save!
			end
			redirect_to root_url
		else
			render 'new'
		end
 	end


	private

	def require_admin
		unless current_user.admin?
		  redirect_to root_path
		end
	end

	def product_params
		params.require(:product).permit(:name, :price, :classify, :image)
	end

end