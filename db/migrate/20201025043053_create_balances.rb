class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.references :user, foreign_key: true
      t.integer  :gender, default: 0, null: false
      t.integer :height
      t.integer :weight
      t.integer :age
      t.integer :fitness_type, default: 0, null: false
      t.integer :activity, default: 0, null: false
      t.integer :basal_metabolism
      t.integer :protein_intake
      t.integer :carbo_intake
      t.integer :fat_intake
      t.integer :activity_metabolism
      t.integer :calory_intake
      t.timestamps
    end
  end
end
