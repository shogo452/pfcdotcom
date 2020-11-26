# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    user
    product
    rate { 3 }
  end
end
