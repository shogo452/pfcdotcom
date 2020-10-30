class RenameAreaColumnToPrefectureIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :area, :prefecture_id
  end
end
