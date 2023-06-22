class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # Users can read anything (posts, comments, likes) except destroy
    can :read, :all
    can :create, :all

    can :destroy, Post, author: user
    can :destroy, Comment, author: user

    # Admins can destroy anything
    return unless user.role == 'admin'

    can :destroy, :all
  end
end
