class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, counter_cache: :comments_counter
  has_many :likes, dependent: :destroy, counter_cache: :likes_counter
end
