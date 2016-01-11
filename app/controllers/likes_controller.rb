class LikesController < ApplicationController
	before_action :logged_in_user
	def create
  	@comment = Comment.find(params[:liked_id])
  	current_user.like(@comment)
  	respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
	end

	def destroy
  	like = Like.find(params[:id])
    @comment = Comment.find(like.liked_id)
  	like.destroy
  	respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
	end
end
