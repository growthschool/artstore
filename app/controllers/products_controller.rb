class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if !current_cart.items.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "You've add #{@product.title} into your cart"
    else
      flash[:warning] = "You've already added this item"
    end

    redirect_to :back
  end
end
