class PostsController < ApplicationController
  before_action :judge_user?, except: [:index]

  def index
    @posts = Post.order('created_at DESC').includes(:user)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save if @post.include_youtube?
    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.user_id == post.user_id
      post.destroy
      redirect_to user_path(current_user.user_id)
    else
      redirect_to root_path
    end
  end

  private

  def judge_user?
    redirect_to root_path unless user_signed_in?
  end

  def post_params
    params.require(:post).permit(:video_id).merge(user_id: current_user.user_id)
  end
end
