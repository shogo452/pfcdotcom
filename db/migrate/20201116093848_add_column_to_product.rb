class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :likes_count, :integer
    add_column :products, :favorites_count, :integer
    add_column :products, :reviews_count, :integer
  end
end
