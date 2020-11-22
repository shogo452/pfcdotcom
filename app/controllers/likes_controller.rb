class LikesController < ApplicationController
  before_action :set_product

  def create
    @like = current_user.likes.create(product_id: params[:product_id])
    @product.created_like_notification_by(current_user)
  end

  def destroy
    @like = Like.find_by(product_id: params[:product_id], user_id: current_user.id)
    @like.destroy
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
