class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create  
    if (micropost_params[:content].empty? && micropost_params[:picture].nil?)
      render 'static_pages/home'
    else
      @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        respond_to do |format|
        format.html { redirect_to @current_user }
        format.js
      end
      else
      	@feed_items = []
        	render 'static_pages/home'
      end
    end
  end

  def destroy
    @micropost= Micropost.find(params[:id])
    @destroy_id = @micropost.id
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to @current_user }
      format.js
    end
  end
  def likers_post
    @title = "User like Post"
    @micropost  = Micropost.find(params[:id])
    @users = @micropost.likers_post
    render 'show_liker_post'
  end
  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end