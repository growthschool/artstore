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
      flash[:notice]= "您已成功加入商品！"
    else
      flash[:alert]= "商品已經在購物車中了！"
    end

    redirect_to :back
  end
end
