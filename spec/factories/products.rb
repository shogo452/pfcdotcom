# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    user
    name { 'test' }
    protein { 12.3 }
    fat { 12.3 }
    carbo { 12.3 }
  end
end
