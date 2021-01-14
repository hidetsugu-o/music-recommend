class PostsController < ApplicationController
  def index
    @posts = Post.order('created_at DESC').includes(:user)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    url_slice(@post)
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.user_id == post.user_id
      post.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def url_slice(post)
    url = post.video_id
    if url.include?('=')
      url.slice!('https://www.youtube.com/watch?v=')
    else
      url.slice!('https://youtu.be/')
    end
  end

  def post_params
    params.require(:post).permit(:video_id).merge(user_id: current_user.user_id)
  end
end
