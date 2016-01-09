class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :add_to_cart]
  
  def index
    @products = Product.all
  end
  
  def show
    
  end
  
  def add_to_cart
    if !current_cart.items.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:info] = "You have added #{@product.title} to your cart."
    else
      flash[:warning] = "You already have this item in your cart."
    end

    redirect_to :back
  end
  
  private
    def set_product
      @product = Product.find_by_id(params[:id])
    end
end
