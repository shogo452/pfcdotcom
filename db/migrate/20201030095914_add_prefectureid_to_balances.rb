class AddPrefectureidToBalances < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :prefecture_id, :integer
  end
end
