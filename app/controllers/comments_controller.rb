class CommentsController < ApplicationController
  # load_and_authorize_resource

  def index
    render json: @comments, status: :ok
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post = Post.find(params[:post_id])

    if request.format.json?
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      return unless @comment.save

      redirect_to user_posts_path(params[:user_id], params[:post_id])
    end
  end

  def destroy
    comment = Comment.find(params[:id]) || not_found

    respond_to do |format|
      if comment.destroy
        # Successfully deleted the record
        flash[:success] = 'Comment deleted successfully'
      else
        # Failed to delete the record
        flash.now[:error] = 'Error: Comment could not be deleted'
      end
      format.html { redirect_to user_posts_path(params[:user_id], params[:post_id]) }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
