class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @product = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.required(:product).permit(:title, :description, :quantity, :price)
  end
end
