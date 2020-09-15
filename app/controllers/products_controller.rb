class ProductsController < ApplicationController

	def show
      @product = Product.find_by id: params[:id]
      @comment = @product.comments.build
      @comments = @product.comments.sort_by_created.paginate(page: params[:page], per_page: 6)
      @product_details = ProductDetail.where(:product_id => params[:id])
		if session[:viewed_product].nil?
			session[:viewed_product] = []
			session[:viewed_product] = session[:viewed_product].push(params[:id])
		elsif !session[:viewed_product].include?(params[:id]) 
			session[:viewed_product] = session[:viewed_product].unshift(params[:id])
		elsif session[:viewed_product].include?(params[:id])
			session[:viewed_product] = session[:viewed_product].unshift(params[:id])
			session[:viewed_product] = session[:viewed_product].uniq 	
		end
	end

	def index
		
		if params[:type] == "women"
			@products = Product.where(:classify => 1).paginate(page: params[:page])
	    elsif params[:type] == "men"
	    	@products = Product.where(:classify => 0).paginate(page: params[:page])
	    elsif params[:type] == "kid"
	    	@products = Product.where(:classify => 2).paginate(page: params[:page])
	    elsif params[:type] == "sale_off"
	    @products = Product.where.not(discount: nil).paginate(page: params[:page])
		else
	    	@products = Product.all.paginate(page: params[:page])
	    end
	end

end