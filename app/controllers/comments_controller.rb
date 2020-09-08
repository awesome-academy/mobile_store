class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]
	before_action :find_comment, only: [:edit, :update, :destroy, :correct_user]
	before_action :correct_user, only: [:edit, :update]
	after_action :add_ajax, only: [:edit, :update, :destroy]
	def create
		@product = Product.find_by id: comment_params[:product_id]
		@comment = @product.comments.build(comment_params)
		@comment.user= current_user
		if @comment.save!
			flash[:success] = "Comment created!"
			
		end
		respond_to do |format|
				format.html {render_to @product}
				format.js
		end
		
	end

	def show
		
		
	end
	def edit
	
	end

	def update
		if @comment.update(comment_params)
			flash[:success] = " update successful"
		
		end
	end

	def destroy
		@comment.destroy
		
		
	end

	


	private

	def find_comment
		@comment = Comment.find_by id: params[:id]
		if @comment.nil?
       		flash[:danger] = 'Do not find comment'
       		redirect_to root_url
       	end
 	 	
 	end

 	def correct_user
	 	
	 	@user = @comment.user
		redirect_to(root_url) unless current_user.current_user?(@user)
 	end

	def comment_params
		params.require(:comment).permit(:content, :product_id, :user_id)
	end

	def add_ajax
		
		respond_to do |format|
			format.html {redirect_to @comment.product}
			format.js
		end

	end
 	 
end
