ActiveAdmin.register Review do
  permit_params :user_id, :product_id, :rate, :text 
end
