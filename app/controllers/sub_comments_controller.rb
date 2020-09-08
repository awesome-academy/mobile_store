class SubCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :find_subcoment, only: [:edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update]
	def new
		@sub_comment= SubComment.new
		@comment = Comment.find_by id: params[:comment_id]
    respond_to do |format|
        format.html { redirect_to @comment}
        format.js
        end
	end

	def create

		@comment = Comment.find_by id: params[:comment_id]
		@sub_comment = @comment.sub_comments.build(sub_comment_params)
		@sub_comment.user = current_user
		if @sub_comment.save!
			flash[:success] = "SubComment created!"
      respond_to do |format|
        format.html { redirect_to @comment}
        format.js
        end
      
    end	
  end


    def edit

      respond_to do |format|
        format.html { redirect_to @sub_comment.comment}
        format.js
        end
    end

    def update
    	if @sub_comment.update(sub_comment_params)
  			flash[:success] = " update successful"
        respond_to do |format|
          format.html { redirect_to @sub_comment.comment.product}
          format.js
     		 end
      end
   
   	end
   	def destroy
   		@sub_comment.destroy
      respond_to do |format|
        format.html { redirect_to @sub_comment.comment.product}
        format.js
   	    end
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
      
      @sub_comment = SubComment.find_by id: params[:id]
      if @sub_comment.nil?
           flash[:error] = 'Do not find comment'
           redirect_to root_url
        end

    end

end
