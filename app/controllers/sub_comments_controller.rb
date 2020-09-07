class SubCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :find_subcoment, only: [:edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update]
	def new
		@sub_comment= SubComment.new
		@comment = Comment.find_by id: params[:comment_id]
	end

	def create

		@comment = Comment.find_by id: params[:comment_id]
		@sub_comment = @comment.sub_comments.build(sub_comment_params)
		@sub_comment.user = current_user
		if @sub_comment.save!
			flash[:success] = "SubComment created!"
			redirect_to @comment.product
    	end
    end	

    def edit
    	@sub_comment = SubComment.find_by id: params[:comment_id]
    	
    end

    def update

    	@sub_comment = SubComment.find_by id: params[:comment_id]
    	
    	if @sub_comment.update(sub_comment_params)
			flash[:success] = " update successful"
   		 end
   		 redirect_to @sub_comment.comment.product
   	end
   	def destroy
   		@sub_comment = SubComment.find_by id: params[:comment_id]
   		@sub_comment.destroy
   		redirect_to @sub_comment.comment.product
   	end

    private

    def sub_comment_params
		  params.require(:sub_comment).permit(:content, :comment_id, :user_id)
	  end

    def correct_user
        @user = @sub_comment.user
        redirect_to(root_url) unless current_user.current_user?(@user)
    end

    def find_subcoment
      @sub_comment = SubComment.find_by id: params[:comment_id]
      if @sub_comment.nil?
           flash[:error] = 'Do not find comment'
           redirect_to root_url
        end

    end

end
