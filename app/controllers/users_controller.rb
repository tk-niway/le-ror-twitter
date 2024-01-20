class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(3).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end
end
