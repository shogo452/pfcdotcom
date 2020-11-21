class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :tag_index, :set_search]
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.includes(:reviews).page(params[:page]).per(4)
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    @likes_ranking = @products.order(likes_count: "DESC").limit(3)
    @favorites_ranking = @products.order(favorites_count: "DESC").limit(3)
    @search_params = product_search_params
    @products_searched = @products.search_product(@search_params)
  end

  def new
    @product = Product.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    render "new"
  end

  def edit
  end

  def create
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']) if Rails.env.development? || Rails.env.production?
    @product = Product.new(product_params)
    if @product.save
      notifier.ping "product:#{@product.name}が投稿されました。" if Rails.env.development? || Rails.env.production?
      flash[:success] = "投稿が完了しました。"
      redirect_to action: :index
    else
      render new_product_path(@product)
    end
  end

  def show
    @product = Product.includes(:reviews).includes(:users).find(params[:id])
    gon.nutrition = [@product.protein, @product.fat, @product.carbo]
    @reviews = @product.reviews.page(params[:page]).per(4)
    @review = Review.new
    if @product.reviews.blank?
      @average_review = 0
    else
      @average_review = @product.reviews.average(:rate).round(2)
    end
    @like = Like.new
    tag_list = @product.tag_list
    @products = Product.all
    @same_taged_products = @products.tagged_with(tag_list, :any => true).page(params[:page]).per(2)
    @same_user_products = @products.where(user_id: @product.user.id).page(params[:page]).per(2).where.not(id: @product.id)
  end

  def update
    if @product.update(product_params)
      flash[:success] = "編集が完了しました。"
      redirect_to action: :index
    else
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
    flash[:success] = "投稿を削除しました。"
    redirect_to root_path
  end

  def tag_index
    @products = Product.tagged_with(params[:tag_name]).page(params[:page]).per(9)
    @tag_name = params[:tag_name]
    @rates = Review.group(:product_id).average(:rate)
  end

  def get_tag_search
    @tags = Product.tag_counts_on(:tags).where('name LIKE(?)', "%#{params[:key]}%")
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :carbo, :fat, :protein, :sugar, :calory, :price, :purchase_url, :image, :tag_list, :url_type).merge(user_id: current_user.id)
  end

  def product_search_params
    params.fetch(:search, {}).permit(:name)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
