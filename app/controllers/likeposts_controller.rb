class LikepostsController < ApplicationController
	before_action :logged_in_user
	def create
	  	@micropost = Micropost.find(params[:post_id])
	  	current_user.like_post(@micropost)
	  	respond_to do |format|
	      format.html { redirect_to current_user }
	      format.js
	    end
	end

	def destroy
	  	like_post = Likepost.find(params[:id])
	    @micropost = Micropost.find(like_post.post_id)
	  	like_post.destroy
	  	respond_to do |format|
	      format.html { redirect_to current_user }
	      format.js
	    end
	end
end
