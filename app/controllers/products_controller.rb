class ProductsController < ApplicationController
	
	def show
      @product = Product.find_by id: params[:id]
      @comment = @product.comments.build
      @comments = @product.comments.sort_by_created.paginate(page: params[:page], per_page: 6)
	end

	def destroy
		Product.find(params[:id]).destroy
		flash[:success] = "Product deleted"
		redirect_to products_path
	end

end