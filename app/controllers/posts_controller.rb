class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user = User.find_by_id(params[:user_id]) || not_found

    respond_to do |format|
      format.html
      format.json { render json: @user.posts, status: :ok }
    end
  end

  def show
    # use includes to avoid n+1 queries
    # find the user by id and include posts and comments
    @user = User.includes(:posts, posts: [:comments])
      .where(posts: { id: params[:id] })
      .find_by_id(params[:user_id]) || not_found
  end

  def new
    post = Post.new
    user = current_user
    post.author = user
    respond_to do |format|
      format.html { render :new, locals: { post:, user: } }
    end
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.author = @user

    respond_to do |format|
      if @post.save
        flash[:success] = 'Post saved successfully'
        # redirect to root
        format.html { redirect_to user_posts_path(@user) }
      else
        flash[:error] = 'Post failed to save'
        format.html { render :new, locals: { post: @post, user: @user } }
      end
    end
  end

  def destroy
    # use includes to avoid n+1 queries
    post = Post.includes(:comments, :likes).find_by_id(params[:id]) || not_found

    post.comments.destroy_all
    post.likes.destroy_all

    respond_to do |format|
      if post.destroy
        # Successfully deleted the record
        flash[:success] = 'Post deleted successfully'
        format.html { redirect_to "/users/#{current_user.id}/posts" }
      else
        # Failed to delete the record
        flash.now[:error] = 'Error: Post could not be deleted'
        format.html { render :show }
      end
    end
  end

  def like
    # @post = Post.find(params[:id])
    @like = current_user.likes.new
    @like.post_id = params[:id]

    # check if user already liked the post
    return unless @like.save

    if @like.save
      redirect_to user_post_path(@like.post.author_id, @like.post), notice: 'like added successfully'
    else
      redirect_to user_post_path(@post.author_id, @post), notice: 'Failed to add a like'
    end
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text)
  end
end
