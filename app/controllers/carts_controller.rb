class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
  end

  def checkout

    if current_cart.cart_items.blank?

      flash[:warning] = "Empty"
      redirect_to carts_path and return
    else
      @order = current_user.orders.build
      @info = @order.build_info

    end
  end

    def clean
    current_cart.clean!
    flash[:warning] = "已清空購物車"
    redirect_to carts_path
  end

    def calculate_total!(current_cart)
    self.total = cart.total_price
    self.save
  end

end
