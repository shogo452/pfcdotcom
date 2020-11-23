FactoryBot.define do
  factory :inquiry do
    name { "test" }
    sequence(:email) { Faker::Internet.email }
  end
end
