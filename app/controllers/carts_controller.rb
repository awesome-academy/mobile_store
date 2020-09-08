class CartsController < ApplicationController	
	def show
	 	id = params[:id]
		if session[:cart].nil?
			session[:cart] = {}
			session[:cart][id] = 1
		else
			if session[:cart].has_key?(id)
				session[:cart][id] += 1
			else 		
				session[:cart][id] = 1
			end
		end
		redirect_to product_path(id)
	end

	def index	
	end 

	def destroy
		session[:cart].delete(params[:id])
		if session[:cart].empty?
			session[:cart] = nil
			redirect_to carts_path
		else
			redirect_to carts_path
		end
	end 

	def add
		session[:cart][params[:format]] += 1
		redirect_to carts_path
	end 

	def subtract
		session[:cart][params[:format]] -= 1
		if session[:cart][params[:format]] == 0 
			session[:cart].delete(params[:format])
			if session[:cart].empty?
				session[:cart] = nil
				redirect_to carts_path
			else
				redirect_to carts_path
			end
		else
			redirect_to carts_path
		end
	end 


end




