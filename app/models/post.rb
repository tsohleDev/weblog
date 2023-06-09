class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, counter_cache: :comments_counter
  has_many :likes, dependent: :destroy, counter_cache: :likes_counter

  before_create :increment_user_postcounter
  before_destroy :decrement_user_postcounter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def likes_counter
    likes.count
  end

  def comments_counter
    comments.count
  end

  private

  def increment_user_postcounter
    author.increment(:posts_counter).save
  end

  def decrement_user_postcounter
    author.decrement(:posts_counter).save
  end

  # VALIDATIONS
  # Title must not be blank.
  validates :title, presence: true
  # Title must not exceed 250 characters.
  validates :title, length: { maximum: 250 }
  # CommentsCounter must be an integer greater than or equal to zero.
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # LikesCounter must be an integer greater than or equal to zero.
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
