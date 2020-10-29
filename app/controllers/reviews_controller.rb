class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def review_params
    params.require(:review).permit(:text, :rate).merge(product_id: params[:product_id], user_id: current_user.id)
  end
end