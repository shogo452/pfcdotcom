# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index tag_index]
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products_all = Product.all
    @products = @products_all.order(created_at: 'DESC').page(params[:page]).per(4)
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    @likes_ranking = @products_all.limit(3).order(likes_count: 'DESC')
    @favorites_ranking = @products_all.limit(3).order(favorites_count: 'DESC')
    @search_params = product_search_params
    @products_searched = @products.search_product(@search_params).includes([:user])
  end

  def new
    @product = Product.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    render 'new'
  end

  def edit; end

  def create
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']) if Rails.env.development? || Rails.env.production?
    @product = Product.new(product_params)
    if @product.save
      notifier.ping "product:#{@product.name}が投稿されました。" if Rails.env.development? || Rails.env.production?
      flash[:success] = '投稿が完了しました。'
      redirect_to action: :index
    else
      render new_product_path(@product)
    end
  end

  def show
    @product = Product.includes(:reviews).find(params[:id])
    gon.nutrition = [@product.protein, @product.fat, @product.carbo]
    @reviews = @product.reviews.includes(user: { avatar_attachment: :blob }).page(params[:page]).per(4).order(created_at: :desc)
    @review = Review.new
    @average_review = if @product.reviews.blank?
                        0
                      else
                        @product.reviews.average(:rate).round(2)
                      end
    @like = Like.new
    tag_list = @product.tag_list
    @products = Product.all.includes(:users)
    @same_taged_products = @products.tagged_with(tag_list, any: true).page(params[:page]).per(2)
    @same_user_products = @products.includes(:user).where(user_id: @product.user.id).where.not(id: @product.id).page(params[:page]).per(2)
  end

  def update
    if @product.update(product_params)
      flash[:success] = '編集が完了しました。'
      redirect_to action: :index
    else
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
    flash[:success] = '投稿を削除しました。'
    redirect_to root_path
  end

  def tag_index
    @products = Product.tagged_with(params[:tag_name]).includes(:reviews).page(params[:page]).per(9)
    @tag_name = params[:tag_name]
  end

  def tag_search
    @tags = Product.tag_counts_on(:tags).where('name LIKE(?)', "%#{params[:key]}%")
  end

  private

    def product_params
      params.require(:product).permit(:name, :carbo, :fat, :protein, :sugar, :calory,
                                      :price, :purchase_url, :image, :tag_list, :url_type).merge(user_id: current_user.id)
    end

    def product_search_params
      params.fetch(:search, {}).permit(:name)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
