class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    logger.debug(params)
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @post.likes.build
    @like.user_id = current_user
    if @like.save
      flash[:success] = 'Liked the post!'
    else
      flash[:error] = 'Something went wrong while liking the post.'
    end

    redirect_to user_post_path(@user, @post)
  end
end
