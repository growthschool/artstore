class ProductsController < ApplicationController
  def index
    @products = Product.order(id: :desc).all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if current_cart.items.include?(@product)
      flash[:warning] = 'You already have the product in cart!'
    else
      current_cart.add_product_to_cart(@product)
      flash[:notice] = 'Add product to cart!'
    end

    redirect_to :back
  end
end
