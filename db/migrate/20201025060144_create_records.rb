class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.datetime :date
      t.integer :weight
      t.integer :body_fat_percentage
      t.timestamps
    end
  end
end
