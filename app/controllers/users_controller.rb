class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find_by_id(params[:id]) || not_found
    @posts = @user.recent_posts
  end
end
