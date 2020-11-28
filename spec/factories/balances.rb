# frozen_string_literal: true

FactoryBot.define do
  factory :balance do
    user
    gender { :male }
    height { 170 }
    weight { 65 }
    age { 28 }
    fitness_type { :diet }
    activity { :low }
  end
end
