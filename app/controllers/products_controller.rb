class ProductsController < ApplicationController

  def index
    @products = Product.includes(:user)
  end

  def new
    @product = Product.new
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

  private
  def product_params
    params.require(:product).permit(:name, :carbo, :fat, :protein, :sugar, :calory, :price, :purchase_url).merge(user_id: current_user.id)
  end

end
