class FavoritesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    current_user.like(product)
    product.created_favorite_notification_by(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    product = Product.find(params[:product_id])
    current_user.unlike(product)
    redirect_back(fallback_location: root_path)
  end
end