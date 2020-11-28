# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    user
    date                  { '2020-02-04' }
    weight                { 67 }
    body_fat_percentage   { 15 }
  end
end
