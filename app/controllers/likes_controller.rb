class LikesController < ApplicationController
  def create
    like = Like.create(like_params)
    redirect_to root_path
  end

  def destroy
    like = Like.find_by(like_params)
    like.destroy
    redirect_to root_path
  end

  private
  def like_params
    params.permit(:post_id).merge(user_id: current_user.user_id)
  end
end
