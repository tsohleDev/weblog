class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, counter_cache: :comments_counter

  before_create :increment_user_commentcounter
  before_destroy :decrement_user_commentcounter

  private

  def increment_user_commentcounter
    post.increment(:comments_counter).save
  end

  def decrement_user_commentcounter
    post.decrement(:comments_counter).save
  end

  # VALIDATIONS
  # text must not be blank. and must not exceed 1000 characters.
  validates :text, presence: true, length: { maximum: 1000 }
end
