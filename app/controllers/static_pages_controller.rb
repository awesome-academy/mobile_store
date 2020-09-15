class StaticPagesController < ApplicationController
  def home
    
  	@products = Product.all
    
  	@order_details = OrderDetail.all
  	if !session[:viewed_product].nil?
  	 @products = session[:viewed_product][0,9].map{ |pr| Product.find_by id: pr.to_i }
  	end
    @products.reject{|product| product.nil? }
   
  end

  def help 
  end

  def about
  end
end
