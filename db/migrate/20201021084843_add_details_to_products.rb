class AddDetailsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :sugar, :decimal, precision: 12, scale: 2
    add_column :products, :purchase_url, :string
  end
end
