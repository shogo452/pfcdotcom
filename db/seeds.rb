User.create!(nickname: "ゲストユーザー", email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
User.create!(nickname: "筋トレ太郎", email: 'taro@example.com', password: 'taro123', password_confirmation: 'taro123')
User.create!(nickname: "ダイエット花子", email: 'hanako@example.com', password: 'hanako123', password_confirmation: 'hanako123')
User.create!(nickname: "バルク次郎", email: 'jiro@example.com', password: 'jiro123', password_confirmation: 'jiro123')
User.create!(nickname: "ロカボちゃん", email: 'rowcarbo@example.com', password: 'rowcarbo123', password_confirmation: 'rowcarbo123')

require "csv"

CSV.foreach('db/records.csv', headers: true) do |row|
  Record.create!(
    date: row['date'],
    weight: row['weight'],
    body_fat_percentage: row['body_fat_percentage'],
    user_id: row['user_id']
  )
end