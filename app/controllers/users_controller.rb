class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(3).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @followed_users = @user.followed
    @follower_users = @user.follower
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def followers
    user = User.find(params[:id])
    @users = User.where(id: user.followed.pluck(:followed_id)).order(created_at: :desc).page(params[:page]).per(3)
  end

  def follows
    user = User.find(params[:id])
    @users = User.where(id: user.follower.pluck(:follower_id)).order(created_at: :desc).page(params[:page]).per(3)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
