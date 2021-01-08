class UsersController < ApplicationController
  def index
    @users = User.includes([:post, like: :post])
  end

  def show
    @user = params[:id]
  end
end
