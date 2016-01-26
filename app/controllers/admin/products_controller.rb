class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end
  def edit
    @product = Product.find(params[:product_id])
  end

  def update
    @product = Product.find(params[:product_id])
    if @product.update(product_params)
      redirect_to admin_products_path(@product)
    else
      render :edit
    end
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
    params.require(:product).permit(:titile, :description, :quantity, :price)
  end
end
