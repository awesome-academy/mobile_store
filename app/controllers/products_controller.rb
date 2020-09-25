class ProductsController < ApplicationController

	def index
		
		@products = Product.all
	end
	def show
      @product = Product.find_by id: params[:id]
      @comment = @product.comments.build
      @comments = @product.comments.sort_by_created.paginate(page: params[:page], per_page: 6)
	end


end