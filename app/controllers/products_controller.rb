class ProductsController < ApplicationController
  def index
    @products = Product.order(id: :desc).all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if @product.quantity > 0
      current_cart.add_product_to_cart(@product)
      flash[:notice] = 'Add product to cart!'
      redirect_to :back
    else
      redirect_to :back, alert: 'Product is out of stock!'
    end
  end
end
