class Like < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: :likes_count
  validates_uniqueness_of :product_id, scope: :user_id
end
