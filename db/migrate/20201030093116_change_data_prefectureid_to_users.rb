class ChangeDataPrefectureidToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :user, :prefecture_id, :integer
  end
end
