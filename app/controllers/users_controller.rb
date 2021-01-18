class UsersController < ApplicationController
  before_action :judge_user?

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts
    @user_liked_posts = @user.liked_posts
  end

  private
  
    def judge_user?
      redirect_to root_path unless user_signed_in?
    end
end
