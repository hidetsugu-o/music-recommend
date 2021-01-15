class LikesController < ApplicationController
  before_action :judge_user?
  before_action :set_post

  def create
    Like.create(like_params)
  end

  def destroy
    like = Like.find_by(like_params)
    like.destroy
  end

  private

  def like_params
    params.permit(:post_id).merge(user_id: current_user.user_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def judge_user?
    redirect_to root_path unless user_signed_in?
  end
end
