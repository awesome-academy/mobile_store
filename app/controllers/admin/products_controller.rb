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

 	def show
 		@product = Product.find_by id: params[:id]
 	end

 	def index
		if params[:type] == "women"
			@products = Product.women.paginate(page: params[:page])
	    elsif params[:type] == "men"
	    	@products = Product.men.paginate(page: params[:page])
	    elsif params[:type] == "kid"
	    	@products = Product.kid.paginate(page: params[:page])
	 	elsif params[:type] == "sale_off"
	    	@products = Product.where.not(discount: nil).paginate(page: params[:page])
	    else
	    	@products = Product.all.paginate(page: params[:page])
	    end
	end
	    


	def edit
		@product = Product.find_by(id: params[:id])
	end
	def update
		@product = Product.find_by(id: params[:id])
		pr = product_params.merge(classify: product_params[:classify].to_i)
		if @product.update(pr)
			flash[:success] = "Profile updated"
			redirect_to admin_products_path
		end
	end

	def destroy

		Product.find_by(id: params[:id]).destroy
		flash[:success] = "Product deleted"
		redirect_to admin_products_path
	end



	private

	def require_admin
		unless current_user.admin?
		  redirect_to root_path
		end
	end

	def product_params
		params.require(:product).permit(:name, :price, :classify, :image, :discount)
	end

end