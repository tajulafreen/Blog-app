class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(comments: :author)
  end

  def show
    logger.debug(params)
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path, notice: 'Post was successfully created.'
    else
      flash.now[:alert] = 'Something Wrong, Cannot create a new post'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'post was successfully deleted.'
    else
      redirect_to redirect_url, alert: 'Failed to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end
end
