class AddColumnProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :url_type, :integer
  end
end
