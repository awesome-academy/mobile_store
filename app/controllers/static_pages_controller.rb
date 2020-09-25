class StaticPagesController < ApplicationController
  def home
  	@products = Product.all
  	@order_details = OrderDetail.all

  end
end
