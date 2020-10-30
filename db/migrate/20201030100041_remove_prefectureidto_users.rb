class RemovePrefectureidtoUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :prefecture_id, :integer
  end
end
