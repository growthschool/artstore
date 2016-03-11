class CartsController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info #has_one才有的
  end

  def clean
    current_cart.clean!
    redirect_to carts_path, notice: "清除購物車成功"
  end
end
