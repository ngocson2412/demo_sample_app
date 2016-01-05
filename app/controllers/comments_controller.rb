class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
      format.html { redirect_to @current_user }
      format.js
    end
    else
      redirect_to root_url
    end
  end
  def destroy
    @comment= Comment.find(params[:id])
    @destroy_id = @comment.id
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @current_user }
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :picture)
    end

   
end