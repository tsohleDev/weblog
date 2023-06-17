class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, counter_cache: :likes_counter

  before_create :increment_user_likecounter
  before_destroy :decrement_user_likecounter

  private

  def increment_user_likecounter
    post.increment(:likes_counter).save
  end

  def decrement_user_likecounter
    post.decrement(:likes_counter).save
  end

  # VALIDATIONS
  # should validate uniqueness of author_id scoped to post_id
  validates :author_id, uniqueness: { scope: :post_id }
end
