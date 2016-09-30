class V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update]

  def index
    @products = Product.active
  end

  def show
  end

  def update
    @product.update product_params
    render :show
  end

  def create
    @product = Product.create product_params
    render :show
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :code, :active)
  end

  def set_product
    @product = Product.find params[:id]
  end
end
