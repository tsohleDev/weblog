class ApplicationController < ActionController::Base
  def current_user
    users = User.all
    @current_user = users[0]
  end
end
