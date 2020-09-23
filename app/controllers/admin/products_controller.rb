class Admin::ProductsController < ApplicationController
 	before_action :require_admin
 
 	def new
 		@product = Product.new
 	end 

 	def create	
 		pr = product_params.merge(classify: product_params[:classify].to_i)
 		@product = Product.new(pr)
 		@product.image.attach(params[:product][:image])
		if @product.save!
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