class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    micropost = Micropost.find(params[:micropost_id])
    @comment = micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back_or current_user
    else
      redirect_to root_url
    end
  end
  def destroy
    @comment= Comment.find(params[:id])
    @comment.destroy
    # flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :picture)
    end

   
end