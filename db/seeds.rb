User.create!(nickname: "ゲストユーザー", email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
9.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    nickname: "テストユーザー#{n+1}",
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end
require "csv"

CSV.foreach('db/records.csv', headers: true) do |row|
  Record.create!(
    date: row['date'],
    weight: row['weight'],
    body_fat_percentage: row['body_fat_percentage'],
    user_id: row['user_id']
  )
end

num = 1
CSV.foreach('db/products.csv', headers: true) do |row|
  Product.create!(
    name: row['name'],
    user_id: row['user_id'],
    carbo: row['carbo'],
    fat: row['fat'],
    protein: row['protein'],
    sugar: row['sugar'],
    calory: row['calory'],
    price: row['price'],
    purchase_url: row['purchase_url'],
    image: File.open("#{Rails.root}/db/sample_images/sample#{num}.jpg"),
    tag_list: row['tag_list']
  )
  sleep 0.1
  num += 1
end

CSV.foreach('db/likes.csv', headers: true) do |row|
  Like.create!(
    product_id: row['product_id'],
    user_id: row['user_id']
  )
end

CSV.foreach('db/favorites.csv', headers: true) do |row|
  Favorite.create!(
    product_id: row['product_id'],
    user_id: row['user_id']
  )
end

CSV.foreach('db/reviews.csv', headers: true) do |row|
  Review.create!(
    text: row['text'],
    product_id: row['product_id'],
    user_id: row['user_id'],
    rate: row['rate']
  )
end

CSV.foreach('db/relationships.csv', headers: true) do |row|
  Relationship.create!(
    follow_id: row['follow_id'],
    user_id: row['user_id']
  )
end