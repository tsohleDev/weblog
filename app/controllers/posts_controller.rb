class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id]) || not_found
    @posts = @user.posts
  end

  def show
    @user = User.find_by_id(params[:user_id]) || not_found
    @posts = @user.posts
    @post = @posts.find_by_id(params[:id]) || not_found
    @comments = @post.comments
  end
end
