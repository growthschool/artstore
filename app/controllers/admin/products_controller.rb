class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end

  end

  def edit

  end

  def update

  end

  private
   def products_params
      params.require(:product).permit(:title,:description,:price,:quantity)
   end
end
