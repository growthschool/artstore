class ProductsController < ApplicationController
  def index
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if !current_cart.items.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你己經成功將 #{@product.title} 加入購物車"
    else
      flash[:warning] = "你的購物車內己有此物品"
    end

    redirect_to :back
  end
end
