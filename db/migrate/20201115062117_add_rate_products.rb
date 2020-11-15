class AddRateProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :ave_rate, :decimal, precision: 2, scale: 1
  end
end
