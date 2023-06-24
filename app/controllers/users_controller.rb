class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user = current_user

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find_by_id(params[:id]) || not_found
    @posts = @user.recent_posts
  end
end
