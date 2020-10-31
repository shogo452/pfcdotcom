class ProductsController < ApplicationController

  def index
    @products = Product.includes(:user)
    @tags = ActsAsTaggableOn::Tag.most_used
    @rates = Review.group(:product_id).average(:rate)
    @likes_ranking = Product.find(Like.group(:product_id).order("count(id) DESC").limit(5).pluck(:product_id))
    @favorites_ranking = Product.find(Favorite.group(:product_id).order("count(id) DESC").limit(5).pluck(:product_id))
  end

  def new
    @product = Product.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to action: :index
    end
  end

  def show
    @product = Product.find(params[:id])
    @nutrition = [@product.protein, @product.fat, @product.carbo]
    @reviews = @product.reviews
    @review = Review.new
    if @product.reviews.blank?
      @average_review = 0
    else
      @average_review = @product.reviews.average(:rate).round(2)
    end
    @like = Like.new
    tag_list = @product.tag_list
    @same_taged_products = Product.tagged_with(tag_list, :any => true)
    @same_user_products = Product.where(user_id: @product.user.id)
    @rates = Review.group(:product_id).average(:rate)
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to action: :index
    else
      redirect_to edit_ptoduct_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy if @product.user_id == current_user.id
    redirect_to root_path
  end

  def tag_index
    @products = Product.tagged_with(params[:tag_name]).page(params[:page]).per(9)
    @tag_name = params[:tag_name]
  end

  private
  def product_params
    params.require(:product).permit(:name, :carbo, :fat, :protein, :sugar, :calory, :price, :purchase_url, :image, :tag_list).merge(user_id: current_user.id)
  end

end
