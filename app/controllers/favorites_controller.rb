# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_product
  def create
    @favorite = current_user.favorites.create(product_id: params[:product_id])
    @product.created_favorite_notification_by(current_user)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, product_id: @product.id)
    @favorite.destroy
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end
end
