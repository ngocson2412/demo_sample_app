class LikesController < ApplicationController
	before_action :logged_in_user
	def create
    	comment = Comment.find(params[:liked_id])
    	current_user.like(comment)
    	redirect_to root_url
  	end

  	def destroy
    	like = Like.find(params[:id])
    	like.destroy
    	redirect_to root_url
  	end
end
