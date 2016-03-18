class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if current_cart.items.include?(@product)
      flash[:warning] = "You have already added this product"
    else
      current_cart.add_product_to_cart(@product, params[:product][:quantity])
      flash[:notice] = "Product added"
    end

    redirect_to :back
  end
end
