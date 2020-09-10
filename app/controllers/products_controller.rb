class ProductsController < ApplicationController
	
	def show
      @product = Product.find_by id: params[:id]
      @comment = @product.comments.build
      @comments = @product.comments.sort_by_created.paginate(page: params[:page])
      
	end

end