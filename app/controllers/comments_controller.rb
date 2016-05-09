class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    if (comment_params[:content].empty? && comment_params[:picture].nil?)
      render 'static_pages/home'
    else
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
  def likers
    @title = "User like Comment"
    @comment  = Comment.find(params[:id])
    @users = @comment.likers
    render 'show_liker'
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :picture)
    end

   
end