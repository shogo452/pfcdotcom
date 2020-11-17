class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: :reviews_count
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
end
