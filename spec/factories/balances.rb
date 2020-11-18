FactoryBot.define do
  factory :balance do
    user
    gender { 1 }
    height { 170 }
    weight { 65 }
    age { 28 }
    fitness_type { 1 }
    activity { 1 }
  end
end
