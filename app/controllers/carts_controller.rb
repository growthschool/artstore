class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def checkout
    if current_cart.cart_items.count > 0
      @order = current_user.orders.build
      @info = @order.build_info
    else
      flash[:warning] = "購物車內沒有物品"
      redirect_to carts_path
    end
  end

  def clean
    current_cart.clean!
    flash[:warning] = "已清空購物車"
    redirect_to carts_path
  end
end
