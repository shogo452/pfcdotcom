require "csv"

CSV.foreach('db/records.csv', headers: true) do |row|
  Record.create!(
    date: row['date'],
    weight: row['weight'],
    body_fat_percentage: row['body_fat_percentage'],
    user_id: row['user_id']
  )
end