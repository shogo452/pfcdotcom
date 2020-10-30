class ChangeDataPrefectureidToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :prefecture_id, :integer
  end
end
