ActiveAdmin.register Product do
  permit_params :name, :user_id, :carbo, :protein, :fat, :calory, :price, :image, :sugar, :purchase_url, :url_type, :tag_list
end
