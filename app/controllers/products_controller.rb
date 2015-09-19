class ProductsController < ApplicationController
  def index
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_product
      @product = Product.find(params[:id])
      current_cart.add_product_to_cart(@product)

      redirect_to :back
  end

end
