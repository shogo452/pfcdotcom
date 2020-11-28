# frozen_string_literal: true

FactoryBot.define do
  factory :inquiry do
    name { 'test' }
    sequence(:email) { Faker::Internet.email }
  end
end
