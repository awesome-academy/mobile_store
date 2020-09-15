class ProductsController < ApplicationController

	def index
		
		@products = Product.all
	end
	def show
      @product = Product.find_by id: params[:id]
      @comment = @product.comments.build
      @comments = @product.comments.sort_by_created.paginate(page: params[:page], per_page: 6)
      @product_details = ProductDetail.where(:product_id => params[:id])
	end

	def index
		if params[:type] == "women"
			@products = Product.where(:classify => 1).paginate(page: params[:page])
	    elsif params[:type] == "men"
	    	@products = Product.where(:classify => 0).paginate(page: params[:page])
	    elsif params[:type] == "kid"
	    	@products = Product.where(:classify => 2).paginate(page: params[:page])
	    else
	    	@products = Product.all.paginate(page: params[:page])
	    end
	end

	def destroy
		Product.find(params[:id]).destroy
		flash[:success] = "Product deleted"
		redirect_to products_path
	end

end