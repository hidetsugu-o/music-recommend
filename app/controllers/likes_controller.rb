class LikesController < ApplicationController
  before_action :set_post

  def create
    like = Like.create(like_params)
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
end
