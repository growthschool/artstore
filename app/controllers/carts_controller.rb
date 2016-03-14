class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def checkout
    @order = current_user.orders.build   # has_many 用 build
    @info  = @order.build_info           # has_one  用 build_xxx
  end

  def clean
    current_cart.clean!
    flash[:warning] = "已清空購物車！"
    redirect_to carts_path
  end
end
