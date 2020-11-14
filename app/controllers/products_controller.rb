class ProductsController < ApplicationController
  before_action :set_search
  before_action :authenticate_user!, except: [:index, :tag_index, :set_search]

  def index
    @products = Product.includes(:user).page(params[:page]).per(6)
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    @rates = Review.group(:product_id).average(:rate)
    @likes_ranking = Product.find(Like.group(:product_id).order("count(id) DESC").limit(5).pluck(:product_id))
    @favorites_ranking = Product.find(Favorite.group(:product_id).order("count(id) DESC").limit(5).pluck(:product_id))
    render "index"
  end

  def new
    @product = Product.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    render "new"
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
    @product = Product.new(product_params)
    if @product.save
      notifier.ping "product:#{@product.name}が投稿されました。"
      flash[:success] = "投稿が完了しました。"
      redirect_to action: :index
    else
      render new_product_path(@product)
    end
  end

  def show
    @product = Product.find(params[:id])
    gon.nutrition = [@product.protein, @product.fat, @product.carbo]
    @reviews = @product.reviews.page(params[:page]).per(6)
    @review = Review.new
    if @product.reviews.blank?
      @average_review = 0
    else
      @average_review = @product.reviews.average(:rate).round(2)
    end
    @like = Like.new
    tag_list = @product.tag_list
    @same_taged_products = Product.tagged_with(tag_list, :any => true).page(params[:page]).per(4)
    @same_user_products = Product.where(user_id: @product.user.id).page(params[:page]).per(4).where.not(id: @product.id)
    @rates = Review.group(:product_id).average(:rate)
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "編集が完了しました。"
      redirect_to action: :index
    else
      redirect_to edit_ptoduct_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy if @product.user_id == current_user.id
    flash[:success] = "投稿を削除しました。"
    redirect_to root_path
  end

  def tag_index
    @products = Product.tagged_with(params[:tag_name]).page(params[:page]).per(9)
    @tag_name = params[:tag_name]
    @rates = Review.group(:product_id).average(:rate)
  end

  def set_search
    @search = Product.ransack(params[:q])
    @search_products = @search.result.includes(:user).order("created_at DESC").page(params[:page]).per(6)
  end

  def get_tag_search
    @tags = Product.tag_counts_on(:tags).where('name LIKE(?)', "%#{params[:key]}%")
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :carbo, :fat, :protein, :sugar, :calory, :price, :purchase_url, :image, :tag_list, :url_type).merge(user_id: current_user.id)
  end

end
