class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :name,    null: false
      t.references :user,  foreign_key: true
      t.decimal :carbo,   precision: 12, scale: 2
      t.decimal :protein, precision: 12, scale: 2
      t.decimal :fat,     precision: 12, scale: 2
      t.decimal :calory,  precision: 12, scale: 2
      t.integer :price
      t.text :image
      t.timestamps
    end
  end
end
