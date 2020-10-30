class RemovePrefectureidtoRecords < ActiveRecord::Migration[5.2]
  def change
    remove_column :records, :prefecture_id, :integer
  end
end
